package Acao::Schema::Result::DefinicaoConsolidacao;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("definicao_consolidacao");
__PACKAGE__->add_columns(
    "id_definicao_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        is_auto_increment => 1,
        size          => undef,
	is_auto_increment => 1,
    },
    "id_projeto",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "xml_schema",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "nome",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "status",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "data_ini",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "data_fim",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key("id_definicao_consolidacao");
__PACKAGE__->has_many(
    "entrada_consolidacao",
    "Acao::Schema::Result::EntradaConsolidacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_coleta_dados",
    "Acao::Schema::Result::EtapaColetaDados",
    {"foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_transformacao",
    "Acao::Schema::Result::EtapaTransformacao",
    {"foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_validacao",
    "Acao::Schema::Result::EtapaValidacao",
    {"foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "consolidacao",
    "Acao::Schema::Result::Consolidacao",
    {"foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "consolidador",
    "Acao::Schema::Result::Consolidador",
    {"foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);

__PACKAGE__->belongs_to(
    "projeto",
    "Acao::Schema::Result::Projeto",
    {id_projeto => "id_projeto"},
);
# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FsIJYOczJWUu8QfQqGghQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
