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
with 'Acao::Role::Auditoria' => { category => 'Admin.Usuario' };

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

    #my %usuarios = $c->model('Usuario')->buscar_usuarios();

    #$c->stash->{usuarios} = \%usuarios;

    return;
}

sub adicionar_usuario : Chained('base') : PathPart('cadastrar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{lotacao}   = '<opt> </opt>';

    $c->stash->{uid}       = $c->req->param('uid');
    $c->stash->{nome}      = $c->req->param('nome');
    $c->stash->{sobrenome} = $c->req->param('sobrenome');
    $c->stash->{email}     = $c->req->param('email');
    $c->stash->{fone}      = $c->req->param('fone');

}

sub navega_ldap : Chained('base') : PathPart('navega_ldap') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template}     = 'auth/admin/usuario/navega_ldap.tt';
    $c->stash->{basedn}       = $c->req->param('grupos');
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
    return 1;

}

sub ver_user : Chained('getUsuario') : PathPart('ver') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/usuario/usuario.tt';

    $c->stash->{usuario} =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'adm' );

    $c->stash->{usuario_sistema} =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'acao' );

}

sub alterar_lotacao : Chained('getUsuario') : PathPart('alterar_lotacao')
  : Args(0)
{
    my ( $self, $c ) = @_;

    $c->model('Usuario')->validaUser( $c->stash->{dn_usuario} )
      or $c->detach('/public/default');

    $c->stash->{usuario} =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'adm' );
    my @lotacoes = $c->stash->{usuario}->{memberOf};
    $c->stash->{lotacoes} = ( { value => @lotacoes } );
    $c->stash->{lotacao}  = serialize( $c->stash->{lotacoes} );

}

sub trazer_user : Chained('getUsuario') : PathPart('alterar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{usuario} =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'acao' );

}

sub alterar_senha : Chained('getUsuario') : PathPart('alterar_senha') : Args(0)
{
    my ( $self, $c ) = @_;
    $c->stash->{usuario} =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'acao' );
}

sub searchUser : Chained('base') : PathPart('buscar') : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{template} = 'auth/admin/usuario/lista.tt';
    my $pesquisa = $c->req->param('buscar');
    my $campo    = $c->req->param('campo');

    my %usuarios =
      $c->model('Usuario')
      ->buscar_usuarios(
        { pesquisa => $pesquisa, campo => $campo, filtro => $campo } );
    $c->stash->{usuarios} = \%usuarios;

}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    my $result;
    if (!$c->req->param('senha')) {
        $c->flash->{erro} = 'ldap-100';
        $c->res->redirect(
            $c->uri_for_action(
                '/auth/admin/usuario/adicionar_usuario',
                {

                    uid       => $c->req->param('uid'),
                    nome      => $c->req->param('nome'),
                    sobrenome => $c->req->param('sobrenome'),
                    email     => $c->req->param('email'),
                    fone      => $c->req->param('fone')
                }

            )
        );
        return;
    }
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

                # 'dominio'   => $c->req->param('dominio'),
                'volume'    => $volumeArray,
                'dossie'    => $dossieArray,
                'documento' => $documentoArray,
                'lotacao'   => $lotacaoArray,
                'super'     => $super,
            }
        );
    };

    if ( $result->{resultCode} ne '0' ) {
        $c->flash->{erro} = 'ldap-' . $result->{resultCode};
        $c->res->redirect(
            $c->uri_for_action(
                '/auth/admin/usuario/adicionar_usuario',
                {

                    uid       => $c->req->param('uid'),
                    nome      => $c->req->param('nome'),
                    sobrenome => $c->req->param('sobrenome'),
                    email     => $c->req->param('email'),
                    fone      => $c->req->param('fone')
                }

            )
        );
        return;
    }
    else {
        $c->flash->{sucesso} = 'Adicionado';
        $self->audit_criar(
            'Usuário : ' . $c->req->param('uid') . ' POR : ' . $c->user->uid );

        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/searchUser',{ buscar => $c->req->param('uid') }) );

    }

}

sub add : Chained('base') : PathPart('add') : Args(0) {
    my ( $self, $c ) = @_;
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

sub store_lotacao : Chained('getUsuario') : PathPart('store_lotacao') : Args(0)
{
    my ( $self, $c ) = @_;

    $c->model('Usuario')->validaUser( $c->stash->{dn_usuario} )
      or $c->detach('/public/default');
    $self->audit_alterar(
        'LOTACAO DE : ' . $c->stash->{dn_usuario} . ' POR : ' . $c->user->uid );

    my $lotacaoDelete =
      desserialize( $c->req->param('lotacaoAnterior') )->{value};

    if ( ( ref($lotacaoDelete) ne 'ARRAY' ) ) {
        if ( $lotacaoDelete eq '' ) {
            $lotacaoDelete = [];
        }
        else {
            $lotacaoDelete = [$lotacaoDelete];
        }
    }

    my $lotacao = desserialize( $c->req->param('lotacao') )->{value};

    if ( ( ref($lotacao) ne 'ARRAY' ) ) {
        if ( $lotacao eq '' ) {
            $lotacao = [];
        }
        else {
            $lotacao = [$lotacao];
        }
    }

    my $result = $c->model('Usuario')->storeAlterarLotacao(
        {
            dn       => $c->stash->{dn_usuario},
            lotacao  => $lotacao,
            lotacaoD => $lotacaoDelete
        }
    );

    if ( $result->{resultCode} ne '0' ) {
        $c->flash->{erro} = 'ldap-' . $result->{resultCode};
        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/lista') );
        return;
    }
    else {
        $c->flash->{sucesso} = 'Adicionado';

    }
    $c->res->redirect(
        $c->uri_for_action(
            '/auth/admin/usuario/ver_user',
            [ $c->stash->{dn_usuario} ]
        )
    );

}

sub delete : Chained('getUsuario') : PathPart('delete') : Args(0) {
    my ( $self, $c ) = @_;

    $c->model('Usuario')->validaUser( $c->stash->{dn_usuario} )
      or $c->detach('/public/default');

    my $result;
    my $memberOf =
      $c->model('Usuario')
      ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'acao' )->{memberOf};

    foreach my $dnAcao (@$memberOf) {
        $result =
          $c->model('LDAP')
          ->LDAPDeleteMemberEntry( $dnAcao, $c->stash->{dn_usuario} );
    }

    if ( $result->{resultCode} ne '0' ) {
        $c->flash->{erro} = 'ldap-' . $result->{resultCode};
        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/lista') );
        return;
    }
    else {
        $c->flash->{sucesso} = 'Removido';
        $self->audit_remover( 'Usuário do ação : '
              . $c->stash->{dn_usuario}
              . ' POR : '
              . $c->user->uid );
        my $uid = $c->stash->{dn_usuario};
        $uid =~ s/^uid=(.*?),.*/$1/o;
        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/searchUser',{ buscar => $uid }) );
    }


}

sub store_alterar : Chained('getUsuario') : PathPart('store_alterar') : Args(0)
{
    my ( $self, $c ) = @_;
    my $result;
    my $delete         = $c->req->param('delete');
    my $volumeArray    = [ $c->req->param('volume[]') ];
    my $dossieArray    = [ $c->req->param('dossie[]') ];
    my $documentoArray = [ $c->req->param('documento[]') ];
    my $super          = $c->req->param('super');
    $self->audit_alterar( 'PERMISSOES DE : '
          . $c->stash->{dn_usuario}
          . ' POR : '
          . $c->user->uid );

    if ($delete) {

        my $memberOf =
          $c->model('Usuario')
          ->getDadosUsuarioLdap( $c->stash->{dn_usuario}, 'acao' )->{memberOf};

        foreach my $dnAcao (@$memberOf) {
            $c->model('LDAP')
              ->LDAPDeleteMemberEntry( $dnAcao, $c->stash->{dn_usuario} );
        }

    }

    eval {
        $result = $c->model('Usuario')->storeAlterarUsuario(
            {
                'volume'    => $volumeArray,
                'dossie'    => $dossieArray,
                'documento' => $documentoArray,
                'super'     => $super,
                'dn'        => $c->stash->{dn_usuario},
            }
        );
    };

    if ( $result->{resultCode} ne '0' ) {
        $c->flash->{erro} = 'ldap-' . $result->{resultCode};
        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/lista') );
        return;
    }
    else {
        $c->flash->{sucesso} = 'Adicionado';
        my $uid = $c->stash->{dn_usuario};
        $uid =~ s/^uid=(.*?),.*/$1/o;
        $c->res->redirect( $c->uri_for_action('/auth/admin/usuario/searchUser',{ buscar => $uid }) );

    }

}

sub store_alterar_senha : Chained('getUsuario')
  : PathPart('store_alterar_senha') : Args(0)
{
    my ( $self, $c ) = @_;

    my $result = $c->model('LDAP')->changeMemberPassword(
        {
            'new_pass' => $c->req->param('new_pass'),
            'dn'       => $c->req->param('dn')
        }
    );

    $c->stash->{resultado} = $result->{resultCode};
    $self->audit_alterar('SENHA DE : ' . $c->stash->{dn_usuario} . ': POR: ' . $c->user->uid );
    $c->stash->{template} = 'auth/admin/usuario/sucesso_alter_pass.tt';

}

sub alterar_permissoes : Chained('getUsuario') : PathPart('alterar_permissoes')
  : Args(0)
{
    my ( $self, $c ) = @_;
    $c->stash->{usuario} =
      $c->model('Usuario')->getDadosUsuarioLdap( $c->stash->{dn_usuario} );
    $c->stash->{volume} =
      $c->model('Usuario')
      ->recebePermissoesAcao( $c->stash->{dn_usuario}, 'volume' );
    $c->stash->{dossie} =
      $c->model('Usuario')
      ->recebePermissoesAcao( $c->stash->{dn_usuario}, 'dossie' );
    $c->stash->{documento} =
      $c->model('Usuario')
      ->recebePermissoesAcao( $c->stash->{dn_usuario}, 'documento' );

}

1;
