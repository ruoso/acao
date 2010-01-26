package Acao::Controller::Auth::Registros::Revisor::Leitura;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Auth::Registros::Revisor::Leitura - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/auth/registros/revisor/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id_leitura ) = @_;
    $c->stash->{leitura} = $c->model('Revisor')->obter_leitura($id_leitura);
}

sub lista :Chained('base') :PathPart('') :Args(0) {
    
}

sub leitura :Chained('base') :PathPart('') :Args(0) {
    
}

sub recusar :Chained('base') :PathPart :Args(0) {}
sub diff :Chained('base') :PathPart :Args(0) {}
sub aprovar :Chained('base') :PathPart :Args(0) {}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
