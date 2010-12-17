package Acao::Model::LDAP;
use Net::LDAP;
use Moose;
use Carp qw(croak);
extends 'Catalyst::Model';

has ldap_config => (is => 'ro', required => 1);
has ldap => (is => 'rw', lazy => 1, builder => '_bind_ldap');
has dominios_dn => (is => 'ro', required => 1);

sub _bind_ldap {
  my $self = shift;
  my $host = $self->ldap_config->{host};
  my $conn = Net::LDAP->new($host, %{$self->{ldap_config}})
    or die "$@";
  my $mesg = $conn->bind;
  croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
  return $conn;
}

sub buscar_dominios_auth {
  my $self = shift;
  my $mesg = $self->ldap->search
    ( base   => $self->dominios_dn,
      filter => "(&(objectClass=*))",
      scope  => 'one'
    );
  croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
  return $mesg->sorted('o');
}

1;

