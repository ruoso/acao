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
use Data::Dumper;

my $admin_schemas = Acao->config->{'Model::LDAP'}->{admin_schemas};
my $admin_registros = Acao->config->{'Model::LDAP'}->{admin_registros};
my $admin_super = Acao->config->{'Model::LDAP'}->{admin_super};

=head1 NAME

Acao::Controller::Auth - Controlador raiz para todas as ações que
requerem autenticação.

=head1 ACTIONS

=over

=item base

Essa é a raiz da chain para ações autenticadas, ela verifica se existe
um usuário, senão faz o redirect para a tela de login e encerra a
chain.

=cut

sub base : Chained('/') : PathPart('auth') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
    unless ( $c->user ) {
        $c->res->redirect( $c->uri_for_action('/public/login/login') );
        $c->detach;
    }
    Log::Log4perl::MDC->put( 'user',    $c->user->uid );
    Log::Log4perl::MDC->put( 'address', $c->req->address );
}

=item principal

Por enquanto só temos a área de registros, então ela faz o redirect
para essa área.

=cut

sub principal : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    # redireciona o usuário para área administrativa caso seja super admin.
    
    if (($admin_super ~~ @{$c->user->memberof})) {
        $c->res->redirect( $c->uri_for_action('/auth/admin/principal') );
    } else {
        $c->res->redirect( $c->uri_for_action('/auth/registros/principal') );
    }

}

=item logout

Essa é a ação que encerra a sessão do usuário atual, fazendo o
redirect para o / no final.

=cut

sub logout : Chained('base') : PathPart('logout') : Args(0) {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->res->redirect( $c->uri_for_action('/public/entrada') );
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
