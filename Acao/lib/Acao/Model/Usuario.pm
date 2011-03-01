package Acao::Model::Usuario;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use warnings;
use List::MoreUtils qw{uniq};

use Carp qw(croak);
extends 'Acao::Model::LDAP';
my $base_user_acao =
"ou=Ação,dc=sistemas,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br";

sub buscar_usuarios_ {
    my ($self) = @_;

    my $mesg = $self->ldap->search(
        base   => $base_user_acao,
        filter => "(&(member=*))",
        scope  => 'one'

    );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $mesg->sorted('o');
}

sub buscar_usuarios {
    my $self = shift;
    my $mesg = $self->ldap->search(
        base   => $base_user_acao,
        filter => "(&(member=*))",
        scope  => 'sub',
        attrs  => ['member'],

    );
    my $i;
    my @dn_s;
    my @nome;
    my @usuarios;

    # HELP http://search.cpan.org/~gbarr/perl-ldap-0.4001/lib/Net/LDAP/Entry.pod
    my $max = $mesg->count;
    for ( $i = 0 ; $i < $max ; $i++ ) {
        my $entry = $mesg->entry($i);
        foreach my $attr ( $entry->attributes ) {
            push @dn_s, $entry->get_value($attr);
        }
    }

    foreach my $dn ( uniq @dn_s ) {
        $dn =~ s/uid=//go;
        @nome = split /,/, $dn;
        push @usuarios,
          {
            nome => $nome[0],
            dn   => $dn
          };
    }

    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return @usuarios;
}

1;

