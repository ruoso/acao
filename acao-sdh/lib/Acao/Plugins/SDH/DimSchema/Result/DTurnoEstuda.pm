package Acao::Plugins::SDH::DimSchema::Result::DTurnoEstuda;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DTurnoEstuda

=cut

__PACKAGE__->table("d_turno_estuda");

=head1 ACCESSORS

=head2 id_turno_estuda

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_turno_estuda_id_turno_estuda_seq'

=head2 turno_estuda

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_turno_estuda",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_turno_estuda_id_turno_estuda_seq",
  },
  "turno_estuda",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_turno_estuda");


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-15 16:51:40
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rsfjGZ+yytab2umiLmtmig


# You can replace this text with custom content, and it will be preserved on regeneration
1;
