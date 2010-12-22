package Acao::Schema::Result::VisualizadorVolume;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DBIx::Class::Schema::Loader::Result::VisualizadorVolume

=cut

__PACKAGE__->table("visualizador_volumes");

=head1 ACCESSORS

=head2 id_visualizador_volumes

  data_type: 'integer'
  is_nullable: 0

=head2 dn

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_visualizador_volumes",
  { data_type => "integer", is_nullable => 0 },
  "dn",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_visualizador_volumes");
__PACKAGE__->belongs_to(
    "volume",
    "Acao::Schema::Result::Volume",
    { id_volume => "id_volume" },
);
__PACKAGE__->belongs_to(
    "volumeacl",
    "Acao::Schema::Result::VolumeAcl",
    { id_volume => "id_volume" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 14:23:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aS/Y7573p3j/63XP9ZEK9w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
