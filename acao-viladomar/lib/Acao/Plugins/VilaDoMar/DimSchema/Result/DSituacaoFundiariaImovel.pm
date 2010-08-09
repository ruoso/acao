package Acao::Plugins::VilaDoMar::DimSchema::Result::DSituacaoFundiariaImovel;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DSituacaoFundiariaImovel

=cut

__PACKAGE__->table("d_situacao_fundiaria_imovel");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_situacao_fundiaria_imovel_id_seq'

=head2 situacao_fundiaria_imovel

  data_type: 'character'
  is_nullable: 1
  size: 20

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    #sequence          => "d_situacao_fundiaria_imovel_id_seq",
  },
  "situacao_fundiaria_imovel",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FLnltAG+ujSVdSTCd4iXmQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
