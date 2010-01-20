package Acao::Controller::Auth::Registros::Revisor::Preenchimento;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Revisor::Preenchimento - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/auth/registros/revisor/base') :PathPart('') :CaptureArgs(2) {
    my ( $self, $c, $id_projeto, $instrumento ) = @_;
    $c->response->body('Matched Acao::Controller::Auth::Registros::Revisor::Preenchimento in Auth::Registros::Revisor::Preenchimento.');
}

sub lista :Chained('base') :PathPart('') :Args(0) {
    
}

sub preenchimento :Chained('base') :PathPart('') :CaptureArgs(1) {
    
}

sub recusar :Chained('preenchimento') :PathPart :Args(0) {}
sub diff :Chained('preenchimento') :PathPart :Args(0) {}
sub unir :Chained('preenchimento') :PathPart :Args(0) {}
sub aprovar :Chained('preenchimento') :PathPart :Args(0) {}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
