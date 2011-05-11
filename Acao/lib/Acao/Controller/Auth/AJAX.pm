package Acao::Controller::Auth::AJAX;

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
use List::MoreUtils qw(pairwise);
use parent 'Catalyst::Controller';



=head1 NAME

Acao::Controller::Auth::Registros - Raiz da área de registros.

=head1 ACTIONS

=over

=item base

Ação raiz da área de registros.

=cut

sub navega_ldap : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template}     = 'auth/ajax/navega_ldap.tt';
    $c->stash->{basedn}       = $c->req->param('grupos');
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
    return 1;

}

sub add_autorizacoes_grid : Local
{
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/grid_autorizacoes.tt';
    my @principal  = split /-/, $c->req->param('grupos');
    my @role       = $c->req->param('role[]');
    my $permissoes =
      $c->model($c->req->param('model'))->build_autorizacao_AoH( \@principal, \@role );
    $c->stash->{autorizacoes} =
      $c->model($c->req->param('model'))
      ->add_autorizacoes( $c->req->param('autorizacoes_ldap'), $permissoes );
    $c->stash->{model} = $c->req->param('model');
    return 1;

}

sub remover_autorizacoes_grid : Local
{
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/grid_autorizacoes.tt';
    my ($pos) = $c->req->param('posicao');
    if ( $pos or $pos == 0 ) {
        $c->stash->{autorizacoes} = $c->model($c->req->param('model'))
          ->remove_autorizacoes( $c->req->param('autorizacoes_ldap'), $pos );
    }
    else {
        $c->stash->{autorizacoes} = $c->req->param('autorizacoes_ldap');
    }
    $c->stash->{model} = $c->req->param('model');
    return 1;

}

sub ver_autorizacoes_grid : Local
{
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/grid_autorizacoes.tt';
    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();
    my $herdar             =
      $c->model($c->req->param('model'))
      ->desserialize_autorizacoes(
        $c->model($c->req->param('model'))->autorizacoes_do_volume( $c->stash->{id_volume} ) );
    $c->stash->{herdar}       = $herdar->{herdar};
    $c->stash->{autorizacoes} = $c->model($c->req->param('model'))->autorizacoes_do_volume(
        $c->stash->{id_volume}

    );
    $c->stash->{model} = $c->req->param('model');
    $c->stash->{basedn} = $c->model("LDAP")->grupos_dn;
    return 1;

}

sub processa_localizacao : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/select_local.tt';
    $c->stash->{local_basedn} = $c->req->param('localizacao[]') ||  $c->model("LDAP")->local_dn;

}

sub processa_classificacao : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/select_classificacao.tt';
    $c->stash->{class_basedn}   = $c->req->param('assuntos[]') ||  $c->model("LDAP")->assuntos_dn ;



}


sub add_classificacoes_grid : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/grid_classificacoes.tt';
    my @classificacoes = $c->req->param('assuntos[]');
    $c->stash->{classificacoes} = $c->model($c->req->param('model'))->add_classificacoes(
                        $c->req->param('classificacoes'),
                        \@classificacoes );
    $c->stash->{model} = $c->req->param('model');

}

sub remover_classificacoes_grid : Local {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/ajax/grid_classificacoes.tt';
    my ($pos) = $c->req->param('posicao');

    if ( $pos or $pos == 0 ) {
        $c->stash->{classificacoes} = $c->model($c->req->param('model'))->remove_classificacoes(
                                     $c->req->param('classificacoes'), $pos );
    }
    else {
        $c->stash->{classificacoes} = $c->req->param('classificacoes');
    }

    $c->stash->{model} = $c->req->param('model');
    return 1;

}




=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
