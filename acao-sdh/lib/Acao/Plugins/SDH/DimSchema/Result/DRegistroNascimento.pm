package Acao::Plugins::SDH::DimSchema::Result::DRegistroNascimento;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DRegistroNascimento

=cut

__PACKAGE__->table("d_registro_nascimento");

=head1 ACCESSORS

=head2 id_registro_nascimento

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_registro_nascimento_id_registro_nascimento_seq'

=head2 situacao

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_registro_nascimento",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_registro_nascimento_id_registro_nascimento_seq",
  },
  "situacao",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_registro_nascimento");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_registro_nascimento" => "self.id_registro_nascimento",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-19 17:40:25
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GwTAbuUDwgEJB/nqV1jOTA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
