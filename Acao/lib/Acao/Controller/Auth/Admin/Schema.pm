package Acao::Controller::Auth::Admin::Schema;

# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,

use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller'; }
use Data::Dumper;
use utf8;
with 'Acao::Role::Auditoria'                 => { category       => 'Admin-Schemas' };


sub base : Chained('/auth/admin/base') : PathPart('schemas') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

}

sub buscar : Chained('base') : PathPart('buscar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/schema/grid_schemas.tt';

    $c->stash->{schemas} =
      $c->model('Schema')
      ->buscar_schemas( $c->req->param('template'), $c->req->param('busca') );
    $c->stash->{xqueryret} = $c->req->param('template');
    return;
}

sub validacao : Chained('base') : PathPart('validar')  : Args(1) {
    my ( $self, $c, $validacao ) = @_;
    my $XSDtargetNamespace = $c->req->param('XSDtargetNamespace');
    $c->model('Schema')->altera_validacao_schemas( $XSDtargetNamespace, $validacao );
    $c->stash->{template} = 'auth/admin/schema/lista.tt';
    return;
}
1;
