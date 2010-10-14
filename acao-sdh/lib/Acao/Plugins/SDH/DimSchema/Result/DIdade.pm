package Acao::Plugins::SDH::DimSchema::Result::DIdade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DIdade

=cut

__PACKAGE__->table("d_idade");

=head1 ACCESSORS

=head2 id_idade

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_idade_id_idade_seq'

=cut

__PACKAGE__->add_columns(
  "id_idade",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_idade_id_idade_seq",
  },
);
__PACKAGE__->set_primary_key("id_idade");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_idade" => "self.id_idade" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-14 15:32:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:1omsk97LnWrC3Pr15Epy0Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
