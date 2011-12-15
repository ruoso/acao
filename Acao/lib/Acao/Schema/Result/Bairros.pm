package Acao::Schema::Result::Bairros;

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
use Moose;
use base 'DBIx::Class::Core';

=head1 NAME

Acao::Schema::Result::Escolas - Resultsource da tabela escolas

=head1 DESCRIPTION

Este objeto define a lsita de escolas do autocomplete

=cut

__PACKAGE__->table("bairros");


__PACKAGE__->add_columns(
    "nome",
    {
        data_type         => "varchar",
        default_value     => undef,
        is_nullable       => 0,
        size              => undef,
    },
    "regional",
    {
        data_type         => "varchar",
        default_value     => undef,
        is_nullable       => 0,
        size              => undef,
    },
);


=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
