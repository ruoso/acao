package Acao::Schema::Result::Alertas;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("alertas");
__PACKAGE__->add_columns(
    "id_alerta",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        is_auto_increment => 1,
        size          => undef,
	is_auto_increment => 1,
    },
    "id_consolidacao",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "etapa",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "log_level",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "datahora",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "id_documento_consolidado",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
    "descricao_alerta",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 0,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key( "id_alerta" );
__PACKAGE__->belongs_to(
    "consolidacao",
    "Acao::Schema::Result::Consolidacao",
    { id_consolidacao => "id_consolidacao" },
);

# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:I1IaVLdFHe9x7aJTO7bdCQ

# You can replace this text with custom content, and it will be preserved on regeneration
1;
