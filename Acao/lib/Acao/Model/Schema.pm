package Acao::Model::Schema;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use warnings;
use List::MoreUtils qw{uniq};

use Carp qw(croak);
extends 'Acao::Model::LDAP';

sub listar_schemas {
    my ( $self, $c, $filtro ) = @_;
    my @return;

    my $query =
        'declare namespace cs = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";'
        .'declare namespace acao = "http://schemas.fortaleza.ce.gov.br/acao/acao-schemas.xsd";'
        .'for $x in collection("acao-schemas") return '
        .'( <schema>{$x//@targetNamespace/string()}</schema>,'
        .' <class>{$x//cs:classificacoes/cs:classificacao/text()}</class>'
        .')';

    $self->sedna->begin;
    $self->sedna->execute($query);

    #while ( my $item = $self->sedna->get_item ) {
    #    push( @return, $item );
    #}

    $self->sedna->commit;
    warn @return;
    return @return;

}

1;

