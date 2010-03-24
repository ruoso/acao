package Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao::Consolidacao;
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

sub base : Chained('/auth/registros/consolidador/definicaoconsolidacao/base') :
  PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id_consolidacao ) = @_;
    $c->stash->{consolidacao} =
         $c->model("Consolidador")->obter_consolidacao($id_consolidacao)
      or $c->detach('/default');
}

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
}

sub entradas :Chained('base') :PathPart :Args(1) {
    my ( $self, $c, $id_documento_consolidado ) = @_;
    $c->stash->{id_documento_consolidado} = $id_documento_consolidado;
}

sub fragmentos_alertas : Chained('base') :PathPart :Args(1){
    my ($self, $c, $id_alerta) = @_;
    $c->stash->{id_alerta} = $id_alerta;
}

1;
