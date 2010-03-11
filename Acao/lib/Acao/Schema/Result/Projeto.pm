package Acao::Schema::Result::Projeto;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("projeto");
__PACKAGE__->add_columns(
    "id_projeto",
    {
        data_type     => "serial",
        default_value => undef,
        is_nullable   => 0,
        is_auto_increment => 1,
        size          => undef,
    },
    "nome",
    {
        data_type     => "TEXT",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key("id_projeto");
__PACKAGE__->has_many(
    "instrumentos",
    "Acao::Schema::Result::Instrumento",
    { "foreign.id_projeto" => "self.id_projeto" },
);
__PACKAGE__->has_many(
    "definicao_consolidacao",
    "Acao::Schema::Result::DefinicaoConsolidacao",
    { "foreign.id_projeto" => "self.id_projeto" },
);

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FsIJYOczJWUu8QfQqGghQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
