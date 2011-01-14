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

}

=item form

Delega à view a renderização do formulário desse dossiê.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;}

sub form : Chained('base') : PathPart('criardossie') : Args(0) {
    my ( $self, $c ) = @_;
#   Checa se user logado tem autorização para executar a ação 'Criar'
    $c->model('Dossie')->pode_criar_dossie($c->stash->{id_volume}) or $c->detach('/public/default');
}

sub transferir_lista : Chained('base') : PathPart('transferir_lista') : Args(1) {
    my ( $self, $c, $controle ) = @_;
    $c->stash->{controle}  = $controle;
#   Checa se user logado tem autorização para executar a ação 'Transferir'
    $c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume}) or $c->detach('/public/default');

}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para executar a ação 'Criar'
    $c->model('Dossie')->pode_criar_dossie($c->stash->{id_volume}) or $c->detach('/public/default');

    my $representaDossieFisico;

    if ($c->req->param('representaDossieFisico') eq 'on'){
       $representaDossieFisico = '1';
    }
    else {
       $representaDossieFisico = '0';
    }
    eval {
        my $id = $c->model('Dossie')->criar_dossie(
                              $c->req->address,
                              $c->req->param('nome'),
                              $c->req->param('id_volume'),
                              $c->req->param('controle'),
                              $representaDossieFisico,
                              $c->req->param('classificacao'),
                              $c->req->param('localizacao'),
                               );

        $self->audit_criar($id, $c->req->param('nome'));
    };


    if ($@) { $c->flash->{erro} = $@ . "";  }
    else { $c->flash->{sucesso} = 'Dossie criado com sucesso'; }
    $c->res->redirect( $c->uri_for('/auth/registros/volume/' . $c->req->param('id_volume') ) );
}

sub alterar_estado : Chained('base') : PathPart('alterar_estado') : Args(2) {
     my ( $self, $c, $controle, $estado ) = @_;
     eval {
             $c->model('Dossie')->alterar_estado($c->stash->{id_volume}, $controle, $estado, $c->req->address );
          };
    if ($@) {
        $c->flash->{erro} = $@;
    }
    else {
        $c->flash->{sucesso} = 'Estado alterado com sucesso!';
    }
    $self->audit_alterar('estado: ',$estado);
    $c->res->redirect( $c->uri_for('/auth/registros/volume/' . $c->stash->{id_volume}) );
}

sub transferir : Chained('base') : PathPart('transferir') : Args(1) {
     my ( $self, $c, $controle ) = @_;
#   Checa se user logado tem autorização para executar a ação 'Transferir'
    $c->model('Dossie')->pode_transferir_dossie($c->stash->{id_volume}) &&
       $c->model('Dossie')->pode_criar_dossie($c->req->param('volume_destino'))
          or $c->detach('/public/default');

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
    $c->res->redirect( $c->uri_for('/auth/registros/volume/' . $c->stash->{id_volume}) );
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
