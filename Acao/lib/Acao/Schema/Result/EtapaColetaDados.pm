package Acao::Schema::Result::EtapaColetaDados;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("etapa_coleta_dados");
__PACKAGE__->add_columns(
    "id_definicao_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "plugin_coleta_dados",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "ordem_coleta_dados",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
#__PACKAGE__->set_primary_key("id_projeto");
__PACKAGE__->belongs_to(
    "definicao_consolidacao",
    "Acao::Schema::Result::DefinicaoConsolidacao",
    { id_definicao_consolidacao => "id_definicao_consolidacao" },
);

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FsIJYOczJWUu8QfQqGghQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
