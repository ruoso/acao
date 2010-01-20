package Acao::Controller::Auth;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('auth') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    unless ($c->user) {
       $c->res->redirect($c->uri_for('/login'));
       $c->detach;
    }
}

sub principal :Chained('base') :PathPart('') :Args(0) {
    my ($self,$c) = @_;
    $c->res->redirect($c->uri_for('/auth/registros'));
}

sub logout :Chained('base') :PathPart('logout') :Args(0) {
    my ($self,$c) = @_;
    $c->logout;
    $c->res->redirect($c->uri_for('/'));
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
