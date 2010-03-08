package Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao;

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

sub base :Chained('/auth/registros/consolidador/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id_definicao_consolidacao) = @_;
    $c->stash->{definicao_consolidacao} =
      $c->model("Consolidador")->obter_definicao_consolidacao($id_definicao_consolidacao)
	or $c->detach('/default');
}

sub lista : Chained('base') : PathPart('') : Args(0) {}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
