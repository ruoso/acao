package Acao::Plugins::VilaDoMar::DimSchema::Result::DObitoInfantilUltimoAno;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DObitoInfantilUltimoAno

=cut

__PACKAGE__->table("d_obito_infantil_ultimo_ano");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_obito_infantil_ultimo_ano_id_seq'

=head2 obito_infantil_ultimo_ano

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
    #sequence          => "d_obito_infantil_ultimo_ano_id_seq",
  },
  "obito_infantil_ultimo_ano",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:l0+VOEBcwzNH9gvVOBSFTg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
