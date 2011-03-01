package Acao::Model::Schema;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use warnings;
use List::MoreUtils qw{uniq};
use XML::LibXML;
use XML::Compile::Schema;
use XML::Compile::Util;

use Carp qw(croak);
extends 'Acao::Model::LDAP';

sub listar_schemas {
    my ( $self, $args ) = @_;
    my @return;

    my $list =
'declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";'
      . 'for $x in collection("acao-schemas")/xs:schema'
      . ' return ('
      . $args->{grid} . '  )';


    return {
        list => $list

    };

}

sub buscar_schemas {
    my ( $self, $filtro,$template ) = @_;
    my @return;

    my $list =
'declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";'
      . 'for $x in collection("acao-schemas")/xs:schema'
      . 'where $x/xs:element/xs:annotation/xs:appinfo/class:classificacoes/class:classificacao/text() = '
      . $filtro
      . ' return ($x)';

    return {
        list => $list
    };
}

1;

