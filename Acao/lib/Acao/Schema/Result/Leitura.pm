package Acao::Schema::Result::Leitura;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("leitura");
__PACKAGE__->add_columns(
  "id_leitura",
  {
    data_type => "serial",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "id_projeto",
  {
    data_type => "integer",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "nome",
  {
    data_type => "varchar",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "coleta_ini",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "coleta_fim",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "digitacao_ini",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "digitacao_fim",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "revisao_ini",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
  },
  "revisao_fim",
  {
    data_type => "timestamp with time zone",
    default_value => undef,
    is_nullable => 1,
    size => undef,
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
__PACKAGE__->belongs_to(
  "instrumento",
  "Acao::Schema::Result::Instrumento",
  { id_projeto => "id_projeto", nome => "nome" },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:75f0z0gyNckf3W8dWq4lhw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
