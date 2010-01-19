package Acao::Controller::Auth::Registros::Revisor;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Revisor - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/auth/registros/base') :PathPart('revisor') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->response->body('Matched Acao::Controller::Auth::Registros::Revisor in Auth::Registros::Revisor.');
}

sub lista :Chained('base') :PathPart('') :Args(0) {
    my ($self,$c) = @_;
    
    $c->res->body('Matched Acao::Controller::Auth::Registros::Revisor::Instrumento in Auth::Registros::Revisor::Instrumento.')
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
