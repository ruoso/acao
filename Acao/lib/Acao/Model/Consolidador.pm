package Acao::Model::Consolidador;
# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;
use DateTime;
use XML::Compile::Util qw(pack_type);

use constant CONSOLIDACAO_NS =>
  'http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd';

my $controle =
  XML::Compile::Schema->new(
    Acao->path_to('schemas/controleconsolidacao.xsd')
  );

my $entradas_r =
  $controle->compile( READER => pack_type( CONSOLIDACAO_NS, 'entradas' ) );

txn_method 'listar_definicao_consolidacao' => authorized 'consolidador' => sub {
    my $self = shift;

    # sera dentro de uma transacao, e so pode ser usado por consolidadores
    return $self->dbic->resultset('DefinicaoConsolidacao')->search(
        { 'consolidador.dn' => $self->user->id },
        {
            prefetch => 'projeto',
            join     => 'consolidador',
        }
    );
};

txn_method 'obter_definicao_consolidacao' => authorized 'consolidador' => sub {
    my ( $self, $id_definicao_consolidacao ) = @_;
    return $self->dbic->resultset('DefinicaoConsolidacao')->find(
        {
            'consolidador.dn'              => $self->user->id,
            'me.id_definicao_consolidacao' => $id_definicao_consolidacao
        },
        {
            prefetch => 'projeto',
            join     => 'consolidador',
        }
    );
};

txn_method 'obter_consolidacao' => authorized 'consolidador' => sub {
    my ( $self, $id_consolidacao ) = @_;
    return $self->dbic->resultset('Consolidacao')->find(
        {
            'consolidador.dn'    => $self->user->id,
            'me.id_consolidacao' => $id_consolidacao
        },

# prefetch tem funcao similar a do join diferenciando por trazer os elementos na clausula select
        {
            prefetch => [
                'alertas',
                { 'definicao_consolidacao' => [ 'consolidador', 'projeto' ] }
            ],
        }
    );
};

txn_method 'iniciar_consolidacao' => authorized 'consolidador' => sub {
    my ( $self, $definicao_consolidacao ) = @_;
    my $consolidacao = $definicao_consolidacao->consolidacao->create(
        {
            status   => 'Criada',
            data_ini => DateTime->now(),
            dn       => $self->user->id
        }
    );

    my $script = Acao->path_to('script/acao_consolida.pl');

    if ( my $pid = fork() ) {
        return $consolidacao;
    }
    else {
        close STDOUT;
        close STDIN;
        my $pid = system( $^X, $script, $consolidacao->id_consolidacao,
            $self->user->id );
        use POSIX ":sys_wait_h";
        waitpid( $pid, WNOHANG );
        exit;
    }
};

txn_method obter_documentos_entrada => authorized 'consolidador' => sub {
    my ( $self, $consolidacao, $id_documento_consolidado ) = @_;
    my $xq = 'declare namespace ab="http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd"; 
              for $x in collection("consolidacao-entrada-'
              . $consolidacao->id_consolidacao
              .'")/ab:registroConsolidacao[ab:documento/ab:id="'
              . $id_documento_consolidado 
              . '"]/ab:consolidacao/ab:entradas return $x';
    $self->sedna->execute($xq);
    my $xml_entradas = $self->sedna->get_item();
    warn $xq;
    if ($xml_entradas) {
        # chama o XML::Compile::Schema para traduzir o XML
        # para um AoH
        my $entradas = $entradas_r->($xml_entradas);
        return $entradas->{entrada};
    } else {
        return [];
    }
};

1;
