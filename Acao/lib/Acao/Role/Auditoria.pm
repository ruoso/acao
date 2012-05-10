package Acao::Role::Auditoria;

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
use XML::LibXML;
use strict;
use warnings;
use 5.10.0;
use MooseX::Role::Parameterized;
use XML::Compile::Util;

parameter category => (
    isa      => 'Str',
    required => 1,
);

role {
    my $p      = shift;
    my $cat    = $p->category;
    my $logger = Log::Log4perl->get_logger( "AUDIT::" . $cat );

    method 'audit_listar' => sub {
        my ( $self, $id ) = @_;
        $id =~ s/^\s+|\s+$//gs;
        Log::Log4perl::MDC->put( $cat, $id );
        $logger->info('listar');
    };

    method 'audit_criar' => sub {
        my ( $self, $id, @info ) = @_;
        $id =~ s/^\s+|\s+$//gs;
        Log::Log4perl::MDC->put( $cat, $id );
        $logger->info( 'criar: ', @info );
    };

    method 'audit_ver' => sub {
        my ($self) = @_;
        $logger->info('ver');
    };

    method 'audit_alterar' => sub {
        my ( $self, @info ) = @_;
        $logger->info( 'alterar: ', @info );
    };

    method 'audit_remover' => sub {
        my ( $self, @info ) = @_;
        $logger->info( 'remover: ', @info );
    };
};

1;
