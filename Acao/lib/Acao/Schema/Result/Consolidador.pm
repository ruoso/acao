package Acao::Schema::Result::Consolidador;
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

use base 'DBIx::Class';

=head1 NAME

Acao::Schema::Result::Consolidador - Resultsource da tabela consolidador

=head1 DESCRIPTION

Esta entidade descreve os usuários autorizados a executar a
consolidação de uma determinada definição.

=cut

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("consolidador");
__PACKAGE__->add_columns(
    "id_definicao_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "dn",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key( "id_definicao_consolidacao", "dn" );
__PACKAGE__->belongs_to(
    "definicao_consolidacao",
    "Acao::Schema::Result::DefinicaoConsolidacao",
    { id_definicao_consolidacao => "id_definicao_consolidacao" },
);

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
