package Acao::Controller::Root;
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

__PACKAGE__->config->{namespace} = '';

=head1 NAME

Acao::Controller::Root - Controlador raiz da aplicação

=head1 DESCRIPTION

Realiza definições que se aplicam a todas as ações do sistema.

=head1 ACTIONS

=over

=item begin

Essa ação é definida para predefinir o breadcrumb como um array vazio
no stash.

=cut

sub begin : Private {
    my ( $self, $c ) = @_;
    $c->stash->{breadcrumb} = [];
}

=item end

Essa ação é definida com o ActionClass renderview, que irá chamar a
default_view no caso de nenhuma ação ter produzido output.

=cut

sub end : ActionClass(RenderView) {

}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
