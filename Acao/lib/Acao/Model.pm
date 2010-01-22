package Acao::Model;
use Moose;
with 'Catalyst::Component::InstancePerContext';
has 'user' => (is => 'rw');
has 'dbic' => (is => 'rw');
has 'sedna' => (is => 'rw');

sub build_per_context_instance {
  my ($self, $c) = @_;
  $self->new(user => $c->user,
             dbic => $c->model('DB')->schema,
             sedna => $c->model('Sedna'));
}

1;
