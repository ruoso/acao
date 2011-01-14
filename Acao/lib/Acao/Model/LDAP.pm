package Acao::Model::LDAP;
use Net::LDAP;
use Moose;
use Data::Dumper;


use Carp qw(croak);
extends 'Acao::Model';

has ldap_config => (is => 'ro', required => 1);
has ldap => (is => 'rw', lazy => 1, builder => '_bind_ldap');
has dominios_dn => (is => 'ro', required => 1);
has grupos_dn => (is => 'ro', required => 1);
has assuntos_dn => (is => 'ro', required => 1);

sub build_per_context_instance {
	my ( $self, $c ) = @_;
	return $self->new( user => $c->user,
					   dbic => $c->model('DB')->schema,
					   sedna => $c->model('Sedna'),
					   %{Acao->config->{'Model::LDAP'}})
}

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

sub memberof_grupos_dn {
	my ($self) = @_;
	my $sufix = $self->grupos_dn;
	[ grep { /$sufix$/ } @{$self->user->memberof} ]
}

sub buscar_dn_assuntos {
  my $self = shift;
  my $base = shift || $self->assuntos_dn;
  return $self->_buscar_dn($base);
}

sub buscar_dn_adm {
  my $self = shift;
  my $base = shift || $self->grupos_dn;
  return $self->_buscar_dn($base);
}

sub _buscar_dn {
  my ($self, $base) = @_;
  my $mesg = $self->ldap->search
    ( base   => $base,
      filter => "(&(objectClass=*))",
      scope  => 'one'
    );
  croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
  return $mesg->sorted('o');
}

sub decompose_dn_assuntos {
    $_[0]->decompose_dn($_[1], $_[0]->assuntos_dn)
}

sub decompose_dn_grupos {
    $_[0]->decompose_dn($_[1], $_[0]->grupos_dn)
}

sub decompose_dn {
  [ map { (split /=/)[1] }
    split /,/,
    substr($_[1], 0, 0 - length($_[2])) ];
}

sub buscar_dn_assuntos {
  my $self = shift;
  my $base = shift || $self->grupos_dn;

  my $mesg = $self->ldap->search
    ( base   => $base,
      filter => "(&(objectClass=*))",
      scope  => 'one'

    );
  croak 'LDAP error: ' . $mesg->error if $mesg->is_error;
  return $mesg->sorted('o');
}

1;

