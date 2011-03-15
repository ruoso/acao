package Acao::Controller::Public::Servicos;

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
use parent 'Catalyst::Controller';
use Data::Dumper;

=head1 NAME

Acao::Controller::Public::Login - Implementa a chamada para o início
de uma sessão de usuário.

=head1 ACTIONS

=over


Faz a chamada para a lista de escolas

=cut

sub escolas : Chained('/') : PathPart('escolas') : Args(0) {
  
	my ($self, $c) = @_;
	my $nm_escola = $c->req->param('term');
	my $result = $c->model('Escolas')->listaEscolas($nm_escola);
	$c->stash->{json} = $result;
	
	warn Dumper($result);

	$c->forward('View::JSON');
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
