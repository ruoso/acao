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
use Moose;
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller'; }
use Data::Dumper;
use List::MoreUtils 'pairwise';

with 'Acao::Role::Controller::Autorizacao' => { modelcomponent => 'Volume' };

=head1 NAME

Acao::Controller::Auth::Registros::Volume - Raiz das ações de
digitador.

=head1 ACTIONS

=over

=item base

Ação raiz para as ações de digitador.

=cut

sub base : Chained('/auth/registros/base') : PathPart('volume') : CaptureArgs(0)
{
  my ( $self, $c ) = @_;
}

sub get_volume :Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id_volume ) = @_;
    $c->stash->{id_volume} = $id_volume
      or $c->detach('/public/default');

    $c->model('Volume')->pode_ver_volume($id_volume)
    or $c->detach('/public/default');
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
  my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();
  $c->stash->{autorizacoes} = $c->model("Volume")->new_autorizacao($initial_principals);
  $c->stash->{basedn} = $c->model("LDAP")->grupos_dn;
# Checa se user logado tem autorização para executar a ação 'Criar'
  $c->model('Volume')->pode_criar_volume() or $c->detach('/public/default');
}

sub store : Chained('base') : PathPart('store') : Args(0) {
  my ( $self, $c ) = @_;
  #	Checa se user logado tem autorização para executar a ação 'Criar'
  $c->model('Volume')->pode_criar_volume() or $c->detach('/public/default');
  my $representaVolumeFisico;
  $c->stash->{basedn} = $c->req->param('basedn') ||
              $c->model("LDAP")->grupos_dn;


  $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
  $c->stash->{template} = 'auth/registros/volume/form.tt';
  if ($self->_processa_autorizacoes($c)) {
      return;
  }

  if ( $c->req->param('representaVolumeFisico') eq 'on' ) {
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
      $c->model('Volume')->desserialize_autorizacoes($c->req->param('autorizacoes')),
      $c->req->address,
    );

  };

  if ($@) { $c->flash->{erro} = $@ . ""; }
  else { $c->flash->{sucesso} = 'Volume criado com sucesso'; }
  $c->res->redirect( $c->uri_for('/auth/registros/volume') );
}

sub xsd : Chained('base') : PathPart('xsd') : Args(1) {
  my ( $self, $c, $xsd ) = @_;
  $c->stash->{document} = $c->model('XSD')->obter_xsd($xsd);
  $c->forward( $c->view('XML') );
}

sub alterar_estado : Chained('base') : PathPart('alterar_estado') : Args(1) {
  my ( $self, $c, $estado ) = @_;
  my $id_volume = $c->stash->{id_volume};
  eval {
    $c->model('Volume')
      ->alterar_estado( $id_volume, $estado, $c->req->address );
  };
  if ($@) {
    $c->flash->{erro} = $@;
  }
  else {
    $c->flash->{sucesso} = 'Estado alterado com sucesso!';
  }
  $c->res->redirect( $c->uri_for('/auth/registros/volume') );
}

sub alterar_volume :Chained('get_volume') : PathPart('alterar') : Args(0) {
    my ($self, $c) = @_;
#   Checa se user logado tem autorização para executar a ação 'Alterar'
   $c->model('Volume')->pode_alterar_volume($c->stash->{id_volume}) or $c->detach('/public/default');

    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();

  $c->stash->{autorizacoes} = $c->model('Volume')->autorizacoes_do_volume($c->stash->{id_volume});
  $c->stash->{basedn} = $c->model("LDAP")->grupos_dn;
  $c->stash->{template} = 'auth/registros/volume/form_alterar.tt';

}


sub store_alterar : Chained('get_volume') : PathPart('store_alterar') : Args(0) {
  my ( $self, $c ) = @_;
#	Checa se user logado tem autorização para executar a ação 'Alterar'
   $c->model('Volume')->pode_alterar_volume($c->stash->{id_volume}) or $c->detach('/public/default');

  my $representaVolumeFisico;
  $c->stash->{basedn} = $c->req->param('basedn') ||
              $c->model("LDAP")->grupos_dn;

    $c->stash->{template} = 'auth/registros/volume/form_alterar.tt';

  $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
  if ($self->_processa_autorizacoes($c)) {
      return;
  }

    if ( $c->req->param('representaVolumeFisico') eq 'on' ) {
    $representaVolumeFisico = '1';
  }
  else {
    $representaVolumeFisico = '0';
  }


  eval {
     $c->model('Volume')->store_altera_volume({
          id_volume     => $c->stash->{id_volume},
          autorizacoes  => $c->req->param('autorizacoes'),
          nome          => $c->req->param('nome'),
          volume_fisico => $representaVolumeFisico,
          classificacao => $c->req->param('classificacao'),
          localizacao   => $c->req->param('localizacao'),
          ip            => $c->req->address,
     }
    );


  };

  if ($@) { $c->flash->{erro} = $@ . ""; }
  else { $c->flash->{sucesso} = 'Alteraçoes realizada com sucesso'; }
  $c->res->redirect( $c->uri_for('/auth/registros/volume/'.$c->stash->{id_volume}) );
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
