package Acao::Controller::Auth::Registros::Volume::Dossie;
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

with 'Acao::Role::Controller::Autorizacao' => { modelcomponent => 'Dossie' };
with 'Acao::Role::Controller::Classificacao' => { modelcomponent => 'Dossie' };
with 'Acao::Role::Auditoria' => { category => 'Dossie'};

=head1 NAME

Acao::Controller::Auth::Registros::Volume::Dossie - Controlador
que implementa as ações de digitação de uma leitura específica.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados do dossiê.

=cut


sub base : Chained('/auth/registros/volume/get_volume') :PathPart('') :CaptureArgs(0) {
    my ($self, $c,) = @_;
#   Checa se user logado tem autorização para executar a ação 'Ver' em Volume
    if (!$c->model('Volume')->pode_ver_volume($c->stash->{id_volume})) {
        $c->flash->{autorizacao} = 'Você não tem autorização para ver este Volume';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/lista'));
    }
}

sub get_dossie : Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $controle ) = @_;
    Log::Log4perl::MDC->put('Dossie', $controle);
    $c->stash->{controle} = $controle
      or $c->detach('/public/default');
}


=item form

Delega à view a renderização do formulário desse dossiê.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
}

sub form : Chained('base') : PathPart('criardossie') : Args(0) {
    my ( $self, $c ) = @_;
    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();
    $c->stash->{autorizacoes} = $c->model("Dossie")->new_autorizacao();
    $c->stash->{classificacoes} = $c->model("Dossie")->new_classificacao($initial_principals);
    $c->stash->{basedn} = $c->model("LDAP")->grupos_dn;
    $c->stash->{class_basedn} = $c->model("LDAP")->assuntos_dn;
    $c->stash->{herdar} or $c->stash->{herdar} = 1;
#   Checa se user logado tem autorização para executar a ação 'Criar'
    $c->model('Dossie')->pode_criar_dossie($c->stash->{id_volume}) or $c->detach('/public/default');
}

sub transferir_lista : Chained('get_dossie') : PathPart('transferir_lista') : Args(0) {
    my ( $self, $c ) = @_;
#   Checa se user logado tem autorização para executar a ação 'Transferir'
#    $c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume}) or $c->detach('/public/default');
#   $c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume},$c->stash->{controle}) or $c->detach('/public/default');

    if (!$c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume},$c->stash->{controle}))
       {
       $c->flash->{autorizacao} = 'Ops! Você não tem autorização para isso, consulte...';
       $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista', [ $c->stash->{id_volume} ]) );
       }

}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;

    #   Checa se user logado tem autorização para executar a ação 'Criar'
    $c->model('Dossie')->pode_criar_dossie($c->stash->{id_volume}) or $c->detach('/public/default');
    $c->stash->{basedn} = $c->req->param('basedn') || $c->model("LDAP")->grupos_dn;
    $c->stash->{class_basedn} = $c->req->param('class_basedn') || $c->model("LDAP")->assuntos_dn;
    $c->stash->{nome} = $c->req->param('nome');
    $c->stash->{template} = 'auth/registros/volume/dossie/form.tt';
    $c->stash->{classificacoes} = $c->req->param('classificacoes');
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');



    my $representaDossieFisico;
    my $herdar_author;

    if ($c->req->param('representaDossieFisico') eq 'on'){
       $representaDossieFisico = '1';
    }
    else {
       $representaDossieFisico = '0';
    }

    if ($c->req->param('herdar_author') eq 'on'){
       $herdar_author = '1';
    }
    else {
       $herdar_author = '0';
    }

    $c->stash->{herdar} = $herdar_author;

    if ($self->_processa_autorizacao($c) ||
      $self->_processa_classificacao($c)) {
          $c->stash->{template} = 'auth/registros/volume/dossie/form.tt';
    return;

     }

    eval {
        my $id = $c->model('Dossie')->criar_dossie(
                              $c->req->address,
                              $c->req->param('nome'),
                              $c->req->param('id_volume'),
                              $representaDossieFisico,
                              $c->model('Dossie')->desserialize_classificacoes($c->stash->{classificacoes}),
                              $c->req->param('localizacao'),
                              $herdar_author,
                              $c->model('Dossie')->desserialize_autorizacoes($c->req->param('autorizacoes')),
                               );

        $self->audit_criar($id, $c->req->param('nome'));
    };

    if ($@) { $c->flash->{erro} = $@ . "";  }
    else { $c->flash->{sucesso} = 'Dossie criado com sucesso'; }
    $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista', [ $c->req->param('id_volume') ]) );
}

sub alterar_estado : Chained('get_dossie') : PathPart('alterar_estado') : Args(1) {
     my ( $self, $c, $estado ) = @_;
     eval {
             $c->model('Dossie')->alterar_estado($c->stash->{id_volume}, $c->stash->{controle}, $estado, $c->req->address );
          };
    if ($@) {
        $c->flash->{erro} = $@;
    }
    else {
        $c->flash->{sucesso} = 'Estado alterado com sucesso!';
    }
    $self->audit_alterar('estado: ',$estado);
    $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista', [ $c->stash->{id_volume} ]) );
}

sub transferir : Chained('get_dossie') : PathPart('transferir') : Args(0) {
     my ( $self, $c ) = @_;
    my $controle = $c->stash->{controle};

    #   Checa se user logado tem autorização para executar a ação 'Transferir'
#       $c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume}) &&
    #   $c->model('Dossie')->pode_criar_dossie($c->req->param('volume_destino'))
    #      or $c->detach('/public/default');

    if (!($c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume},$controle) &&
       $c->model('Dossie')->pode_criar_dossie($c->req->param('volume_destino')))) {
            $c->flash->{autorizacao} = 'Ops! Você não tem autorização para isso, consulte...';
            $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista', [ $c->stash->{id_volume} ]) );
       }

     eval {
             $c->model('Dossie')->transferir($c->stash->{id_volume}, $controle,  $c->req->param('volume_destino'), $c->req->address );
          };
    if ($@) {
        $c->flash->{erro} = $@;
    }
    else {
        $c->flash->{sucesso} = 'Alterado com sucesso!';
    }

    $self->audit_alterar('transferir: ',$controle);
    $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista',[ $c->stash->{id_volume} ]) );
}

sub alterar_dossie : Chained('get_dossie') : PathPart('alterar') : Args(0) {
    my ($self, $c) = @_;
    #   Checa se user logado tem autorização para executar a ação 'Alterar'
    #   Checa se user logado tem autorização para executar a ação 'Ver' em Volume
    if (!$c->model('Dossie')->pode_alterar_dossie($c->stash->{id_volume},$c->stash->{controle} )) {
        $c->flash->{autorizacao} = 'Você não tem autorização';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/lista',$c->stash->{id_volume} ));
    }
    #$c->model('Dossie')->pode_alterar_dossie($c->stash->{id_volume},$c->stash->{controle} ) or $c->detach('/public/default');
    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();

    my $herdar = $c->model('Dossie')->desserialize_autorizacoes(
                    $c->model('Dossie')->autorizacoes_do_dossie($c->stash->{id_volume},$c->stash->{controle} ));

    $c->stash->{herdar} = $herdar->{herdar};
    $c->stash->{autorizacoes} = $c->model('Dossie')->autorizacoes_do_dossie($c->stash->{id_volume},$c->stash->{controle} );
    $c->stash->{classificacoes} = $c->model("Dossie")->classificacoes_do_dossie($c->stash->{id_volume}, $c->stash->{controle});
    $c->stash->{basedn} = $c->model("LDAP")->grupos_dn;
    $c->stash->{class_basedn} = $c->req->param('class_basedn') || $c->model("LDAP")->assuntos_dn;
    $c->stash->{template} = 'auth/registros/volume/dossie/form_alterar.tt';

}


sub store_alterar : Chained('get_dossie') : PathPart('store_alterar') : Args(0) {
  my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para executar a ação 'Alterar'
    $c->model('Dossie')->pode_alterar_dossie($c->stash->{id_volume},$c->stash->{controle} ) or $c->detach('/public/default');
  my $representaDossieFisico;
  my $herdar_author;

  $c->stash->{basedn} = $c->req->param('basedn') || $c->model("LDAP")->grupos_dn;
  $c->stash->{class_basedn} = $c->req->param('class_basedn') || $c->model("LDAP")->assuntos_dn;
  $c->stash->{template} = 'auth/registros/volume/dossie/form_alterar.tt';
  $c->stash->{classificacoes} = $c->req->param('classificacoes');
  $c->stash->{autorizacoes} = $c->req->param('autorizacoes');



  if ( $c->req->param('representaDossieFisico') eq 'on' ) {
    $representaDossieFisico = '1';
  }
  else {
    $representaDossieFisico = '0';
  }

  if ($c->req->param('herdar_author') eq 'on'){
       $herdar_author = '1';
  }
   else {
      $herdar_author = '0';
  }

  $c->stash->{herdar} = $herdar_author;

  if ($self->_processa_autorizacao($c) ||
      $self->_processa_classificacao($c)) {
    return;
  }

  my $autorizacoes_h = $c->model('Dossie')->desserialize_autorizacoes($c->req->param('autorizacoes'));
  $autorizacoes_h->{'herdar'} = $herdar_author ;

  eval {
     $c->model('Dossie')->store_altera_dossie({
          id_volume     => $c->stash->{id_volume},
          controle      => $c->stash->{controle},
          autorizacoes  => $c->model('Dossie')->serialize_autorizacoes($autorizacoes_h),
          nome          => $c->req->param('nome'),
          classificacoes => $c->req->param('classificacoes'),
          localizacao   => $c->req->param('localizacao'),
          dossie_fisico => $representaDossieFisico,
          ip            => $c->req->address,
     }
    );
    $self->audit_alterar('geral');

  };

  if ($@) { $c->flash->{erro} = $@ . ""; }
  else { $c->flash->{sucesso} = 'Alteraçoes realizada com sucesso'; }
  $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista', [$c->stash->{id_volume}, $c->stash->{controle}]));
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
