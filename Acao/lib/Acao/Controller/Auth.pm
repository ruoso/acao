package Acao::Controller::Auth;
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

use strict;
use warnings;
use parent 'Catalyst::Controller';

sub base : Chained('/') : PathPart('auth') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    unless ( $c->user ) {
        $c->res->redirect( $c->uri_for('/login') );
        $c->detach;
    }
}

sub principal : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $c->res->redirect( $c->uri_for('/auth/registros') );
}

sub logout : Chained('base') : PathPart('logout') : Args(0) {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->res->redirect( $c->uri_for('/') );
}

1;
