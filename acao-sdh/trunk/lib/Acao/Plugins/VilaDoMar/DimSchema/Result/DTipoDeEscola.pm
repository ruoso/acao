package Acao::Plugins::VilaDoMar::DimSchema::Result::DTipoDeEscola;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DTipoDeEscola

=cut

__PACKAGE__->table("d_tipo_de_escola");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_tipo_de_escola_id_seq'

=head2 tipodeescola

  data_type: 'character'
  is_nullable: 1
  size: 50

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "d_tipo_de_escola_id_seq",
  },
  "tipodeescola",
  { data_type => "character", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:V8MlfvWJx8lRt6SfJ71FQQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
