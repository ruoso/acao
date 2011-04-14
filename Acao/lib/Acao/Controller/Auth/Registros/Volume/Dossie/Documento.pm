package Acao::Controller::Auth::Registros::Volume::Dossie::Documento;

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
use Data::Dumper;
use utf8;
BEGIN { extends 'Catalyst::Controller'; }

with 'Acao::Role::Auditoria' => { category => 'Documento' };
with 'Acao::Role::Controller::Autorizacao'   => { modelcomponent => 'Documento' };

=head1 NAME

Acao::Controller::Auth::Registros::Volume::Dossie::Documento - Controlador
que implementa as ações de digitação de uma leitura específica.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados do dossiê.

=cut

sub base : Chained('../get_dossie') : PathPart('') : CaptureArgs(0) {
    my ( $self, $c ) = @_;

}

sub get_documento : Chained('base') : PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id_documento ) = @_;
    Log::Log4perl::MDC->put( 'Documento', $id_documento );
    $c->stash->{id_documento} = $id_documento
      or $c->detach('/public/default');
    #   Checa se user logado tem autorização para Ver o Documento
    if (!$c->model('Documento')->pode_ver_documento($c->stash->{id_volume},
                                                    $c->stash->{controle},
                                                    $c->stash->{id_documento})) {
      $c->flash->{autorizacao} = 'documento-visualizar';
      $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},
                                                                                            $c->stash->{controle}] ));
      return;
    }
}

=item form

Delega à view a renderização do formulário desse dossiê.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;

    #   Checa se user logado tem autorização para listar documentos (Ver em Dossie)

    if ( !$c->model('Dossie')
        ->pode_ver_dossie( $c->stash->{id_volume}, $c->stash->{controle} ) )
    {
        $c->flash->{autorizacao} = 'dossie-visualizar';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/lista',[$c->stash->{id_volume}] ));
        return;
    }
}

sub form : Chained('base') : PathPart('inserirdocumento') : Args(0) {
    my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para Criar Documento
    if (!$c->model('Documento')->pode_criar_documento($c->stash->{id_volume},$c->stash->{controle})) {
      $c->flash->{autorizacao} = 'dossie-criar';
      $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},$c->stash->{controle}] ));
      return;
    } 
    if ($c->model('Volume')->get_estado_volume($c->stash->{id_volume}) ne 'aberto') {        
        $c->flash->{erro} = 'Volume fechado!';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/lista'));
        return;
    }


    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();
    $c->stash->{autorizacoes} = $c->model("Documento")->new_autorizacao();
    $c->stash->{basedn}       = $c->model("LDAP")->grupos_dn;
    $c->stash->{herdar} or $c->stash->{herdar} = 1;
}

sub store : Chained('base') : PathPart('store') : Args(0) {

    my ( $self, $c ) = @_;
    my $representaDocumentoFisico;
    my $id_volume    = $c->stash->{'id_volume'};
    my $controle     = $c->stash->{'controle'};
    my $id_documento = $c->req->param('id_documento');
    my $id;
    my $xml          = $c->request->param('processed_xml');
    my $xsdDocumento = $c->req->param('xsdDocumento');
    my $herdar_author;
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
    
    # Se o volume for fechado após a iniciação da criação ou edição de documento ele não permite que o documento seja inserido
    if ($c->model('Volume')->get_estado_volume($id_volume) ne 'aberto') {
        $c->flash->{erro} = 'Volume fechado!';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/lista'));
        return;
    }

    if ( $c->req->param('representaDocumentoFisico') eq 'on' ) {
        $representaDocumentoFisico = '1';
    }
    else {
        $representaDocumentoFisico = '0';
    }

    if ( $c->req->param('herdar_author') eq 'on' ) {
        $herdar_author = '1';
    }
    else {
        $herdar_author = '0';
    }

    $c->stash->{herdar} = $herdar_author;
    #   checagem se a requisição vem da view visualizar.tt
    if ( $self->_processa_autorizacao($c))
        {
            if ($c->req->param('view') eq 'visualizar')
            {

                 $c->stash->{'xsdDocumento'} = $c->req->param('xsdDocumento');
                 $c->stash->{'id_documento'} = $c->req->param('id_documento');
                 $c->stash->{'invalidacao'} = $c->req->param('invalidacao');
                 $c->stash->{'representaDocumentoFisico'} = $c->req->param('representaDocumentoFisico');

                $c->stash->{template} = 'auth/registros/volume/dossie/documento/visualizar.tt';
            } else
            {
                #   Checa se user logado tem autorização para Criar Documento
                if (!$c->model('Documento')->pode_criar_documento($c->stash->{id_volume},$c->stash->{controle})) {
                  $c->flash->{autorizacao} = 'dossie-criar';
                  $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},$c->stash->{controle}] ));
                  return;
                }

                $c->stash->{template} = 'auth/registros/volume/dossie/documento/form.tt';
            }

            return ;
        }




    eval {
        $id =
          $c->model('Documento')
          ->inserir_documento( $c->req->address,
                               $xml, $id_volume, $controle,
                               $xsdDocumento,
                               $representaDocumentoFisico,
                               $herdar_author,
                               $c->model('Documento')
                                ->desserialize_autorizacoes( $c->req->param('autorizacoes') ),
                                $id_documento );
        $self->audit_criar($id);

    };

    if ($@) { $c->flash->{erro} = $@ . ""; }
    else {
        $c->flash->{sucesso} = 'Documento criado com sucesso';
    }
    $c->res->redirect(
        $c->uri_for_action(
            '/auth/registros/volume/dossie/documento/lista',
            [ $c->stash->{id_volume}, $c->stash->{controle} ]
        )
    );
}

sub visualizar : Chained('get_documento') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para Ver Documento
    if (!$c->model('Documento')->pode_ver_documento($c->stash->{id_volume},
                                                    $c->stash->{controle},
                                                    $c->stash->{id_documento})) {
      $c->flash->{autorizacao} = 'documento-visualizar';
      $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},$c->stash->{controle}] ));
      return;
    }


    $c->stash->{xsdDocumento} = $c->model('Documento')->obter_xsd_documento(
        $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento}
    ) or $c->detach('/public/default');

    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();

    my $herdar = $c->model('Documento')->desserialize_autorizacoes(
        $c->model('Documento')->autorizacoes_de_documento(
            $c->stash->{id_volume},
            $c->stash->{controle},
            $c->stash->{id_documento})
    );

    $c->stash->{herdar} = $herdar->{herdar};
    $c->stash->{autorizacoes} = $c->model('Documento')
                                ->autorizacoes_de_documento( $c->stash->{id_volume},
                                                             $c->stash->{controle},
                                                             $c->stash->{id_documento}
                                                             );
    $c->stash->{basedn}       = $c->model("LDAP")->grupos_dn;

}

sub visualizar_por_tipo : Chained('get_documento') :
  PathPart('visualizarportipo') : Args(0) {
    my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para Ver Documento
    if (!$c->model('Documento')->pode_ver_documento($c->stash->{id_volume},$c->stash->{controle},$c->stash->{id_documento} )) {
      $c->flash->{autorizacao} = 'documento-visualizar';
      $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},$c->stash->{controle}] ));
      return;
    }

    $c->stash->{xsdDocumento} = $c->model('Documento')->obter_xsd_documento(
        $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento}
    ) or $c->detach('/public/default');
}

sub invalidar_documento : Chained('get_documento') :
  PathPart('invalidar_documento') : Args(0) {
    my ( $self, $c ) = @_;

    #   Checa se user logado tem autorização para alterar o Documento
    if (!$c->model('Documento')->pode_alterar_documento($c->stash->{id_volume},
                                        $c->stash->{controle},
                                        $c->stash->{id_documento})) {
        $c->flash->{autorizacao} = 'documento-invalidar';
        $c->res->redirect(
                $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},
                                                                                    $c->stash->{controle}] ));
        return;
    }

    eval {
        my $id = $c->model('Documento')->invalidar_documento(
            $c->stash->{id_volume},
            $c->stash->{controle},
            $c->stash->{id_documento},
        );
        $self->audit_alterar( 'Invalidar Documento: ', $id );
    };

    if   ($@) { $c->flash->{erro}    = $@ . ""; }
    else      { $c->flash->{sucesso} = 'Documento alterado com sucesso'; }
    $c->res->redirect(
        $c->uri_for_action(
            '/auth/registros/volume/dossie/documento/lista',
            [ $c->stash->{id_volume}, $c->stash->{controle} ]
        )
    );
}

sub xml : Chained('get_documento') : PathPart : Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{document} = $c->model('Documento')->visualizar(
        $c->stash->{id_volume},    $c->stash->{controle},
        $c->stash->{id_documento}, $c->req->address,
    );
    $c->forward( $c->view('XML') );
}


sub alterar : Chained('get_documento') : PathPart('alterar_documento') : Args(0) {
    my ($self, $c) = @_;

     #   Checa se user logado tem autorização para Alterar Documento
    if (!$c->model('Documento')->pode_alterar_documento($c->stash->{id_volume},
                                                    $c->stash->{controle},
                                                    $c->stash->{id_documento})) {
      $c->flash->{autorizacao} = 'documento-alterar';
      $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista',[$c->stash->{id_volume},$c->stash->{controle}] ));
      return;
    }
    $c->stash->{template} = 'auth/registros/volume/dossie/documento/form_alterar.tt';

    $c->stash->{xsdDocumento} = $c->model('Documento')->obter_xsd_documento(
        $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento}
    ) or $c->detach('/public/default');

    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();

    my $herdar = $c->model('Documento')->desserialize_autorizacoes(
        $c->model('Documento')->autorizacoes_de_documento(
            $c->stash->{id_volume},
            $c->stash->{controle},
            $c->stash->{id_documento})
    );

    $c->stash->{herdar} = $herdar->{herdar};
    $c->stash->{autorizacoes} = $c->model('Documento')
                                ->autorizacoes_de_documento( $c->stash->{id_volume},
                                                             $c->stash->{controle},
                                                             $c->stash->{id_documento}
                                                             );
    $c->stash->{basedn}       = $c->model("LDAP")->grupos_dn;


}


sub navega_ldap : Chained('base') : PathPart('navega_ldap') : Args(0){
    my ($self,$c) = @_;
    $c->stash->{template} = 'auth/registros/volume/dossie/documento/navega_ldap.tt';
    $c->stash->{basedn}       = $c->req->param('grupos');
    $c->stash->{autorizacoes} = $c->req->param('autorizacoes');
    return 1;

}

sub add_autorizacoes_grid : Chained('base') : PathPart('add_autorizacoes') : Args(0){
    my ($self,$c) = @_;
    $c->stash->{template} = 'auth/registros/volume/dossie/documento/grid_autorizacoes.tt';
    my @principal = split /-/, $c->req->param('grupos');
    my @role =  $c->req->param('role[]');
    my $permissoes = $c->model('Documento')->build_autorizacao_AoH( \@principal, \@role );
    $c->stash->{autorizacoes} = $c->model('Documento')->add_autorizacoes( $c->req->param('autorizacoes_ldap'), $permissoes );
    return 1;

}

sub remover_autorizacoes_grid : Chained('base') : PathPart('remover_autorizacoes_ldap') : Args(0){
    my ($self,$c) = @_;
    $c->stash->{template} = 'auth/registros/volume/dossie/documento/grid_autorizacoes.tt';
    my ($pos) = $c->req->param('posicao');
    if ($pos or $pos == 0 ) {
        $c->stash->{autorizacoes} =
        $c->model('Documento')->remove_autorizacoes( $c->req->param('autorizacoes_ldap'), $pos );
    } else  {
        $c->stash->{autorizacoes} = $c->req->param('autorizacoes_ldap');
    }
    return 1;

}

sub ver_autorizacoes_grid : Chained('get_documento') : PathPart('autorizacoes') : Args(0){
    my ($self,$c) = @_;
    $c->stash->{template} = 'auth/registros/volume/dossie/documento/grid_autorizacoes.tt';
    my $initial_principals = $c->model('LDAP')->memberof_grupos_dn();
    my $herdar = $c->model('Documento')->desserialize_autorizacoes(
    $c->model('Documento')->autorizacoes_de_documento(
        $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento})
    );
    $c->stash->{herdar} = $herdar->{herdar};
    $c->stash->{autorizacoes} = $c->model('Documento')
                                ->autorizacoes_de_documento( $c->stash->{id_volume},
                                                             $c->stash->{controle},
                                                             $c->stash->{id_documento}
                                                             );
    $c->stash->{basedn}       = $c->model("LDAP")->grupos_dn;
    return 1;

}

=item xml

Delega à view XML a exibição do documento específico.

=cut

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
