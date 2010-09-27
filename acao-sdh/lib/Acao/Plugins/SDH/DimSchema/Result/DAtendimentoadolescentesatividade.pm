package Acao::Plugins::SDH::DimSchema::Result::DAtendimentoadolescentesatividade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DAtendimentoadolescentesatividade

=cut

__PACKAGE__->table("d_atendimentoadolescentesatividades");

=head1 ACCESSORS

=head2 d_atendimentoadolescentesatividades

  data_type: 'integer'
  is_nullable: 0

=head2 atendimento

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "d_atendimentoadolescentesatividades",
  { data_type => "integer", is_nullable => 0 },
  "atendimento",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("d_atendimentoadolescentesatividades");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.d_atendimentoadolescentesatividades" => "self.d_atendimentoadolescentesatividades",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-09-27 10:16:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:IhbC3qyox3i3FlY0pC9Rqw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
