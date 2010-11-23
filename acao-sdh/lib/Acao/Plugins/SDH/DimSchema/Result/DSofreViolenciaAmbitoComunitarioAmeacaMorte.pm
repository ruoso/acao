package Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAmeacaMorte;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAmeacaMorte

=cut

__PACKAGE__->table("d_sofre_violencia_ambito_comunitario_ameaca_morte");

=head1 ACCESSORS

=head2 id_sofre_violencia_ambito_comunitario_ameaca_morte

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_sofre_violencia_ambito_comunitario_ameaca_morte_id_sofre_v870'

=head2 sofre_violencia_ambito_comunitario_ameaca_morte

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 frequencia

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_sofre_violencia_ambito_comunitario_ameaca_morte",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_sofre_violencia_ambito_comunitario_ameaca_morte_id_sofre_v870",
  },
  "sofre_violencia_ambito_comunitario_ameaca_morte",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "frequencia",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_sofre_violencia_ambito_comunitario_ameaca_morte");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_sofre_violencia_ambito_comunitario_ameaca_morte" => "self.id_sofre_violencia_ambito_comunitario_ameaca_morte",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-22 14:32:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EFC3oAFshdOFHbq8Eq2MBw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
