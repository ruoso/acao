package Acao::Plugins::SDH::DimSchema::Result::DJaTrabalhou;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DJaTrabalhou

=cut

__PACKAGE__->table("d_ja_trabalhou");

=head1 ACCESSORS

=head2 id_ja_trabalhou

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_ja_trabalhou_id_ja_trabalhou_seq'

=head2 ja_trabalhou

  data_type: 'text'
  is_auto_increment: 1
  is_nullable: 0
  original: {data_type => "varchar"}
  sequence: 'd_ja_trabalhou_ja_trabalhou_seq'

=cut

__PACKAGE__->add_columns(
  "id_ja_trabalhou",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_ja_trabalhou_id_ja_trabalhou_seq",
  },
  "ja_trabalhou",
  {
    data_type         => "text",
    is_auto_increment => 1,
    is_nullable       => 0,
    original          => { data_type => "varchar" },
    sequence          => "d_ja_trabalhou_ja_trabalhou_seq",
  },
);
__PACKAGE__->set_primary_key("id_ja_trabalhou");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_ja_trabalhou" => "self.id_ja_trabalhou" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-18 14:12:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:P/h/NTVZZ5e6llBRhVDz4Q


# You can replace this text with custom content, and it will be preserved on regeneration
1;
