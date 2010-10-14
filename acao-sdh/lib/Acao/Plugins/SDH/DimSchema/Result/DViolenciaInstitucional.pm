package Acao::Plugins::SDH::DimSchema::Result::DViolenciaInstitucional;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DViolenciaInstitucional

=cut

__PACKAGE__->table("d_violencia_institucional");

=head1 ACCESSORS

=head2 id_violencia_institucional

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_violencia_institucional",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_violencia_institucional");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_violencia_institucional" => "self.id_violencia_institucional",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-14 15:32:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oHw9dTDaqE9uu0Ihx8OUhw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
