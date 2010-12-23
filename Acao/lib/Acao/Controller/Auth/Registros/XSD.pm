package Acao::Controller::Auth::Registros::XSD;
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

Acao::Controller::Auth::Registros::XSD - Gestão de Schemas

=head1 ACTIONS

=over

=item base

Ação raiz para as ações de digitador.

=cut

sub base : Chained('/auth/registros/base') : PathPart('xsd') :
  CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub dados :Chained('base') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    $c->stash->{namespace} = $c->req->param('ns');
}

sub raw : Chained('dados') : PathPart('raw') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{document} = $c->model('XSD')->obter_xsd( $c->stash->{namespace} );
    $c->forward( $c->view('XML') );
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
