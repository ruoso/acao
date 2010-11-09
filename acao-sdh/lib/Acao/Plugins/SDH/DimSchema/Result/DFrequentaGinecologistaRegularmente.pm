package Acao::Plugins::SDH::DimSchema::Result::DFrequentaGinecologistaRegularmente;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::DFrequentaGinecologistaRegularmente

=cut

__PACKAGE__->table("d_frequenta_ginecologista_regularmente");

=head1 ACCESSORS

=head2 id_frequenta_ginecologista_regularmente

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_frequenta_ginecologista_regularmente_id_d_frequenta_gineco523'

=head2 frequenta_ginecologista_regularmente

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=cut

__PACKAGE__->add_columns(
  "id_frequenta_ginecologista_regularmente",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_frequenta_ginecologista_regularmente_id_d_frequenta_gineco523",
  },
  "frequenta_ginecologista_regularmente",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
);
__PACKAGE__->set_primary_key("id_frequenta_ginecologista_regularmente");

=head1 RELATIONS

=head2 f_atendimentoes

Type: has_many

Related object: L<Acao::Plugins::SDH::DimSchema::Result::FAtendimento>

=cut

__PACKAGE__->has_many(
  "f_atendimentoes",
  "Acao::Plugins::SDH::DimSchema::Result::FAtendimento",
  {
    "foreign.id_frequenta_ginecologista_regularmente" => "self.id_frequenta_ginecologista_regularmente",
  },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-09 15:44:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:5MnY8wUuatpe5Y2169O6ew


# You can replace this text with custom content, and it will be preserved on regeneration
1;
