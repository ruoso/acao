package Acao::Model::Usuario;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use utf8;
use warnings;
use Digest::SHA qw(sha1_base64 sha1);
use List::MoreUtils qw{uniq};
use Net::LDAP::Control::Paged;
use Net::LDAP::Constant qw( LDAP_CONTROL_PAGED );
use Switch;

use Carp qw(croak);
extends 'Acao::Model::LDAP';

sub buscar_usuarios {
    my ( $self, $args ) = @_;
    my $pesquisa;
    my $campo = $args->{campo} || 'uid=*';
    if ( !$args->{pesquisa} ) {
        $pesquisa = '';

    }
    else {
        $pesquisa = $args->{pesquisa} . '*';
    }

    my $attrs  = $args->{attrs} || qw(*);
    my $filter = $campo . $pesquisa;

    my $base = $self->dominios_dn;
    my $mesg =
      $self->searchLDAP(
        { attrs => $attrs, filter => $filter, base => $base } );

    my $i;
    my @dn_s;
    my %dados;
    my @nome;
    my @usuarios;
    my @arrayMemberOf;
    my $memberOf;
    my $base_acao = $self->base_acao;

#isto é necessário pois, por alguma razão, o ConfigLoader não seta a flag de unicode na string //sikora
    utf8::decode($base_acao);

    #warn "XXXXX: ".utf8::is_utf8($base_acao);

    my $max = $mesg->count;
    for ( $i = 0 ; $i < $max ; $i++ ) {
        my $entry = $mesg->entry($i);

        $memberOf = $self->getDadosUsuarioLdap( $entry->dn )->{memberOf};



        if ( ref($memberOf) eq 'ARRAY' ) {
            $memberOf = join( ',', @$memberOf );
        }
        else {
            $memberOf = '';

        }
        $memberOf  =~ s/çã/ca/go;
        $base_acao =~ s/çã/ca/go;

        if ( $memberOf =~ /$base_acao/ ) {

            %dados = (
                %dados,
                (
                    $entry->dn => {
                        nome     => $entry->get_value('cn'),
                        uid      => $entry->get_value('uid'),
                        memberOf => $memberOf
                    }
                )
            );
        }

    }
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return %dados;
}

=item getDadosUsuarioLdap
Coleta os dados do usuario no LDAP, passando como parametro a DN e FILTRO como opcional.
O Filtro serve para filtrar os memberOf como: 'acao', 'adm';

=cut

sub getDadosUsuarioLdap {
    my ( $self, $dn, $filtro ) = @_;
    my $ldap = $self->_bind_ldap_admin($self);
    my @args = (
        base   => $self->dominios_dn,
        filter => "(&(entryDN=" . $dn . "))",
        scope  => 'sub',
        attrs  =>
          [qw/cn sn uid givenName email mobile telephoneNumber memberOf/],
    );
    my $mesg = $ldap->search(@args);
    my $memberOf;
    my @memberOfArray;
    my $base_acao = $self->base_acao;
    my $base_adm  = $self->base_adm;
    utf8::decode($base_adm);
    switch ($filtro) {
        case "acao" {
            $memberOf = [ $mesg->entry->get_value('memberOf') ];
            foreach my $mOf (@$memberOf) {
                if ( ( $mOf =~ /$base_acao/ ) ) {
                    push @memberOfArray, $mOf;
                }
            }
            $memberOf = \@memberOfArray;
        }
        case "adm" {
            $memberOf = [ $mesg->entry->get_value('memberOf') ];
            foreach my $mOf (@$memberOf) {
                if ( ( $mOf =~ /$base_adm/ ) ) {
                    push @memberOfArray, $mOf;
                }
            }
            $memberOf = \@memberOfArray;
        }
        else {

            $memberOf = [ $mesg->entry->get_value('memberOf') ];
        }
    }

    my $super = join( ',', @$memberOf );
    my $admin_super = $self->admin_super;
    $super =~ s/$admin_super/1/go;

    return {
        uid       => $mesg->entry->get_value('uid'),
        nome      => $mesg->entry->get_value('cn'),
        sobrenome => $mesg->entry->get_value('sn'),
        apelido   => $mesg->entry->get_value('givenName'),
        email     => [ $mesg->entry->get_value('email') ],
        celular   => [ $mesg->entry->get_value('mobile') ],
        fone      => [ $mesg->entry->get_value('telephoneNumber') ],
        admin     => $super,
        dn        => $dn,
        memberOf  => $memberOf,
    };

}

sub searchLDAP {
    my ( $self, $args ) = @_;
    my $ldap = $self->_bind_ldap_admin($self);
    my $page = Net::LDAP::Control::Paged->new( size => 5 );
    my @args = (
        base   => $args->{base},
        filter => "(&(" . $args->{filter} . "))",
        scope  => 'sub',
        attrs  => [ $args->{attrs} ],

        #   control => [$page]
    );

    my $mesg = $ldap->search(@args);

=coments    my $cookie;

    while (1) {

        # Perform search
        my $mesg = $ldap->search(@args);

        # Only continue on LDAP_SUCCESS
        $mesg->code and last;


        # Get cookie from paged control
        my ($resp) = $mesg->control(LDAP_CONTROL_PAGED) or last;

        $cookie = $resp->cookie and last;


        # Set cookie in paged control
        my $page->cookie($cookie);

    }
    if ($cookie) {

       # We had an abnormal exit, so let the server know we do not want any more
        $page->cookie($cookie);
        $page->size();
        $mesg = $ldap->search(@args);
    }
=cut

    return $mesg;

}

sub storeUsuario {
    my ( $self, $args ) = @_;
    my $host     = $self->ldap_admin_config->{host};
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

    my $NewDN  = @$createArray[4] . '=' . @$createArray[5] . ',' . $DNbranch;
    my $result = $self->LDAPentryCreate( $NewDN, $createArray );

    if ( $result->{resultCode} ne '0' ) { return $result; }

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
            Acao->config->{'Model::LDAP'}->{'admin_super'}, $NewDN );
    }

    return $result;

    #

}

1;

