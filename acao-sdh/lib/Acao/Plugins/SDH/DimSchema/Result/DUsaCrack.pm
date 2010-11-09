package Acao::Plugins::SDH::DimSchema::Result::DUsaCrack;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DUsaCrack

=cut

__PACKAGE__->table("d_usa_crack");

=head1 ACCESSORS

=head2 id_usa_crack

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_usa_crack_id_usa_crack_seq'

=head2 usa_crack

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_usa_crack",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_usa_crack_id_usa_crack_seq",
  },
  "usa_crack",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_usa_crack");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_usa_crack" => "self.id_usa_crack" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-09 15:44:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:aFbYqFCkEiy3ZQ0xHlAi5w


# You can replace this text with custom content, and it will be preserved on regeneration
1;
