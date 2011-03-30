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
    my $i;
    my @dn_s;
    my %dados;
    my @nome;
    my @usuarios;
    my @arrayMemberOf;
    my $userData;
    my $memberOf;
    my $base_acao  = $self->base_acao;
    my $admin_acao = $self->admin_super;
    utf8::decode($admin_acao);
    utf8::decode($base_acao);

#   isto é necessário pois, por alguma razão, o ConfigLoader não seta a flag de unicode na string //sikora

    my $campo = $args->{campo} || 'uid=*';
    if ( !$args->{pesquisa} ) {
        $pesquisa = '';
    }
    else {
        $pesquisa = $args->{pesquisa} . '*)(' . $campo . $args->{pesquisa};
    }
    switch ($campo) {
        case 'admin' { $campo = 'memberOf='; $pesquisa = $admin_acao; }

        else {
        }
    }

    my $attrs = $args->{attrs} || qw(*);

    my $filter = $campo . $pesquisa;

    my $base = $self->dominios_dn;

    my $mesg =
      $self->searchLDAP(
        { attrs => $attrs, filter => $filter, base => $base } );

    my $max = $mesg->count;
    for ( $i = 0 ; $i < $max ; $i++ ) {
        my $entry = $mesg->entry($i);

        $userData = $self->getDadosUsuarioLdap( $entry->dn );
        $memberOf = $userData->{memberOf};

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
                        memberOf => $memberOf,
                        admin    => $userData->{admin},
                        acao     => 1
                    }
                )
            );

        }
        else {
            %dados = (
                %dados,
                (
                    $entry->dn => {
                        nome     => $entry->get_value('cn'),
                        uid      => $entry->get_value('uid'),
                        memberOf => $memberOf,
                        admin    => $userData->{admin},
                        acao     => 0
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
acao => mostrará os memberOf somente dos usuários quem possui algum vínculo com o sistema ação.
adm => mostrará os memberOf somente da estrutura administrativa, ou seja de onde o usuário é lotado
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
    my $base_acao   = $self->base_acao;
    my $base_adm    = $self->base_adm;
    my $admin_super = $self->admin_super;
    utf8::decode($base_adm);
    utf8::decode($base_acao);
    utf8::decode($admin_super);
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
    $super =~ s/.*$admin_super.*/1/go or $super = 0;

    return {
        uid       => $mesg->entry->get_value('uid'),
        nome      => $mesg->entry->get_value('cn'),
        sobrenome => $mesg->entry->get_value('sn') || '',
        apelido   => $mesg->entry->get_value('givenName') || '',
        email     => [ $mesg->entry->get_value('email') ] || [],
        celular   => [ $mesg->entry->get_value('mobile') ] || [],
        fone      => [ $mesg->entry->get_value('telephoneNumber') ] || [],
        admin     => $super,
        dn        => $dn,
        memberOf  => $memberOf,
    };

}

sub storeUsuario {
    my ( $self, $args ) = @_;
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
    my $result;

    my $NewDN = @$createArray[4] . '=' . @$createArray[5] . ',' . $DNbranch;
    $result = $self->LDAPentryCreate( $NewDN, $createArray );

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

}

sub storeAlterarUsuario {
    my ( $self, $args ) = @_;

    my $volumeArray    = $args->{volume};
    my $dossieArray    = $args->{dossie};
    my $documentoArray = $args->{documento};
    my $super          = $args->{super};

    my $result;

    foreach my $acao (@$volumeArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'volume'}->{$acao},
            $args->{dn} );

    }
    foreach my $acao (@$dossieArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'dossie'}->{$acao},
            $args->{dn} );
    }
    foreach my $acao (@$documentoArray) {
        $self->LDAPInsertMemberEntry(
            Acao->config->{'roles'}->{'documento'}->{$acao},
            $args->{dn} );
    }

    if ($super) {
        my $teste =
          $self->LDAPInsertMemberEntry(
            Acao->config->{'Model::LDAP'}->{'admin_super'},
            $args->{dn} );
    }

    return { resultCode => 0 };

}

sub validaUser {
    my ( $self, $dn ) = @_;
    my $result = getDadosUsuarioLdap( $self, $dn, 'acao' )->{memberOf};
    return scalar(@$result) > 1 or 0;

}

sub recebePermissoesAcao {
    my ( $self, $dn, $model ) = @_;

    my $usuario = getDadosUsuarioLdap( $self, $dn )->{memberOf};

    my $listar       = Acao->config->{'roles'}->{$model}->{'listar'};
    my $visualizar   = Acao->config->{'roles'}->{$model}->{'visualizar'},
    my $criar      = Acao->config->{'roles'}->{$model}->{'criar'},
    my $alterar    = Acao->config->{'roles'}->{$model}->{'alterar'},
    my $transferir = Acao->config->{'roles'}->{$model}->{'transferir'},

    utf8::decode($listar);
    utf8::decode($visualizar);
    utf8::decode($criar);
    utf8::decode($alterar);
    utf8::decode($transferir);

    my $result = {
        'listar'     => $listar ~~@$usuario,
        'visualizar' => $visualizar ~~@$usuario,
        'criar'      => $criar ~~@$usuario,
        'alterar'    => $alterar ~~@$usuario,
        'transferir' => $transferir ~~@$usuario,

    };
    return $result;

}

1;

