package Acao::Plugins::SDH::DimSchema::Result::DInteresseCursoProfissionalizante;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DInteresseCursoProfissionalizante

=cut

__PACKAGE__->table("d_interesse_curso_profissionalizante");

=head1 ACCESSORS

=head2 id_interesse_curso_profissionalizante

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_interesse_curso_profissionalizante_id_interesse_curso_prof544'

=head2 interesse_curso_profissionalizante

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_interesse_curso_profissionalizante",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_interesse_curso_profissionalizante_id_interesse_curso_prof544",
  },
  "interesse_curso_profissionalizante",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_interesse_curso_profissionalizante");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_interesse_curso_profissionalizante" => "self.id_interesse_curso_profissionalizante",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-18 14:12:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EFhN6hhNA1c2RCC2ps6IhA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
