package Acao::Controller::Auth::Registros::Digitador::Leitura;
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

sub base : Chained('/auth/registros/digitador/base') : PathPart('') :
  CaptureArgs(1) {
    my ( $self, $c, $id_leitura ) = @_;
    $c->stash->{leitura} = $c->model('Digitador')->obter_leitura($id_leitura);
}

sub form : Chained('base') : PathPart('') : Args(0) {
}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    my $xml     = $c->request->param('processed_xml');
    my $leitura = $c->stash->{leitura};

    eval {
        $c->model('Digitador')
          ->salvar_digitacao( $leitura, $xml,
            scalar( $c->req->param('controle') ),
            $c->req->address );
    };

    if ($@) {
        $c->flash->{erro} = $@ . "";
    }
    else {
        $c->flash->{sucesso} = 'Digitação armazenada com sucesso';
    }

    $c->res->redirect( $c->uri_for('/auth/registros/digitador') );
}

sub xsd : Chained('base') : PathPart('xsd') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{document} =
      $c->model('Digitador')->obter_xsd_leitura( $c->stash->{leitura} );
    $c->forward( $c->view('XML') );
}

1;
