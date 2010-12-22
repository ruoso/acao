package Acao::Schema::Result::Volume;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DBIx::Class::Schema::Loader::Result::Volume

=cut

__PACKAGE__->table("volume");

=head1 ACCESSORS

=head2 id_volume

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'volume_id_volume_seq'

=head2 nome

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 id_projeto

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 status

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 data_criacao

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 data_fechamento

  data_type: 'timestamp with time zone'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id_volume",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "volume_id_volume_seq",
  },
  "nome",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "id_projeto",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "status",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "data_criacao",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "data_fechamento",
  { data_type => "timestamp with time zone", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id_volume");

__PACKAGE__->has_many(
    "instrumento",
    "Acao::Schema::Result::Instrumento",
    { "foreign.nome" => "self.nome" },
);
__PACKAGE__->has_many(
    "gestor_volumes",
    "Acao::Schema::Result::GestorVolume",
    { "foreign.id_volume" => "self.id_volume" },
);
__PACKAGE__->has_many(
    "instrumentos",
    "Acao::Schema::Result::Instrumento",
    { "foreign.id_projeto" => "self.id_projeto" },
);
__PACKAGE__->has_many(
    "volumeacl",
    "Acao::Schema::Result::Instrumento",
    { "foreign.id_volume" => "self.id_volume" },
);
__PACKAGE__->has_many(
    "volumehistorico",
    "Acao::Schema::Result::VolumeHistorico",
    { "foreign.id_volume" => "self.id_volume" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 14:23:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3ThldNelmy6QoOXnj4TGQg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
