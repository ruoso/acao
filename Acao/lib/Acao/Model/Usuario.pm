package Acao::Model::Usuario;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use warnings;
use Digest::SHA qw(sha1_base64 sha1);
use List::MoreUtils qw{uniq};

use Carp qw(croak);
extends 'Acao::Model::LDAP';

sub buscar_usuarios_ {
    my ($self) = @_;

    my $mesg = $self->ldap->search(
        base   => $self->base_acao,
        filter => "(&(member=*))",
        scope  => 'one'

    );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $mesg->sorted('o');
}

sub buscar_usuarios {
    my $self = shift;
    my $mesg = $self->ldap->search(
        base   => $self->base_acao,
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
        my $dn_user = $dn;
        $dn =~ s/uid=//go;
        @nome = split /,/, $dn;
        push @usuarios,
          {
            nome => $nome[0],
            dn   => $dn_user
          };
    }

    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return @usuarios;
}

sub getDadosUsuarioLdap {
    my ( $self, $dn ) = @_;
    my $mesg = $self->ldap->search(
        base   => $self->dominios_dn,
        filter => "(&(entryDN=" . $dn . "))",
        scope  => 'sub',
        attrs  =>
          [qw/cn sn uid givenName email mobile telephoneNumber memberOf/],
    );

    return {
        uid       => $mesg->entry->get_value('uid'),
        nome      => $mesg->entry->get_value('cn'),
        sobrenome => $mesg->entry->get_value('sn'),
        apelido   => $mesg->entry->get_value('givenName'),
        email     => [ $mesg->entry->get_value('email') ],
        celular   => [ $mesg->entry->get_value('mobile') ],
        fone      => $mesg->entry->get_value('telephoneNumber'),
        dn        => $dn,
        memberOf  => [ $mesg->entry->get_value('memberOf') ],
    };

}

sub storeUsuario {
    my ( $self, $args ) = @_;
    my $host     = $self->ldap_config->{host};
    my $DNbranch = $args->{dominio};
    my $senha    = sha1_base64( $args->{senha} );
    $senha .= '=' while ( length($senha) % 4 );

    my $createArray = [
        objectClass => [
            qw/top person organizationalPerson
              inetOrgPerson recursoHumano simpleSecurityObject
              account/
        ],
        cn              => $args->{nome},
        uid             => $args->{id},
        sn              => $args->{sobrenome},
        givenName       => $args->{nome},
        email           => $args->{email},
        telephoneNumber => $args->{fone},
        userPassword    => '{SHA}' . $senha,

    ];

    my $volumeArray    = $args->{volume};
    my $dossieArray    = $args->{dossie};
    my $documentoArray = $args->{documento};
    my $lotacaoArray   = $args->{lotacao};
    my $super          = $args->{super};

    my $NewDN = @$createArray[4] . '=' . @$createArray[5] . ',' . $DNbranch;
    my $result = $self->LDAPentryCreate( $NewDN, $createArray );

    if ($result->{resultCode} ne '0') { return $result; }


    foreach my $acao (@$volumeArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'volume'}->{$acao}, $NewDN );
    }
    foreach my $acao (@$dossieArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'dossie'}->{$acao}, $NewDN );
    }
    foreach my $acao (@$documentoArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'documento'}->{$acao}, $NewDN );
    }
    foreach my $lotacao (@$lotacaoArray) {
        $self->LDAPInsertMemberEntry( $lotacao, $NewDN );
    }

    if ($super) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'Model::LDAP'}->{'admin_super'}, $NewDN ) ;
    }

    return $result;

    #

}

1;

