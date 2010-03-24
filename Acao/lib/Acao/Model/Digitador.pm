package Acao::Model::Digitador;
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
use XML::Compile::Util;
use DateTime;

use constant DIGITACAO_NS =>
  'http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd';

my $controle =
  XML::Compile::Schema->new( Acao->path_to('schemas/controledigitacao.xsd') );
my $controle_w = $controle->compile(
    WRITER                => pack_type( DIGITACAO_NS, 'registroDigitacao' ),
    use_default_namespace => 1
);

txn_method 'listar_leituras' => authorized 'digitador' => sub {
    my $self = shift;

    # sera dentro de uma transacao, e so pode ser usado por digitadores
    return $self->dbic->resultset('Leitura')->search(
        { 'digitadores.dn' => $self->user->id },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'digitadores',
        }
    );
};

txn_method 'obter_leitura' => authorized 'digitador' => sub {
    my ( $self, $id_leitura ) = @_;

    return $self->dbic->resultset('Leitura')->find(
        {
            'digitadores.dn' => $self->user->id,
            'me.id_leitura'  => $id_leitura,
        },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'digitadores',
        }
    );
};

txn_method 'obter_xsd_leitura' => authorized 'digitador' => sub {
    my ( $self, $leitura ) = @_;
    return $self->sedna->get_document( $leitura->instrumento->xml_schema );
};

txn_method 'salvar_digitacao' => authorized 'digitador' => sub {
    my ( $self, $leitura, $xml, $controle, $ip ) = @_;
    my $docname = join '_', 'digitacao',
      $leitura->instrumento->projeto->id_projeto, $leitura->instrumento->nome,
      $leitura->id_leitura, $self->user->id, time;
    $docname =~ s/[^a-zA-Z0-9]/_/gs;

    my $xq =
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd"; 
	      for $x in
              collection("leitura-'
      . $leitura->id_leitura
      . '")/cd:registroDigitacao/cd:documento[cd:controle="'
      . $controle . '"]
              return data($x/cd:estadoControle)';
    $self->sedna->execute($xq);
    while ( my $estadoGrupo = $self->sedna->get_item ) {
        if ( $estadoGrupo eq "Fechado" ) {
            die "formulario-fechado";
        }
    }

    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in doc("'
          . $leitura->instrumento->xml_schema . '") return $x'
    );
    my $xsd = $self->sedna->get_item;

    my $x_c_s    = XML::Compile::Schema->new($xsd);
    my @elements = $x_c_s->elements;

    my $read = $x_c_s->compile( READER => $elements[0] );
    my $writ =
      $x_c_s->compile( WRITER => $elements[0], use_default_namespace => 1 );

    my $input_doc = XML::LibXML->load_xml( string => $xml );
    my $element   = $input_doc->getDocumentElement;
    my $xml_data  = $read->($element);

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $conteudo_registro = $writ->( $doc, $xml_data );
    my $res_xml = $controle_w->(
        $doc,
        {
            digitacao => {
                digitador      => $self->user->id,
                dataDigitacao  => DateTime->now(),
                localDigitacao => $ip,
            },
            leitura => {
                id           => $leitura->id_leitura,
                coletaIni    => $leitura->coleta_ini,
                coletaFim    => $leitura->coleta_fim,
                digitacaoIni => $leitura->digitacao_ini,
                digitacaoFim => $leitura->digitacao_fim,
                revisaoIni   => $leitura->revisao_ini,
                revisaoFim   => $leitura->revisao_fim,
                instrumento  => {
                    nome      => $leitura->instrumento->nome,
                    xmlSchema => $leitura->instrumento->xml_schema,
                    projeto   => {
                        id   => $leitura->instrumento->projeto->id_projeto,
                        nome => $leitura->instrumento->projeto->nome,
                    },
                },
            },
            documento => {
                id             => $docname,
                controle       => $controle,
                estadoControle => 'Aberto',
                estado         => 'Digitado',
                conteudo       => { "{}conteudo" => $conteudo_registro },
            }
        }
    );

    $self->sedna->conn->loadData( $res_xml->toString, $docname,
        'leitura-' . $leitura->id_leitura );
    $self->sedna->conn->endLoadData();
};

42;
