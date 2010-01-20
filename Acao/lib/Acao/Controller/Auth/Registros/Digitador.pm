package Acao::Controller::Auth::Registros::Digitador;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Digitador - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/auth/registros/base') :PathPart('digitador') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub lista :Chained('base') :PathPart('') :Args(0) {}


1;
