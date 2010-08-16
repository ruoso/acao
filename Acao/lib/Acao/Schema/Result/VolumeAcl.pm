package Acao::Schema::Result::VolumeAcl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DBIx::Class::Schema::Loader::Result::VolumeAcl

=cut

__PACKAGE__->table("volume_acl");

=head1 ACCESSORS

=head2 id_volume

  data_type: 'integer'
  is_nullable: 0

=head2 papel

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 grupo

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_volume",
  { data_type => "integer", is_nullable => 0 },
  "papel",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "grupo",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);

__PACKAGE__->belongs_to(
    "volume",
    "Acao::Schema::Result::Volume",
    { id_volume => "id_volume" },
);
__PACKAGE__->has_many(
    "gestor_volumes",
    "Acao::Schema::Result::GestorVolume",
    { "foreign.id_volume" => "self.id_volume" },
);
__PACKAGE__->has_many(
    "visualizador_volumes",
    "Acao::Schema::Result::VisualizadorVolume",
    { "foreign.id_volume" => "self.id_volume" },
);

# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 14:23:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nYSuqVvfCRJ+ad5f88D+Sw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
