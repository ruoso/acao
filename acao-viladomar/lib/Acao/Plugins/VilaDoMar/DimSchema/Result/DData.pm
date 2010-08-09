package Acao::Plugins::VilaDoMar::DimSchema::Result::DData;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DData

=cut

__PACKAGE__->table("d_data");

=head1 ACCESSORS

=head2 data

  data_type: 'date'
  is_nullable: 0

=head2 dia

  data_type: 'integer'
  is_nullable: 1

=head2 mes

  data_type: 'integer'
  is_nullable: 1

=head2 ano

  data_type: 'integer'
  is_nullable: 1

=head2 bimestre

  data_type: 'integer'
  is_nullable: 1

=head2 trimestre

  data_type: 'integer'
  is_nullable: 1

=head2 semestre

  data_type: 'integer'
  is_nullable: 1

=head2 dia_semana

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "data",
  { data_type => "date", is_nullable => 0 },
  "dia",
  { data_type => "integer", is_nullable => 1 },
  "mes",
  { data_type => "integer", is_nullable => 1 },
  "ano",
  { data_type => "integer", is_nullable => 1 },
  "bimestre",
  { data_type => "integer", is_nullable => 1 },
  "trimestre",
  { data_type => "integer", is_nullable => 1 },
  "semestre",
  { data_type => "integer", is_nullable => 1 },
  "dia_semana",
  { data_type => "integer", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("data");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IQakaEXydMNJsGK1RvWscw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
