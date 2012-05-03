package Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao::Consolidacao;

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

Acao::Controller::Auth::Registros::Consolidador::DefinicaoConsolidacao::Consolidacao -
Implementa as ações específicas a uma consolidação.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados dessa consolidacao.

=cut

sub base : Chained('/auth/registros/consolidador/definicaoconsolidacao/base') :
  PathPart('') : CaptureArgs(1) {
    my ( $self, $c, $id_consolidacao ) = @_;
    $c->stash->{consolidacao} =
      $c->stash->{definicao_consolidacao}
      ->consolidacao->find( { id_consolidacao => $id_consolidacao } )
      or $c->detach('/public/default');
}

=item lista

Delega para a view a renderização dos dados dessa consolidacao.

=cut

sub lista : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
}

=item entradas

Delega à view a exibição dos documentos que serviram de entrada para
esse documento consolidado.

=cut

sub entradas : Chained('base') : PathPart : Args(1) {
    my ( $self, $c, $id_documento_consolidado ) = @_;
    $c->stash->{id_documento_consolidado} = $id_documento_consolidado;
}

=item fragmentos_alertas

Delega à view a exibição de um fragmento dos alertas para que a tabela
de alertas possa ser alimentada sem refresh através de ajax.

=cut

sub fragmentos_alertas : Chained('base') : PathPart : Args(1) {
    my ( $self, $c, $id_alerta ) = @_;
    $c->stash->{id_alerta} = $id_alerta;
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
