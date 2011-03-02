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
      . ' return ($x,'
      . $args->{grid} . '  )';

    return {
        list => $list

    };

}

sub buscar_schemas {
    my ( $self, $template, $filtro ) = @_;
    my @return;

    my $list =
'declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";'
      . 'for $x in collection("acao-schemas")/xs:schema '
      . 'where $x/xs:element/xs:annotation/xs:appinfo/class:classificacoes/class:classificacao/text() = '
      . '"'
      . $filtro . '"'
      . ' return ($x, '
      . $template . ')';

    return { list => $list };
}

sub options_classificacao_xsd {
    my ($self) = @_;

    my $query =
'declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";'
      . 'for $x in collection("acao-schemas")/xs:schema '
      . 'order by $x/xs:element/xs:annotation/xs:appinfo/class:classificacoes/class:classificacao/text()'
      . ' return     '
      . '(<option value="{$x/xs:element/xs:annotation/xs:appinfo/class:classificacoes/class:classificacao/text()}">'
      . '{replace($x/xs:element/xs:annotation/xs:appinfo/class:classificacoes/class:classificacao/text(),"cn=","")}'
      . '</option>)';


    $self->sedna->begin();
    $self->sedna->execute($query);
    my $options;
    my %anterior;
    while ( my $item = $self->sedna->get_item() ) {
        $item =~ s/^\s+//go;
        unless ( $anterior{$item} ) {
            $options .= $item;
            $anterior{$item} = 1;
        }
    }


    $self->sedna->commit;

    return $options;

}
1;

