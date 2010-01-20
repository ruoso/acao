package Acao::Schema::Result::Instrumento;

use strict;
use warnings;

use base 'DBIx::Class';

__PACKAGE__->load_components("InflateColumn::DateTime", "Core");
__PACKAGE__->table("instrumento");
__PACKAGE__->add_columns(
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
  "xml_schema",
  {
    data_type => "varchar",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
  "campo_controle",
  {
    data_type => "varchar",
    default_value => undef,
    is_nullable => 0,
    size => undef,
  },
);
__PACKAGE__->set_primary_key("id_projeto", "nome");
__PACKAGE__->belongs_to(
  "projeto",
  "Acao::Schema::Result::Projeto",
  { id_projeto => "id_projeto" },
);
__PACKAGE__->has_many(
  "leituras",
  "Acao::Schema::Result::Leitura",
  {
    "foreign.id_projeto" => "self.id_projeto",
    "foreign.nome"       => "self.nome",
  },
);


# Created by DBIx::Class::Schema::Loader v0.04006 @ 2010-01-19 17:15:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cIgjAUL9ySCKtMJnpXeptw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
