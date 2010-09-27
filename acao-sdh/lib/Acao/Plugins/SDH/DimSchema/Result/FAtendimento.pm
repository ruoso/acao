package Acao::Plugins::SDH::DimSchema::Result::FAtendimento;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::FAtendimento

=cut

__PACKAGE__->table("f_atendimento");

=head1 ACCESSORS

=head2 d_atendimentoadolescentesatividades

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "d_atendimentoadolescentesatividades",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 RELATIONS

=head2 d_atendimentoadolescentesatividade

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAtendimentoadolescentesatividade>

=cut

__PACKAGE__->belongs_to(
  "d_atendimentoadolescentesatividade",
  "Acao::Plugins::SDH::DimSchema::Result::DAtendimentoadolescentesatividade",
  {
    d_atendimentoadolescentesatividades => "d_atendimentoadolescentesatividades",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-09-27 10:16:44
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lvk/7QIcW8VYdAdMhiZXvA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
