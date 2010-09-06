package Acao::Model::Documento;
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

use constant DOCUMENTO_NS =>'http://schemas.fortaleza.ce.gov.br/acao/documento.xsd';
my $controle = XML::Compile::Schema->new( Acao->path_to('schemas/documento.xsd') );
my $controle_w = $controle->compile( WRITER => pack_type( DOCUMENTO_NS, 'documento' ), use_default_namespace => 1 );

=head1 NAME

Acao::Model::Documento - Implementa as regras de negócio do papel volume

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de volume.

=head1 METHODS

=over

=item obter_xsd_dossie()

=cut

txn_method 'obter_xsd_dossie' => authorized 'volume' => sub {
    my ( $self, $dossie ) = @_;
    return $self->sedna->get_document( $dossie );
};

=item inserir_documento()

=cut

txn_method 'inserir_documento' => authorized 'volume' => sub {
    my $self = shift;
    my ($ip, $xml, $id_volume, $controle, $xsdDocumento ) = @_;
    
    my($nome, $representaDossieFisico, $classificacao, $localizacao);
    my $acao = 'inserir';
    my $dados = '';
    my $dataIni = DateTime->now();
    my $dataFim = DateTime->now();
    my $role = 'role';

    $self->sedna->execute(' for $x in collection("acao-schemas")
                            [xs:schema/@targetNamespace="'.$xsdDocumento.'"] return $x');

    my $xsd = $self->sedna->get_item;
    my $octets = encode('utf8', $xsd);

    my $x_c_s    = XML::Compile::Schema->new($octets);
    my @elements = $x_c_s->elements;

    my $read = $x_c_s->compile( READER => $elements[0] );
    my $writ = $x_c_s->compile( WRITER => $elements[0], use_default_namespace => 1 );
    my $xml_en = encode('utf8', $xml);

    my $input_doc = XML::LibXML->load_xml( string => $xml_en );

    my $element   = $input_doc->getDocumentElement;
    my $xml_data  = $read->($element);

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );

    my $conteudo_registro = $writ->( $doc, $xml_data );
    my $res_xml = $controle_w->($doc,
                                {
                                    nome       => 'a',
                                    criacao    => DateTime->now(),
                                    invalidacao => DateTime->now(),
                                    representaDocumentoFisico => 1,
                                    classificacao => 'c',
                                    autorizacao => {
                                                    principal => $self->user->id,
                                                    role => $role,
                                                    dataIni => $dataIni,
                                                    dataFim => $dataFim,
                                                    },
                                    auditoria => {
                                                    data => DateTime->now(),
                                                    usuario => $self->user->id,
                                                    acao => $acao,
                                                    ip => $ip,
                                                    dados => $dados,
                                                    },
                                    documento => {
                                                    conteudo       => { "{}conteudo" => $conteudo_registro },
                                                }
                                }
                               );

    my $xq = ('declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; 
               UPDATE insert ('.$res_xml->toString.') into collection("'.$id_volume.'")/ns:dossie[ns:controle='.$controle.']/ns:doc' );
warn $xq;
    $self->sedna->execute($xq);
};

txn_method 'visualizar' => authorized 'volume' => sub {
    my ( $self, $id_volume, $controle, $id_documento ) = @_;
#    my $xq = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; 
#                            for $x in collection("'.$id_volume.'")[ns:dossie/ns:documento/ns:controle = '.$controle.' and 
#                            ns:dossie/ns:documento/ns:conteudo] 
#                            return $x/ns:dossie/ns:doc/ns:documento/ns:conteudo/*['.$id_documento.']';

    my $xq = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; 
                     for $x in collection("'.$id_volume.'")/ns:dossie/ns:doc/*['.$id_documento.']  return $x/*/*/*';
     $self->sedna->execute($xq);
     my $xml = $self->sedna->get_item;
     return $xml;
};


=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
