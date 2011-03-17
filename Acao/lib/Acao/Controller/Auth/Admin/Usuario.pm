package Acao::Controller::Auth::Admin::Usuario;

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
use XML::Simple;

#with 'Acao::Role::Controller::Requisicao';

sub base : Chained('/auth/admin/base') : PathPart('usuario') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub getUsuario : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $dn_usuario ) = @_;
    $c->stash->{dn_usuario} = $dn_usuario;
}

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my @usuarios = $c->model('Usuario')->buscar_usuarios();
    $c->stash->{usuarios} = \@usuarios;

    return;
}

sub adicionar_usuario : Chained('base') : PathPart('cadastrar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{lotacao} = '<opt> </opt>';

}

sub navega_ldap : Chained('base') : PathPart('navega_ldap') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template}     = 'auth/admin/usuario/navega_ldap.tt';
    $c->stash->{basedn}       = $c->req->param('grupos');
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
    return 1;

}

sub ver_user : Chained('getUsuario') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/usuario/usuario.tt';
    $c->stash->{usuario}  =
      $c->model('Usuario')->getDadosUsuarioLdap( $c->stash->{dn_usuario} );
    warn Dumper( $c->stash->{usuario} );

}

sub alterar : Chained('getUsuario') : PathPart('alterar') : Args(0) {
    my ( $self, $c ) = @_;

}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    my $result;
    my $volumeArray    = [ $c->req->param('volume[]') ];
    my $dossieArray    = [ $c->req->param('dossie[]') ];
    my $documentoArray = [ $c->req->param('documento[]') ];
    my $lotacaoArray   = desserialize( $c->req->param('lotacao') )->{value};
    if ( ref($lotacaoArray) ne 'ARRAY' ) {
        $lotacaoArray = [ desserialize( $c->req->param('lotacao') )->{value} ];
    }
    my $super = $c->req->param('super');



    eval {
        $result = $c->model('Usuario')->storeUsuario(
            {
                'senha'     => $c->req->param('senha'),
                'id'        => $c->req->param('uid'),
                'nome'      => $c->req->param('nome'),
                'sobrenome' => $c->req->param('sobrenome'),
                'email'     => $c->req->param('email'),
                'fone'      => $c->req->param('fone'),
                'dominio'   => $c->req->param('dominio'),
                'volume'    => $volumeArray,
                'dossie'    => $dossieArray,
                'documento' => $documentoArray,
                'lotacao'   => $lotacaoArray,
                'super'   => $super,
            }
        );
    };
    warn Dumper($result);

    if ( $result->{resultCode} ne '0' ) {
        $c->flash->{erro} = 'ldap-' .$result->{resultCode};
        $c->res->redirect(
            $c->uri_for_action('/auth/admin/usuario/adicionar_usuario') );
        return;
    }
    else {
        $c->flash->{sucesso} = 'Adicionado';

    }
    $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/lista') );

}

sub add : Chained('base') : PathPart('add') : Args(0) {
    my ( $self, $c, ) = @_;
    $c->stash->{template} = 'auth/admin/usuario/grid_lotacao.tt';
    my @principal = split /-/, $c->req->param('grupos');
    my $hash_old = desserialize( $c->req->param('lotacao') );
    if ( scalar keys %$hash_old == 0 ) {
        $hash_old = { value => [] };
    }
    if ( ref( $hash_old->{value} ) ne 'ARRAY' ) {
        $hash_old = { value => [ $hash_old->{value} ] };
    }
    my $hash   = { value => [ map { $_ } @principal ] };
    my $arrayA = $hash_old->{value};
    my $arrayB = $hash->{value};
    push( @$arrayA, @$arrayB );
    my $lotacao = serialize($hash_old);
    $c->stash->{lotacao}  = $lotacao;
    $c->stash->{lotacoes} = { value => $arrayA };

}

sub desserialize {
    my ($xml_) = @_;
    my $xml = new XML::Simple;
    return $xml->XMLin($xml_);
}

sub serialize {
    my ($hash) = @_;
    my $xml = new XML::Simple;
    return $xml->XMLout($hash);

}

sub remove : Chained('base') : PathPart('remover') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/usuario/grid_lotacao.tt';
    my $hash  = desserialize( $c->req->param('xmllotacao') );
    my $array = $hash->{value};

    if ( scalar($array) <= 1 ) {
        $array = [];
    }
    delete $array->[ $c->req->param('posicao') ];
    join ',', splice @$array, $c->req->param('posicao'), 1;
    my $lotacao = serialize( { value => [@$array] } );
    $c->stash->{lotacao}  = $lotacao;
    $c->stash->{lotacoes} = { value => [@$array] };

}

1;
