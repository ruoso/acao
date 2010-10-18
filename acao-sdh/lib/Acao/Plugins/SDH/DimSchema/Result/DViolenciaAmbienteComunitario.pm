package Acao::Plugins::SDH::DimSchema::Result::DViolenciaAmbienteComunitario;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DViolenciaAmbienteComunitario

=cut

__PACKAGE__->table("d_violencia_ambiente_comunitario");

=head1 ACCESSORS

=head2 id_violencia_ambiente_comunitario

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_violencia_ambiente_comunitario_id_violencia_ambiente_comun422'

=head2 violencia_ambiente_comunitario

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_violencia_ambiente_comunitario",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_violencia_ambiente_comunitario_id_violencia_ambiente_comun422",
  },
  "violencia_ambiente_comunitario",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_violencia_ambiente_comunitario");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_violencia_ambiente_comunitario" => "self.id_violencia_ambiente_comunitario",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-18 14:12:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:rbRSc7nJzTabxnDiqaeJpg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
