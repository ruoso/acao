package Acao::Controller::Public;
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

Acao::Controller::Public - Controlador raiz para as ações que não
requerem autenticação.

=head1 ACTIONS

=over

=item base

Raiz da chain para ações públicas.

=cut

sub base : Chained('/') : PathPart('') : CaptureArgs(0) {
}

=item entrada

Ação que implementa a página inicial. No entanto nesse momento só
temos ações autenticadas, portanto ele faz redirect para aquela área.

=cut

sub entrada : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $c->res->redirect( $c->uri_for('/auth') );
}

=item default

Ação que implementa o tratamento de urls não acessadas.

=cut

sub default : Chained('base') : PathPart('') {
    my ( $self, $c ) = @_;
    $c->res->body('Page not found...');
    $c->res->code(404);
}

=item erro

Ação para a renderização de erros genéricos.

=cut

sub erro : Chained('base') : PathPart {
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
