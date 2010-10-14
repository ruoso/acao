package Acao::Plugins::SDH::DimSchema::Result::DTratamentoAgua;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DTratamentoAgua

=cut

__PACKAGE__->table("d_tratamento_agua");

=head1 ACCESSORS

=head2 id_tratamento_agua

  data_type: 'integer'
  is_nullable: 0

=head2 tratamento_agua

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_tratamento_agua",
  { data_type => "integer", is_nullable => 0 },
  "tratamento_agua",
  { data_type => "integer", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id_tratamento_agua");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_tratamento_agua" => "self.id_tratamento_agua" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-14 15:32:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:ruadADb/XcQhpBcQ4r+Saw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
