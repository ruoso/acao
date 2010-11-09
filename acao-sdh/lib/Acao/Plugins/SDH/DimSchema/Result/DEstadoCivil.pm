package Acao::Plugins::SDH::DimSchema::Result::DEstadoCivil;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DEstadoCivil

=cut

__PACKAGE__->table("d_estado_civil");

=head1 ACCESSORS

=head2 id_estado_civil

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_estado_civil_id_estado_civil_seq'

=head2 estado_civil

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_estado_civil",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_estado_civil_id_estado_civil_seq",
  },
  "estado_civil",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_estado_civil");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  { "foreign.id_estado_civil" => "self.id_estado_civil" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-09 15:44:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6QYLRjCMe2JLAAcc+2nvBw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
