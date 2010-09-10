package Acao::Controller::Auth::Registros::Volume;
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

=head1 NAME

Acao::Controller::Auth::Registros::Volume - Raiz das ações de
digitador.

=head1 ACTIONS

=over

=item base

Ação raiz para as ações de digitador.

=cut

sub base : Chained('/auth/registros/base') : PathPart('volume') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=item lista

Delega à view a renderização da lista de leituras que esse gestorvolume
tem acesso.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
}

sub form : Chained('base') : PathPart('criarvolume') : Args(0) {
    my ( $self, $c ) = @_;
}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    my $representaVolumeFisico;

    if ($c->req->param('representaVolumeFisico') eq 'on'){
       $representaVolumeFisico = '1';
    }
    else {
       $representaVolumeFisico = '0';
    }

    eval {
        $c->model('Volume')->criar_volume(
					    $c->req->param('nome'),
					    $representaVolumeFisico,
					    $c->req->param('classificacao'),
					    $c->req->param('localizacao'),
					    $c->req->param('autorizacao'),
					    $c->req->address,
					 );

    };

    if ($@) { $c->flash->{erro} = $@ . ""; }
    else { $c->flash->{sucesso} = 'Volume criado com sucesso'; }
    $c->res->redirect( $c->uri_for('/auth/registros/volume') );
}

sub xsd : Chained('base') : PathPart('xsd') : Args(1) {
    my ( $self, $c, $xsd ) = @_;
    $c->stash->{document} = $c->model('XSD')->obter_xsd( $xsd );
    $c->forward( $c->view('XML') );
}

sub alterar_estado : Chained('base') : PathPart('alterar_estado') : Args(2) {
     my ( $self, $c, $id_volume, $estado ) = @_;
     eval {
             $c->model('Volume')->alterar_estado($id_volume, $estado, $c->req->address); 
          };
    if ($@) {
        $c->flash->{erro} = $@;
    }
    else {
        $c->flash->{sucesso} = 'Estado alterado com sucesso!';
    }
    $c->res->redirect( $c->uri_for('/auth/registros/volume') );
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
