package Acao::Schema::Result::Leitura;
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

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("leitura");
__PACKAGE__->add_columns(
    "id_leitura",
    {
        data_type         => "serial",
        default_value     => undef,
        is_nullable       => 0,
        is_auto_increment => 1,
        size              => undef,
        is_auto_increment => 1,
    },
    "id_projeto",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "nome",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "coleta_ini",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "coleta_fim",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "digitacao_ini",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "digitacao_fim",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "revisao_ini",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "revisao_fim",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key("id_leitura");
__PACKAGE__->has_many(
    "digitadores",
    "Acao::Schema::Result::Digitador",
    { "foreign.id_leitura" => "self.id_leitura" },
);
__PACKAGE__->has_many(
    "revisores",
    "Acao::Schema::Result::Revisor",
    { "foreign.id_leitura" => "self.id_leitura" },
);
__PACKAGE__->has_many(
    "entrada_consolidacao",
    "Acao::Schema::Result::EntradaConsolidacao",
    { "foreign.id_leitura" => "self.id_leitura" },
);
__PACKAGE__->belongs_to(
    "instrumento",
    "Acao::Schema::Result::Instrumento",
    { id_projeto => "id_projeto", nome => "nome" },
);

1;
