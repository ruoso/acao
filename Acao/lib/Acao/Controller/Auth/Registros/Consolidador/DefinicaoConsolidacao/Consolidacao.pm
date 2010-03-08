package Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao::Consolidacao;

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

sub base : Chained('/auth/registros/consolidador/definicaoconsolidacao/base') : PathPart('') :
  CaptureArgs(1) {
    my ( $self, $c, $id_, ) = @_;
}

sub lista : Chained('base') : PathPart('') : Args(0) {
  my ( $self, $c ) = @_;
}

=head1 AUTHOR

Jackson,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
