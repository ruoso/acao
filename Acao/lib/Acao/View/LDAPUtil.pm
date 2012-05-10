package Acao::View::LDAPUtil;
use Moose;
use Data::Dumper;
extends 'Catalyst::View';

sub voltar_grupos {
    my ( $self, $voltar ) = @_;
    my @voltar = split /,/, $voltar;
    return join ',', splice @voltar, 1;
}

1;
