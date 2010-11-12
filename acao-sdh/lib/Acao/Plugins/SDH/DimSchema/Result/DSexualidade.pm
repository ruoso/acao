package Acao::Plugins::SDH::DimSchema::Result::DSexualidade;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DSexualidade

=cut

__PACKAGE__->table("d_sexualidade");

=head1 ACCESSORS

=head2 id_sexualidade

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_sexualidade_id_sexualidade_seq'

=head2 sexualidade

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_sexualidade",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_sexualidade_id_sexualidade_seq",
  },
  "sexualidade",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_sexualidade");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_sexualidade" => "self.id_sexualidade" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-12 15:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0K3w3M8xlz1Lnq0vIO+2UQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
