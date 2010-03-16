package Acao::Schema::Result::EntradaConsolidacao;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("entrada_consolidacao");
__PACKAGE__->add_columns(
    "id_definicao_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "id_leitura",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "papel_leitura",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key( "id_definicao_consolidacao", "id_leitura" );
__PACKAGE__->belongs_to(
    "leitura",
    "Acao::Schema::Result::Leitura",
    { id_leitura => "id_leitura" },
);

__PACKAGE__->belongs_to(
    "definicao_consolidacao",
    "Acao::Schema::Result::DefinicaoConsolidacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1FsIJYOczJWUu8QfQqGghQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
