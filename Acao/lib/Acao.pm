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

use strict;
use warnings;

use Catalyst::Runtime 5.70;

use parent qw/Catalyst/;
use Catalyst qw/-Debug
  ConfigLoader
  Static::Simple
  StackTrace
  Authentication
  Session
  Session::Store::FastMmap
  Session::State::Cookie/;

our $VERSION = '0.01';
__PACKAGE__->setup();

# Implementa o tratamento de erros que possam acontecer até a chamada
# do "end".
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

1;
