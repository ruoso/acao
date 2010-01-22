package Acao::Controller::Auth::Registros::Digitador::Leitura;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Digitador::Leitura - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/auth/registros/digitador/base') :PathPart('') :CaptureArgs(1) {
    my ($self, $c, $id_leitura) = @_;
    $c->stash->{leitura} = $c->model('Digitador')->obter_leitura($id_leitura);
}

sub form :Chained('base') :PathPart('') :Args(0) {
}

sub store :Chained('base') :PathPart('store') :Args(0) {    
}

sub xsd :Chained('base') :PathPart('xsd') :Args(0) {
  my ($self, $c) = @_;
  $c->stash->{document} = $c->model('Digitador')->obter_xsd_leitura($c->stash->{leitura});
  $c->forward($c->view('XML'));
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
