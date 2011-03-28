package Acao;

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

=head1 NAME

Acao - Módulo principal da aplicação

=head1 DESCRIPTION

Este é o módulo principal da aplicação Catalyst, declara os plugins a
serem carregados e a versão da aplicação.

=head1 METHODS

=cut

use strict;
use warnings;

use Catalyst::Runtime 5.70;

use parent qw/Catalyst/;
use Catalyst qw/
  -Debug
  Unicode
  ConfigLoader
  Static::Simple
  StackTrace
  Authentication
  Session
  Session::Store::DBIC
  Session::State::Cookie/;

our $VERSION = '0.01';

use Catalyst::Log::Log4perl;

__PACKAGE__->log(
    Catalyst::Log::Log4perl->new( __PACKAGE__->path_to('Log4perl.conf') . '' )
);

__PACKAGE__->setup();

=over

=item finalize_error

Implementa o tratamento de erros que possam acontecer mesmo na etapa
final do processamento da requisição. O que inclui especificamente as
exceções disparadas durante a renderização do template realizada na
ação "end" do controlador "Root".

=back

=cut

sub finalize_error {
    my ($c) = @_;
    if ( scalar @{ $c->error } ) {
        $c->flash->{erro} = join '', @{ $c->error };
        $c->res->redirect( $c->uri_for_action('/public/erro') );
        $c->error(0);
        return 0;
    }
    else {
        return 1;
    }
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;

