package Acao::Controller::Public;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Public - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('') :CaptureArgs(0) {}

sub entrada :Chained('base') :PathPart('') :Args(0) {
    my ($self,$c) = @_;
}

sub default :Chained('base') :PathPart('')  {
    my ($self, $c) = @_;
    $c->res->body('Page not found...');
    $c->res->code(404);
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
