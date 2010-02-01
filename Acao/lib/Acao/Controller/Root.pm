package Acao::Controller::Root;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Root - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

__PACKAGE__->config->{namespace} = '';

sub begin :Private {
   my ($self, $c) = @_;
   $c->stash->{breadcrumb} = [];
}

sub end :ActionClass(RenderView) {}


=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
