package Acao::Model::Sedna;
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
use utf8;

use base 'Catalyst::Model::Sedna';

sub new {
    my $self = shift;
    $self = $self->SUPER::new(@_);
    $self->conn->setConnectionAttr(
        AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );
    return $self;
}

sub get_document {
    my ( $self, $doc ) = @_;
    $self->execute( 'for $x in doc("' . $doc . '") return $x' );
    my $data = $self->get_item;
    return $data;
}

sub store_document {
    my ( $self, $xml, $doc_id, $collection ) = @_;
    $self->conn->loadData( $xml, $doc_id, $collection );
    $self->conn->endLoadData();
}

42;
