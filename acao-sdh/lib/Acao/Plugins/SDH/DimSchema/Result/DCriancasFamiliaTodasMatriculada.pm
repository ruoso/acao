package Acao::Plugins::SDH::DimSchema::Result::DCriancasFamiliaTodasMatriculada;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DCriancasFamiliaTodasMatriculada

=cut

__PACKAGE__->table("d_criancas_familia_todas_matriculadas");

=head1 ACCESSORS

=head2 id_criancas_familia_todas_matriculadas

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_criancas_familia_todas_matriculadas_id_criancas_familia_to622'

=head2 criancas_familia_todas_matriculadas

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_criancas_familia_todas_matriculadas",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_criancas_familia_todas_matriculadas_id_criancas_familia_to622",
  },
  "criancas_familia_todas_matriculadas",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_criancas_familia_todas_matriculadas");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_criancas_familia_todas_matriculadas" => "self.id_criancas_familia_todas_matriculadas",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-22 14:32:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tTZE8nZW5D6s9Y9ft1Mb+A


# You can replace this text with custom content, and it will be preserved on regeneration
1;
