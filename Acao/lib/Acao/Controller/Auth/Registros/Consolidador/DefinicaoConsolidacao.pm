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

sub base : Chained('/auth/registros/consolidador/base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id_definicao_consolidacao) = @_;
 	    $c->stash->{id_definicao_consolidacao} = $id_definicao_consolidacao;
    $c->stash->{definicao_consolidacao} =
      $c->model("Consolidador")->obter_definicao_consolidacao($id_definicao_consolidacao)
	or $c->detach('/default');
}

sub iniciar : Chained('base') : PathPart('iniciar') : Args(0) {
    my ($self, $c) = @_;
    eval {
      my $consolidacao =
         $c->model('Consolidador')->iniciar_consolidacao($c->stash->{definicao_consolidacao});
      $c->res->redirect(
        $c->uri_for_action(
           '/auth/registros/consolidador/definicaoconsolidacao/consolidacao/lista',
           [ $c->stash->{id_definicao_consolidacao},
             $consolidacao->id_consolidacao,
           ], {}
        )
      );
    };
    if ($@) {
      $c->flash->{erro} = $@.'';
      $c->res->redirect(
        $c->uri_for_action(
           '/auth/registros/consolidador/definicaoconsolidacao/lista',
           [ $c->stash->{id_definicao_consolidacao} ],
           {}
        )
      );
    }
}

sub lista : Chained('base') : PathPart('') : Args(0) {}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
