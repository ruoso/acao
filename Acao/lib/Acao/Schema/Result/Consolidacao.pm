package Acao::Schema::Result::Consolidacao;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("consolidacao");
__PACKAGE__->add_columns(
    "id_consolidacao",
    {
        data_type         => "integer",
        default_value     => undef,
        is_nullable       => 0,
        is_auto_increment => 1,
        size              => undef,
        is_auto_increment => 1,
    },
    "id_definicao_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
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
    "dn",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "status",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key("id_consolidacao");
__PACKAGE__->belongs_to(
    "definicao_consolidacao",
    "Acao::Schema::Result::DefinicaoConsolidacao",
    { id_definicao_consolidacao => "id_definicao_consolidacao" },
);

__PACKAGE__->has_many(
    "alertas",
    "Acao::Schema::Result::Alertas",
    { "foreign.id_consolidacao" => "self.id_consolidacao" },
);

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:I1IaVLdFHe9x7aJTO7bdCQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
