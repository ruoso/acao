package Acao::Plugins::SDH::DimSchema::Result::DData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DData

=cut

__PACKAGE__->table("d_data");

=head1 ACCESSORS

=head2 id_data

  data_type: 'integer'
  is_nullable: 0

=head2 dia

  data_type: 'integer'
  is_nullable: 0

=head2 mes

  data_type: 'integer'
  is_nullable: 0

=head2 ano

  data_type: 'integer'
  is_nullable: 0

=head2 data

  data_type: 'date'
  is_nullable: 0

=head2 bimestre

  data_type: 'integer'
  is_nullable: 0

=head2 trimestre

  data_type: 'integer'
  is_nullable: 0

=head2 semestre

  data_type: 'integer'
  is_nullable: 0

=head2 dia_semana

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_data",
  { data_type => "integer", is_nullable => 0 },
  "dia",
  { data_type => "integer", is_nullable => 0 },
  "mes",
  { data_type => "integer", is_nullable => 0 },
  "ano",
  { data_type => "integer", is_nullable => 0 },
  "data",
  { data_type => "date", is_nullable => 0 },
  "bimestre",
  { data_type => "integer", is_nullable => 0 },
  "trimestre",
  { data_type => "integer", is_nullable => 0 },
  "semestre",
  { data_type => "integer", is_nullable => 0 },
  "dia_semana",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_data");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_data" => "self.id_data" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-19 17:40:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tDZdaUibxkrceN7YDyFskQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
