package Acao::Model::XSD;

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

my $role_listar = Acao->config->{'roles'}->{'documento'}->{'listar'};

=head1 NAME

Acao::Model::Volume - Implementa as regras de negócio do papel volume

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de volume.

=head1 METHODS

=cut

txn_method 'obter_xsd' => authorized $role_listar => sub {
    my ( $self, $namespace ) = @_;

    my $xq = 'declare namespace xs="http://www.w3.org/2001/XMLSchema"; 
              for $x in collection("acao-schemas")[xs:schema/@targetNamespace="'
      . $namespace
      . '"] return $x';

    $self->sedna->execute($xq);
    return $self->sedna->get_item();
};

txn_method 'options_xsd' => authorized $role_listar => sub {
    my ( $self, $id_volume, $controle, $assuntos_dn ) = @_;

    my $filter =
      $self->get_filter_classificacoes( $id_volume, $controle, $assuntos_dn );

    my $xq =
        ' declare namespace xhtml="http://www.w3.org/1999/xhtml"; '
      . ' declare namespace xs="http://www.w3.org/2001/XMLSchema"; '
      . ' declare namespace cl="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd"; '
      . ' for $x in collection("acao-schemas") '
      . $filter
      . ' order by $x/xs:schema/xs:element/xs:annotation/xs:appinfo/xhtml:label/text() '
      . ' return <option value="{ $x/xs:schema/@targetNamespace }">{ $x/xs:schema/xs:element/xs:annotation/xs:appinfo/xhtml:label/text() }</option>';
    
    $self->sedna->execute($xq);
    my $ret;
    while ( my $item = $self->sedna->get_item() ) {
        $ret .= $item;
    }

    return $ret;
};

txn_method 'link_xsd' => authorized $role_listar => sub {
    my ( $self, $id_volume, $controle, $assuntos_dn, $xqueryret ) = @_;

    my $filter =
      $self->get_filter_classificacoes( $id_volume, $controle, $assuntos_dn );

    my $xq = 'declare namespace xhtml="http://www.w3.org/1999/xhtml";
              declare namespace xs="http://www.w3.org/2001/XMLSchema";
              declare namespace cl = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";
              for $x in collection("acao-schemas")' . $filter . '
              order by $x/xs:schema/xs:element/xs:annotation/xs:appinfo/xhtml:label/text()
              return ' . $xqueryret;
warn $xqueryret;
warn 'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW';
    $self->sedna->execute($xq);
    my $ret;
    while ( my $item = $self->sedna->get_item() ) {
        $ret .= $item;
    }
    return $ret;
};

sub get_filter_classificacoes {
    my ( $self, $id_volume, $controle, $assuntos_dn ) = @_;

    my %classificacoes = ();

    my $vol_query =
' declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; '
      . ' declare namespace cl = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd"; '
      . ' for $x in collection("volume")/ns:volume[ns:collection = "'
      . $id_volume . '"] '
      . ' return $x/ns:classificacoes/cl:classificacao/text() ';
    $self->sedna->execute($vol_query);
    while ( my $vol_class = $self->sedna->get_item() ) {
        $classificacoes{$vol_class} = 1;
    }

    my $dos_query =
' declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; '
      . ' declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd"; '
      . ' declare namespace cl="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd"; '
      . ' for $x in collection("'
      . $id_volume
      . '")/ns:dossie[ns:controle="'
      . $controle . '"] '
      . ' return $x/ns:classificacoes/cl:classificacao/text()';
    $self->sedna->execute($dos_query);
    while ( my $dos_class = $self->sedna->get_item() ) {
        $classificacoes{$dos_class} = 1;
    }

    my @classificacoes = keys %classificacoes;
    my $filter = join ' or ', map { 'cl:classificacao eq "' . $_ . '"' }
      map {
        /$assuntos_dn$/
          ? substr( $_, 0, 0 - length($assuntos_dn) - 1 )
          : $_
      }
      map { s/^\s+|\s+$//gs; $_ } @classificacoes;
    $filter =
      '[xs:schema/xs:element/xs:annotation/xs:appinfo/cl:classificacoes['
      . $filter . ']]'
      if $filter;

    return $filter;
}

=cut

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
