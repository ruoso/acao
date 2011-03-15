package Acao::Model::Escolas;


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
extends 'Acao::Model';
use Data::Dumper;
use Encode;
use strict;
use warnings;

sub listaEscolas {
	my ($self, $nm_escola ) = @_;

	my @escolas;

	my @result = $self->dbic->resultset('Escolas')->search(
		{ nome => { ilike => '%'.$nm_escola.'%' } },
		{columns => ['nome']}
	);

	for my $rset (@result) {
		#gambiarra para evitar o encode do encode feito pelo JSON
		push @escolas, decode("utf-8", $rset->nome);
#		push @escolas, $rset->nome;
	}

	return \@escolas;
}

1;
