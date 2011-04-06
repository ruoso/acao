package Acao::Model::LDAP;
use Net::LDAP;
use Moose;
use Data::Dumper;
use strict;
use warnings;
use Net::LDAP::Entry;
use Net::LDAPS;
use IO::Socket::SSL;
use utf8;
use Digest::SHA qw(sha1_base64);

use Carp qw(croak);
extends 'Acao::Model';

has ldap_config       => ( is => 'ro', required => 1 );
has ldap_admin_config => ( is => 'ro', required => 1 );
has ldap => ( is => 'rw', lazy => 1, builder => '_bind_ldap' );
has dominios_dn => ( is => 'ro', required => 1 );
has base_rh => ( is => 'ro', required => 1 );
has grupos_dn   => ( is => 'ro', required => 1 );
has assuntos_dn => ( is => 'ro', required => 1 );
has local_dn    => ( is => 'ro', required => 1 );
has base_acao   => ( is => 'ro', required => 1, isa => 'Str' );
has base_adm    => ( is => 'ro', required => 1 );
has admin_super => ( is => 'ro', required => 1 );

sub build_per_context_instance {
    my ( $self, $c ) = @_;
    return $self->new(
        user  => $c->user,
        dbic  => $c->model('DB')->schema,
        sedna => $c->model('Sedna'),
        %{ Acao->config->{'Model::LDAP'} }
    );
}

sub _bind_ldap {
    my $self = shift;
    my $host = $self->ldap_config->{host};
    my $conn = Net::LDAP->new( $host, %{ $self->{ldap_config} } )
      or die "$@";
    my $mesg = $conn->bind;
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $conn;
}

sub _bind_ldap_admin {
    my $self = shift;
    my $host = $self->ldap_admin_config->{host};
    my $conn = Net::LDAP->new( $host, %{ $self->ldap_admin_config } )
      or die "$@";
    my $mesg = $conn->bind( $self->ldap_admin_config->{dn},
        %{ $self->ldap_admin_config } );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $conn;
}

sub buscar_dominios_auth {
    my $self = shift;
    my $mesg = $self->ldap->search(
        base   => $self->dominios_dn,
        filter => "(&(objectClass=*))",
        scope  => 'one'
    );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $mesg->sorted('o');
}

sub memberof_grupos_dn {
    my ($self) = @_;
    my $sufix = $self->grupos_dn;
    [ grep { /$sufix$/ } @{ $self->user->memberof } ];
}

#sub buscar_dn_assuntos {
#  my $self = shift;
#  my $base = shift || $self->assuntos_dn;
#  return $self->_buscar_dn($base);
#}

sub buscar_dn_local {
    my $self = shift;
    my $base = shift || $self->local_dn;
    return $self->_buscar_dn($base);
}

sub buscar_dn_adm {
    my $self = shift;
    my $base = shift || $self->grupos_dn;
    return $self->_buscar_dn($base);
}

sub _buscar_dn {
    my ( $self, $base ) = @_;
    my $mesg = $self->ldap->search(
        base   => $base,
        filter => "(&(objectClass=*))",
        scope  => 'one'
    );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $mesg->sorted('o');
}

sub decompose_dn_assuntos {
    $_[0]->decompose_dn( $_[1], $_[0]->assuntos_dn );
}

sub decompose_dn_grupos {
    $_[0]->decompose_dn( $_[1], $_[0]->grupos_dn );
}

sub decompose_dn_local {
    $_[0]->decompose_dn( $_[1], $_[0]->local_dn );
}

sub decompose_dn {
    [
        map { ( split /=/ )[1] }
          split /,/,
        substr( $_[1], 0, 0 - length( $_[2] ) )
    ];
}

sub buscar_dn_assuntos {
    my $self = shift;
    my $base = shift || $self->grupos_dn;

    my $mesg = $self->ldap->search(
        base   => $base,
        filter => "(&(objectClass=*))",
        scope  => 'one'

    );
    croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
    return $mesg->sorted('o');
}

sub LDAPentryCreate {
    my ( $self, $dn, $whatToCreate ) = @_;
    my $ldapS = _bind_ldap_admin($self);
    my $result = $ldapS->add( $dn, attrs => [@$whatToCreate] );
    return $result;
}

sub LDAPInsertMemberEntry {
    my ( $self, $lotacao, $memberA ) = @_;
    my $ldapS  = _bind_ldap_admin($self);
    my $result = $ldapS->modify( $lotacao, add => { member => [$memberA] } );
    # Se Existe o usuário, apague e adicione novamente.
    if ($result->{resultCode} eq '20' ) {
        LDAPDeleteMemberEntry($self,$lotacao,$memberA);
        $result = $ldapS->modify( $lotacao, add => { member => [$memberA] } );
    }

    return $result;
}

sub LDAPDeleteMemberEntry {
    my ( $self, $lotacao, $memberA ) = @_;
    my $ldapS  = _bind_ldap_admin($self);
    my $result = $ldapS->modify( $lotacao, delete => { member => [$memberA] } );


    return $result;
}

sub LDAPChangeMemberEntry {
    my ( $self, $dn, $memberOfA, $memberOfDeleteA ) = @_;
    my $ldapS = _bind_ldap_admin($self);
    my $result;


    if ( !$memberOfDeleteA or !$memberOfA ) {
        !$memberOfA
          or $result = $ldapS->modify( $dn, add => { memberOf => $memberOfA } );

        !$memberOfDeleteA
          or $result =
          $ldapS->modify( $dn, delete => { memberOf => $memberOfDeleteA } )
          ;
    }
    else {

        $result = $ldapS->modify(
            $dn,
            changes => [
                delete => [ memberOf => $memberOfDeleteA ],
                add    => [ memberOf => $memberOfA ],
            ]
        );
    }

    return $result;
}

sub searchLDAP {
    my ( $self, $args ) = @_;
    my $ldap = $self->_bind_ldap_admin($self);
    my $page = Net::LDAP::Control::Paged->new( size => 5 );
    my @args = (
        base   => $args->{base},
        filter => "(|(" . $args->{filter} . "))",
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

sub changeMemberPassword {
  my ($self, $args) = @_;
  my $ldap = $self->_bind_ldap_admin($self);
  $args->{new_pass} or $args->{new_pass} = 'default';
  my $encrypted = sha1_base64($args->{new_pass});
  $encrypted .= '=' while (length($encrypted) % 4);
  my $mesg = $ldap->modify($args->{dn}, replace => { userpassword => '{SHA}'.$encrypted });
  return $mesg;
}





1;

