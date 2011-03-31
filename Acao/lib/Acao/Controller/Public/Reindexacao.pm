package Acao::Controller::Public::Reindexacao;

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

Acao::Controller::Public::Reindexacao - Implementa a reindexação dos documentos

=head1 ACTIONS

=over


Reindexa os dados dos documentos do volume escolhido

=cut

# realiza a reindexação de todos os documentos que fazem parte do volume escolhido
sub reindexa : Chained('/') : PathPart('reindexa') : Args(1) {
  
	my ($self, $c, $id_volume) = @_;
warn "TESTE";
    $c->model('Volume')->reindexa($id_volume);

}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
