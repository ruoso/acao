package Acao::Plugins::SDH::DimSchema::Result::DEndereco;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DEndereco

=cut

__PACKAGE__->table("d_endereco");

=head1 ACCESSORS

=head2 id_endereco

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_endereco_id_endereco_seq'

=head2 endereco

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 bairro

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=head2 cidade

  data_type: 'text'
  is_nullable: 1
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_endereco",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_endereco_id_endereco_seq",
  },
  "endereco",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "bairro",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
  "cidade",
  {
    data_type   => "text",
    is_nullable => 1,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_endereco");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_endereco" => "self.id_endereco" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-18 14:12:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:MKB5monCprE9a2Douopw7A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
