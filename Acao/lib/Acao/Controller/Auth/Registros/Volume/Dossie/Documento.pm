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
BEGIN { extends 'Catalyst::Controller'; }

with 'Acao::Role::Auditoria' => { category => 'Documento'};

=head1 NAME

Acao::Controller::Auth::Registros::Volume::Dossie::Documento - Controlador
que implementa as ações de digitação de uma leitura específica.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados do dossiê.

=cut


sub base : Chained('../get_dossie') :PathPart('') :CaptureArgs(0) {
    my ( $self, $c ) = @_;
    #   Checa se user logado tem autorização para executar a ação 'Ver' em Dossie

    if (!$c->model('Dossie')->pode_ver_dossie($c->stash->{id_volume},$c->stash->{controle})) {
        $c->flash->{autorizacao} = 'Você não tem autorização de ver este Prontuário';
        $c->res->redirect( $c->uri_for_action('/auth/registros/volume/lista',$c->stash->{id_volume}));
    }
}

sub get_documento :Chained('base') :PathPart('') :CaptureArgs(1) {
    my ( $self, $c, $id_documento ) = @_;
    Log::Log4perl::MDC->put('Documento', $id_documento);
    $c->stash->{id_documento} = $id_documento
      or $c->detach('/public/default');
}

=item form

Delega à view a renderização do formulário desse dossiê.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
 my ( $self, $c ) = @_;
}

sub form : Chained('base') : PathPart('inserirdocumento') : Args(0) {
}

sub store : Chained('base') : PathPart('store') : Args(0) {
    my ( $self, $c ) = @_;
    my $representaDocumentoFisico;
    my $id_volume = $c->stash->{'id_volume'};
    my $controle = $c->stash->{'controle'};
    my $id_documento = $c->req->param('id_documento');
    my $id;
    my $xml = $c->request->param('processed_xml');
    my $xsdDocumento = $c->req->param('xsdDocumento');

    if ($c->req->param('representaDocumentoFisico') eq 'on'){
       $representaDocumentoFisico = '1';
    }
    else {
       $representaDocumentoFisico = '0';
    }
    eval {
       $id =  $c->model('Documento')->inserir_documento(
                                      $c->req->address,
                                      $xml,
                                      $id_volume,
                                      $controle,
                                      $xsdDocumento,
                                      $representaDocumentoFisico,
                                      $id_documento,
                               );
    $self->audit_criar($id);

    };

    if ($@) { $c->flash->{erro} = $@ . "";  }
    else {
      $c->flash->{sucesso} = 'Documento criado com sucesso';
    }
    $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista', [ $c->stash->{id_volume}, $c->stash->{controle} ] ) );
}

sub visualizar : Chained('get_documento') :PathPart('') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{xsdDocumento} = $c->model('Documento')->obter_xsd_documento
      ( $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento} )
        or $c->detach('/public/default');
}

sub visualizar_por_tipo : Chained('get_documento') :PathPart('visualizarportipo') :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash->{xsdDocumento} = $c->model('Documento')->obter_xsd_documento
      ( $c->stash->{id_volume},
        $c->stash->{controle},
        $c->stash->{id_documento} )
        or $c->detach('/public/default');
}

sub invalidar_documento : Chained('get_documento') : PathPart('invalidar_documento') : Args(0){
    my ( $self, $c) = @_;
      eval {
        my $id = $c->model('Documento')->invalidar_documento(
                                                  $c->stash->{id_volume},
                                                  $c->stash->{controle},
                                            $c->stash->{id_documento},
                                           );
       $self->audit_alterar('Invalidar Documento: ',$id );
        };

    if ($@) { $c->flash->{erro} = $@ . "";  }
    else { $c->flash->{sucesso} = 'Documento alterado com sucesso'; }
    $c->res->redirect( $c->uri_for_action('/auth/registros/volume/dossie/documento/lista', [ $c->stash->{id_volume}, $c->stash->{controle} ] ) );
}

sub xml : Chained('get_documento') : PathPart : Args(0) {
    my ( $self, $c) = @_;
    $c->stash->{document} = $c->model('Documento')->visualizar( $c->stash->{id_volume},
                                                                $c->stash->{controle},
                                                                $c->stash->{id_documento},
                                                                $c->req->address,
                                                              );
    $c->forward( $c->view('XML') );
}

=item xml

Delega à view XML a exibição do documento específico.

=cut

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
