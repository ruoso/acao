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
$controle->importDefinitions( Acao->path_to('schemas/auditoria.xsd') );
my $controle_w = $controle->compile( WRITER => pack_type( DOCUMENTO_NS, 'documento' ), use_default_namespace => 1 );

my $role_visualizar = Acao->config->{'roles'}->{'documento'}->{'visualizar'};
my $role_criar = Acao->config->{'roles'}->{'documento'}->{'criar'};
my $role_listar = Acao->config->{'roles'}->{'documento'}->{'listar'};

use constant AUDITORIA_NS =>'http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd';
my $controle_audit = XML::Compile::Schema->new( Acao->path_to('schemas/auditoria.xsd') );
my $controle_audit_w = $controle_audit->compile( WRITER => pack_type( AUDITORIA_NS, 'auditoria' ), use_default_namespace => 1 );

=head1 NAME

Acao::Model::Documento - Implementa as regras de negócio do papel volume

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de volume.

=head1 METHODS

=over

=item obter_xsd_dossie()

=cut

txn_method 'obter_xsd_dossie' => authorized $role_visualizar => sub {
    my ( $self, $dossie ) = @_;
    return $self->sedna->get_document( $dossie );
};

=item listar_documentos()

Retorna os dossies os quais o usuário autenticado tem acesso.

=cut

txn_method 'listar_documentos' => authorized $role_listar => sub {
    my ($self, $args) = @_;

    my $declare_namespace  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";';
       $declare_namespace .= 'declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";';
       $declare_namespace .= 'declare namespace adt = "http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";';
       $declare_namespace .= 'declare namespace xhtml = "http://www.w3.org/1999/xhtml";';
	   $declare_namespace .= 'declare namespace xss = "http://www.w3.org/2001/XMLSchema";';

	my $for = 'collection("'.$args->{id_volume}.'")/ns:dossie[ns:controle = "'.$args->{controle}.'" ]';

    my $xquery_for  = 'for $x at $i in '.$for.'/ns:doc/*, ';
       $xquery_for .= ' $y in collection("acao-schemas")/xss:schema/xss:element/xss:annotation/xss:appinfo/xhtml:label/text() ';

    my $xquery_where  = 'where $y/../../../../../@targetNamespace = namespace-uri($x/dc:documento/*/*) ';
       $xquery_where .= 'and '.$args->{where_documentos_validos}.' ';
       $xquery_where .= 'and '.$args->{where_tipo_documento}.' ';

    my $list  = $declare_namespace.' subsequence('.$xquery_for.$xquery_where.' ';
       $list .=                    ' order by $x/dc:criacao descending';
       $list .=                    ' return ($i , '.$args->{xqueryret}.'), ';
       $list .=                    '(('.$args->{interval_ini}.' * '.$args->{num_por_pagina}.') + 1), '.$args->{num_por_pagina}.')';

	#print Dumper($list);
    my $count = $declare_namespace.'count('.$xquery_for.$xquery_where.' return "")';

    $self->auditoria({ ip => $args->{ip}, operacao => 'list', for => $for, dados => $for } );

    return
        {
          list       => $list,
          count      => $count
        };
};
# realiza de auditoria ao efetuar operações nos documentos
sub auditoria  {
    my ($self, $args) = @_;
    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $audit = $controle_audit_w->($doc,
                                    {
                                      data => DateTime->now(),
                                      usuario => $self->user->id,
                                      acao => $args->{operacao},
                                      ip => $args->{ip},
                                      dados => $args->{dados} || '',
                                    },
                               );

    my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                   declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                   update insert ('.$audit->toString.') into '.$args->{for}.'/dc:audit';


    $self->sedna->execute($xq_audit);
}



=item inserir_documento()

=cut


txn_method 'inserir_documento' => authorized $role_criar => sub {
    my $self = shift;
    my ($ip, $xml, $id_volume, $controle, $xsdDocumento, $representaDocumentoFisico, $id_documento) = @_;

    my $role = 'role';

    $self->sedna->execute('for $x in collection("acao-schemas")[xs:schema/@targetNamespace="'.$xsdDocumento.'"] return $x');

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

    my $ug  = new Data::UUID;
    my $uuid = $ug->create();
    my $uuid_str = $ug->to_string($uuid);

    my $conteudo_registro = $writ->( $doc, $xml_data );
    my $res_xml = $controle_w->($doc,
                                {
                                    id         => $uuid_str,
                                    nome       => '',
                                    criacao    => DateTime->now(),
                                    invalidacao => '',
                                    motivoInvalidacao => '',
                                    representaDocumentoFisico => $representaDocumentoFisico,
                                    autorizacao => {
                                                    principal => $self->user->id,
                                                    role => $role,
                                                    dataIni => DateTime->now(),
                                                    dataFim => '',
                                                    },
                                    audit      =>  {},
                                    documento => {
                                                    conteudo => { "{}conteudo" => $conteudo_registro },
                                                }
                                }
                               );

    my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";';
       $xq .= 'update insert ('.$res_xml->toString.') into collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]/ns:doc';

    $self->sedna->execute($xq);

    my $acao = $id_documento eq '' ? 'insert' : 'edit';
    my $doc_audit = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $audit = $controle_audit_w->($doc_audit,
                                            {
                                              data => DateTime->now(),
                                              usuario => $self->user->id,
                                              acao => $acao,
                                              original => $id_documento,
                                              ip => $ip,
                                              dados => $xq,
                                            },
                                   );

   my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                   declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                   update insert ('.$audit->toString.') into collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]/ns:doc/dc:documento[dc:id = "'.$uuid_str.'"]/dc:audit';
   $self->sedna->execute($xq_audit);

    if ($id_documento ne '')
    {
            my $xq_invalidacao  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                                   declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                                   declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
                                   update replace $x in collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]
                                                  /ns:doc/dc:documento[dc:id = "'.$id_documento.'"]/dc:invalidacao
                                                  with <dc:invalidacao>'.DateTime->now().'</dc:invalidacao>';
            $self->sedna->execute($xq_invalidacao);

            my $xq_motivo_invalidacao  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                                          declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                                          declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
                                          update replace $x in collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]
                                                         /ns:doc/dc:documento[dc:id = "'.$id_documento.'"]/dc:motivoInvalidacao
                                                         with <dc:motivoInvalidacao>replace</dc:motivoInvalidacao>';
            $self->sedna->execute($xq_motivo_invalidacao);

    }

};

txn_method 'visualizar' => authorized $role_visualizar => sub {
    my ( $self, $id_volume, $controle, $id_documento, $ip ) = @_;

    my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";';
       $xq .= 'declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";';
       $xq .= 'for $x in collection("'.$id_volume.'")/ns:dossie/ns:doc/* return $x[dc:id="'.$id_documento.'"]/dc:documento/*/*';
    $self->sedna->execute($xq);

    my $xml = $self->sedna->get_item;

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );

    my $audit = $controle_audit_w->($doc,
                                        {
                                          data => DateTime->now(),
                                          usuario => $self->user->id,
                                          acao => 'visualize',
                                          ip => $ip,
                                          dados => $xq,
                                        },
                                   );

   my $xq_audit = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                   declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                   update insert ('.$audit->toString.') into collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]/ns:doc[dc:id="'. $id_documento.'"]/*/dc:audit';

    $self->sedna->execute($xq_audit);

    return $xml;
};


txn_method 'visualizar_por_tipo' => authorized $role_visualizar => sub {
    my ( $self, $id_volume, $controle, $xsdDocumento ) = @_;

    my $xq   = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                declare namespace adt = "http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
                declare namespace xhtml="http://www.w3.org/1999/xhtml";
                declare namespace xss="http://www.w3.org/2001/XMLSchema";
                for $x at $i in collection("'.$id_volume.'")
                /ns:dossie[ns:controle = "'.$controle.'" ]/ns:doc/* ,
                $y in collection("acao-schemas")/xss:schema/xss:element/xss:annotation/xss:appinfo/xhtml:label/text()
                where $y/../../../../../@targetNamespace = namespace-uri($x/dc:documento/*/*)
                and namespace-uri($x/dc:documento/*/*) = "'.$xsdDocumento.'"
                order by $x/dc:criacao descending
                return $x/dc:id/text()';


   $self->sedna->execute($xq);

   #my $xml = $self->sedna->get_item;

    my $controles;

    while(my $controle = $self->sedna->get_item){
        $controles.= $controle.',';
    };

   return $controles;

};





txn_method 'invalidar_documento' => authorized $role_listar => sub {
  my $self = shift;
  my ( $id_volume, $controle, $id_documento) = @_;
  my $xq_invalidacao  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                         declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                         declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
                         update replace $x in collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]
                                        /ns:doc/dc:documento[dc:id = "'.$id_documento.'"]/dc:invalidacao
                                        with <dc:invalidacao>'.DateTime->now().'</dc:invalidacao>';

  $self->sedna->execute($xq_invalidacao);

  my $xq_motivo_invalidacao  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                                declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                                declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
                                update replace $x in collection("'.$id_volume.'")/ns:dossie[ns:controle="'.$controle.'"]
                                               /ns:doc/dc:documento[dc:id = "'.$id_documento.'"]/dc:motivoInvalidacao
                                               with <dc:motivoInvalidacao>erro</dc:motivoInvalidacao>';
  $self->sedna->execute($xq_motivo_invalidacao);
};

txn_method 'getDadosDossie' => authorized $role_listar => sub {
    my $self = shift;
    my ($id_volume, $controle) = @_;

    my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
               declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
               for $x in collection("'.$id_volume.'")/ns:dossie
               where $x/ns:controle="'.$controle.'"
               return ($x/ns:nome/text(), $x/ns:classificacao/text(), $x/ns:localizacao/text(), $x/ns:estado/text(), 
                      $x/ns:criacao/text(), $x/ns:representaDossieFisico/text())';

   $self->sedna->execute($xq);

    my $vol = {};
    while(my $nome = $self->sedna->get_item){
        $vol = {
                    nome => $nome,
                    classificacao => $self->sedna->get_item,
                    localizacao   => $self->sedna->get_item,
                    estado        => $self->sedna->get_item,
                    criacao       =>$self->sedna->get_item,
                    dossie_fisico => $self->sedna->get_item > 0 ? 'Sim' : 'Não',
                  };
    };

   return $vol;
};

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
