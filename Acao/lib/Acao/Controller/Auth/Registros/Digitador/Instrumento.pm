package Acao::Controller::Auth::Registros::Digitador::Instrumento;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Digitador::Instrumento - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub instrumento :Chained('/auth/registros/digitador/base') :PathPart('') :CaptureArgs(2) {
    my ($self, $c, $id_projeto, $instrumento) = @_;
}

sub form :Chained('instrumento') :PathPart('') :Args(0) {
}

sub store :Chained('instrumento') :PathPart('store') :Args(0) {
}


=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
