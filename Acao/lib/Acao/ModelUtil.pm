package Acao::ModelUtil;
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
use base 'Exporter';

use Data::Dumper;
our @EXPORT = qw(txn_method authorized);

sub txn_method {
    my ( $name, $code ) = @_;
    my $method_name = caller() . '::' . $name;
    no strict 'refs';
    *{$method_name} = sub {
        my $ret;
        my $committed = 0;
        eval {
            $_[0]->sedna->begin;
            $ret = $_[0]->dbic->txn_do( $code, @_ );
            $_[0]->sedna->commit;
            $committed = 1;
        };
        if ($@) {
            my $erro_original = $@;
            eval { $_[0]->sedna->rollback unless $committed; };
            die $erro_original;
        }
        $ret;
    };
}

sub authorized {
    my ( $role, $code ) = @_;
    return sub {
        if ( grep { $_ eq $role } $_[0]->user->roles ) {
            $code->(@_);
        }
        else {
            die 'access-denied!';
        }
      }
}

1;
