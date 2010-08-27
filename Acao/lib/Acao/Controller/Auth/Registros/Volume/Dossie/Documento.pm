package Acao::Controller::Auth::Registros::Volume::Dossie::Documento;
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

Acao::Controller::Auth::Registros::Volume::Dossie::Documento - Controlador
que implementa as ações de digitação de uma leitura específica.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados do dossiê.

=cut

sub base : Chained('/auth/registros/volume/base') :PathPart('') :CaptureArgs(2) {
    my ( $self, $c, $id_volume, $controle) = @_;
    $c->stash->{id_volume} = $id_volume;
    $c->stash->{controle} = $controle
      or $c->detach('/public/default');
}

=item form

Delega à view a renderização do formulário desse dossiê.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
}

sub form : Chained('base') : PathPart('inserirdocumento') : Args(0) {
}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;

    eval {
        $c->model('Documento')->inserir_documento(
		                                  $c->req->address,
		                                  $c->request->param('processed_xml'),
					                      $c->req->param('id_volume'),
					                      $c->req->param('controle')
					                     );

    };

    if ($@) { $c->flash->{erro} = $@ . "";  }
    else { $c->flash->{sucesso} = 'Documento criado com sucesso'; }
    $c->res->redirect( $c->uri_for('/auth/registros/volume/' . $c->req->param('id_volume') . '/' . $c->req->param('controle') ) );
}

sub visualizar : Chained('base') : PathPart('visualizar') : Args(1) {
    my ( $self, $c, $id_documento ) = @_;
    $c->stash->{id_volume} = $id_documento
        or $c->detach('/public/default');
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
