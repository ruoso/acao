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

sub base : Chained('/auth/registros/consolidador/base') : PathPart('') :
  CaptureArgs(1) {
    my ( $self, $c, $id_leitura ) = @_;
    $c->stash->{leitura} = $c->model('Consolidador')->obter_leitura($id_leitura);
}

sub lista : Chained('base') : PathPart('') : Args(0) {
}

sub visualizar_base : Chained('base') : PathPart('visualizar') : CaptureArgs(1)
{
    my ( $self, $c, $id_doc ) = @_;
    $c->stash->{id_doc} = $id_doc;
    $c->model('Consolidador')->visualizar( $c->stash->{leitura}, $id_doc );
}

sub visualizar : Chained('visualizar_base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{campo_controle} =
      $c->model('Consolidador')
      ->obter_campo_controle( $c->stash->{leitura}, $c->stash->{id_doc} );
}

sub xml : Chained('visualizar_base') : PathPart : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{document} =
      $c->model('Consolidador')
      ->visualizar( $c->stash->{leitura}, $c->stash->{id_doc} );
    $c->forward( $c->view('XML') );
}

sub diff : Chained('base') : PathPart : Args(1) {
    my ( $self, $c, $controle ) = @_;

}

sub xsd : Chained('base') : PathPart('xsd') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{document} =
      $c->model('Revisor')->obter_xsd_leitura( $c->stash->{leitura} );
    $c->forward( $c->view('XML') );
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
