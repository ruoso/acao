package Acao::Model::Volume;
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
use Encode;
use Data::UUID;
use Data::Dumper;

use constant VOLUME_NS =>'http://schemas.fortaleza.ce.gov.br/acao/volume.xsd';
my $controle = XML::Compile::Schema->new( Acao->path_to('schemas/volume.xsd') );
$controle->importDefinitions( Acao->path_to('schemas/auditoria.xsd') );
my $controle_w = $controle->compile( WRITER => pack_type( VOLUME_NS, 'volume' ), use_default_namespace => 1 );
my $controle_r = $controle->compile( READER => pack_type( VOLUME_NS, 'volume') );

my $role_criar = Acao->config->{'roles'}->{'volume'}->{'criar'};
my $role_alterar = Acao->config->{'roles'}->{'volume'}->{'alterar'};

use constant AUDITORIA_NS =>'http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd';
my $controle_audit = XML::Compile::Schema->new( Acao->path_to('schemas/auditoria.xsd') );
my $controle_audit_w = $controle_audit->compile( WRITER => pack_type( AUDITORIA_NS, 'auditoria' ), use_default_namespace => 1 );

=head1 NAME

Acao::Model::Volume - Implementa as regras de negócio do papel volume

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de volume.

=head1 METHODS

=over

=item listar_volumes()

Retorna os volumes os quais o usuário autenticado tem acesso.

=cut

=item criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao ,$ip)

=cut

txn_method 'criar_volume' => authorized $role_criar => sub {
    my $self = shift;
    my ( $nome, $representaVolumeFisico, $classificacao, $localizacao, $ip ) = @_;

    my $ug  = new Data::UUID;
    my $uuid = $ug->create();
    my $str = $ug->to_string($uuid);
    my $doc_name = 'volume-' . $str;

    my $acao = 'insert';
    my $dados = 'create collection ("'.$doc_name.'")';
    my $role = 'role';

    $self->sedna->execute($dados);

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );

    my $res_xml = $controle_w->($doc,
                                {
                                    nome       => $nome,
                                    criacao    => DateTime->now(),
                                    fechamento => '',
                                    arquivamento => '',
                                    collection => $doc_name,
                                    estado => 'aberto',
                                    representaVolumeFisico => $representaVolumeFisico,
                                    classificacao => $classificacao,
                                    localizacao => $localizacao,
                                    autorizacao => {
                                                    principal => $self->user->id,
                                                    role => $role,
                                                    dataIni => DateTime->now(),
                                                    dataFim => '',
                                                    },
                                    audit      =>  { 
#                                                    auditoria => {
#                                                                  data => DateTime->now(),
#                                                                  usuario => $self->user->id,
#                                                                  acao => $acao,
#                                                                  ip => $ip,
#                                                                  dados => $dados,
#                                                                 },
                                                   },
                                },
                               );

    $self->sedna->conn->loadData( $res_xml->toString, $doc_name, 'volume' );
    $self->sedna->conn->endLoadData();

    my $doc_audit = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $audit = $controle_audit_w->($doc_audit,
                                            {
                                              data => DateTime->now(),
                                              usuario => $self->user->id,
                                              acao => 'insert',
                                              ip => $ip,
                                              dados => $dados,
                                            },
                                   );

    my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
                    update insert ('.$audit->toString.') into collection("volume")/ns:volume[ns:collection="'.$doc_name.'"]/ns:audit';
    $self->sedna->execute($xq_audit);

};

txn_method 'alterar_estado' => authorized $role_alterar => sub {
    my $self = shift;
    my ( $id_volume, $estado, $ip ) = @_;

    my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
       $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]/ns:estado with <ns:estado>'.$estado.'</ns:estado> ';
    $self->sedna->execute($xq);

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $audit = $controle_audit_w->($doc,
                                        {
                                          data => DateTime->now(),
                                          usuario => $self->user->id,
                                          acao => 'replace',
                                          ip => $ip,
                                          dados => $xq,
                                        },
                                   );

    my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
                    update insert ('.$audit->toString.') into collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]/ns:audit';
    $self->sedna->execute($xq_audit);

};

txn_method 'auditoria_listar' => authorized 'volume' => sub {
    my $self = shift;
    my ( $ip ) = @_;

    my $dados  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
       $dados .= 'for $x in collection("volume") return $x';

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );

    my $audit = $controle_audit_w->($doc,
                                        {
                                          data => DateTime->now(),
                                          usuario => $self->user->id,
                                          acao => 'list',
                                          ip => $ip,
                                          dados => $dados,
                                        },
                                   );

    my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                    update insert ('.$audit->toString.') into collection("volume")/ns:volume/ns:audit';
    $self->sedna->execute($xq_audit);
};

=cut

=item 

=cut

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
