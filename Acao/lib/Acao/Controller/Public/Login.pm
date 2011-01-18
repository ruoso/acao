package Acao::Controller::Public::Login;
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
use Data::Dumper;
=head1 NAME

Acao::Controller::Public::Login - Implementa a chamada para o início
de uma sessão de usuário.

=head1 ACTIONS

=over

=item base

Ação base para outras ações desse controlador.

=cut

sub base : Chained('/') : PathPart('login') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

=item login

Faz a chamada para a autenticação, iniciando a sessão do usuário.

=cut

sub login : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $user     = $c->request->params->{user};
    my $password = $c->request->params->{password};

    if ( defined $user && defined $password ) {
      $c->get_auth_realm(Acao->config->{'Plugin::Authentication'}{default_realm})->store->user_basedn($c->req->param('dominio'));
        if ( $c->authenticate( { id => $user, password => $password } ) ) {
            $c->res->redirect(
                $c->uri_for_action('/auth/principal')
            );
            return;
        }
        else {
            $c->flash->{erro} = 'Usuário Inválido';
        }
    }
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
