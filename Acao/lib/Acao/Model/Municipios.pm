package Acao::Model::Municipios;


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

sub listaMunicipios {
	my ($self, $dsc_munic ) = @_;

	my @logradouros;

	$dsc_munic = uc($dsc_munic);

	my @result = $self->dbic->resultset('Municipios')->search(
		{ nome => { like => '%'.$dsc_munic.'%' } },
		{ columns => ['nome']},
		{ rows => 30},
	);

	for my $rset (@result) {
		push @logradouros, decode("utf-8", $rset->nome);
	}

	return \@logradouros;
}

1;
