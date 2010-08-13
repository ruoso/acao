package Acao::Schema::Result::VolumeHistorico;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

DBIx::Class::Schema::Loader::Result::VolumeHistorico

=cut

__PACKAGE__->table("volume_historico");

=head1 ACCESSORS

=head2 id_volume

  data_type: 'integer'
  is_nullable: 0

=head2 alteracao

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 data_alteracao

  data_type: 'timestamp with time zone'
  is_nullable: 1

=head2 usuario

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_volume",
  { data_type => "integer", is_nullable => 0 },
  "alteracao",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "data_alteracao",
  { data_type => "timestamp with time zone", is_nullable => 1 },
  "usuario",
  { data_type => "integer", is_nullable => 0 },
);

__PACKAGE__->belongs_to(
    "volume",
    "Acao::Schema::Result::Volume",
    { id_volume => "id_volume" },
);


# Created by DBIx::Class::Schema::Loader v0.07001 @ 2010-08-13 14:23:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ImESTcYWGaV8PyX2l8/n4g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
