package Acao::Controller::Auth::Admin::Schema;

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
use utf8;
#use Catalyst::Request::Upload;
#use File::Copy;
use utf8;
with 'Acao::Role::Auditoria' => { category => 'Admin-Schemas' };

my $diretorio = Acao->config->{'Model::Schema'}->{upload_schemas};

sub base : Chained('/auth/admin/base') : PathPart('schema') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

}

sub buscar : Chained('base') : PathPart('buscar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/schema/lista.tt';
    $c->stash->{busca}    = $c->req->param('busca');
    return;
}

sub form : Chained('base') : PathPart('inserir') : Args(0) {
    my ( $self, $c ) = @_;
    return;
}

sub store : Chained('base') : PathPart('store_upload') : Args(0) {
    my ( $self, $c ) = @_;

    my $dir = '/tmp/acao';
    unless(-d $dir){
        mkdir $dir or die "Diretório /tmp/acao não existe e não pode ser criado";
    }

    if ( $c->request->parameters->{form_submit} eq 'yes' ) {
        $c->stash->{template} = 'auth/admin/schema/form.tt';

        if ( my $upload = $c->req->upload('uploadSchema') ) {

            my $file_name = $upload->filename;
            my $target = $diretorio.$file_name;
            my $file_extension = ($file_name =~ m/([^.]+)$/)[0];

            #if (!($upload->type eq 'application/xml')) {
            if (!($file_extension eq 'xsd')) {

                $c->flash->{erro} = 'upload-arquivo';
                return;
            }

            unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
                die("Failed to copy '$file_name' to '$target': $!");
            }
            my $res = $c->model('Schema')->insere_schema('acao-schemas',$target,$file_name);
            if (!$res) {
                $c->flash->{erro} = 'xsd_duplicado';

            } else {
                $self->audit_criar('SCHEMA: ' . $file_name . ' CARREGADO POR: ' . $c->user->uid );
                $c->res->redirect( $c->uri_for_action('/auth/admin/schema/lista') );
                $c->flash->{sucesso} = 'Schema XSD enviado com com sucesso';
            }

        }

    }

    return;
}

sub validacao : Chained('base') : PathPart('validar')  : Args(1) {
    my ( $self, $c, $validacao ) = @_;
    my $XSDtargetNamespace = $c->req->param('XSDtargetNamespace');
    $c->model('Schema')->altera_validacao_schemas( $XSDtargetNamespace, $validacao );
    $self->audit_alterar('PERMISSAO SCHEMA: ' . $c->req->param('XSDtargetNamespace') . ' ALTERADA PARA ' . $validacao . ' POR: ' . $c->user->uid );
    $c->stash->{template} = 'auth/admin/schema/lista.tt';
    return;
}

sub form_substituir : Chained('base') : PathPart('form_substituir') : Args(0) {
    my ( $self, $c ) = @_;
    my $XSDtargetNamespace = $c->req->param('XSDtargetNamespace');
    my $countTNS = $c->model('Schema')->verifica_schemas( $XSDtargetNamespace );
    
    if ($countTNS != 0 ) {
        $c->res->redirect( $c->uri_for_action('/auth/admin/schema/lista') );
        $c->flash->{erro} = 'Existe(m) '.$countTNS.' documento(s) deste tipo persistido(s) no banco.';
        return;
    }

    return;
}

sub substituir_xsd : Chained('base') : PathPart('substituir_xsd') : Args(0) {
    my ( $self, $c ) = @_;
    my $XSDtargetNamespace = $c->req->param('XSDtargetNamespace');

    my $dir = '/tmp/acao';
    unless(-d $dir){
        mkdir $dir or die "Diretório /tmp/acao não existe e não pode ser criado";
    }

    if ( $c->request->parameters->{form_submit} eq 'yes' ) {
        $c->stash->{template} = 'auth/admin/schema/form_substituir.tt';
        if ( my $upload = $c->req->upload('uploadSchema') ) {

            my $file_name = $upload->filename;
            my $target = $diretorio.$file_name;
            my $file_extension = ($file_name =~ m/([^.]+)$/)[0];

            #if (!($upload->type eq 'application/xml')) {
            if (!($file_extension eq 'xsd')) {
                $c->flash->{erro} = 'upload-arquivo';
                return;
            }

            unless ( $upload->link_to($target) || $upload->copy_to($target) ) {
                die("Failed to copy '$file_name' to '$target': $!");
            }
            my $res = $c->model('Schema')->substituir_schema('acao-schemas',$target,$file_name);
            if (!$res) {
                $c->flash->{erro} = 'xsd_duplicado';

            } else {
                $self->audit_alterar('SCHEMA: ' . $file_name . ' SUBISTITUIDO POR : ' . $c->user->uid );
                $c->res->redirect( $c->uri_for_action('/auth/admin/schema/lista') );
                $c->flash->{sucesso} = 'Schema XSD enviado com com sucesso';
            }

        }

    }

    return;

}
1;
