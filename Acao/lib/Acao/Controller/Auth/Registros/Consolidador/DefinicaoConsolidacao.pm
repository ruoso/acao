package Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao;
use utf8;

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

Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao
- implementa as ações relativas a uma definição de consolidação específica.

=head1 ACTIONS

=over

=item base

Ação raiz para as ações de uma definição de consolidação
específica. Adiciona no stash as informações específicas desse contexto.

=cut

sub base : Chained('/auth/registros/consolidador/base') : PathPart('') :
  CaptureArgs(1) {
    my ( $self, $c, $id_definicao_consolidacao ) = @_;
    $c->stash->{id_definicao_consolidacao} = $id_definicao_consolidacao;
    $c->stash->{definicao_consolidacao} =
      $c->model("Consolidador")
      ->obter_definicao_consolidacao($id_definicao_consolidacao)
      or $c->detach('/public/default');
}

=item inciar

Ação que inicia uma nova consolidação, fazendo o redirect para os
dados específicos da consolidação iniciada.

=cut

sub iniciar : Chained('base') : PathPart('iniciar') : Args(0) {
    my ( $self, $c ) = @_;
    eval {
        my $consolidacao =
          $c->model('Consolidador')
          ->iniciar_consolidacao( $c->stash->{definicao_consolidacao} );
        $c->res->redirect(
            $c->uri_for_action(
'/auth/registros/consolidador/definicaoconsolidacao/consolidacao/lista',
                [
                    $c->stash->{id_definicao_consolidacao},
                    $consolidacao->id_consolidacao,
                ],
                {}
            )
        );
    };
    if ($@) {
        $c->flash->{erro} = $@ . '';
        $c->res->redirect(
            $c->uri_for_action(
                '/auth/registros/consolidador/definicaoconsolidacao/lista',
                [ $c->stash->{id_definicao_consolidacao} ],
                {}
            )
        );
    }
}

=item lista

Delega à view a renderização das definições de consolidação que esse
usuário tem acesso.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
