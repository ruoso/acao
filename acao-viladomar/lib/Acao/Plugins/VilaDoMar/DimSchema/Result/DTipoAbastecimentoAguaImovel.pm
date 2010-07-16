package Acao::Plugins::VilaDoMar::DimSchema::Result::DTipoAbastecimentoAguaImovel;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DTipoAbastecimentoAguaImovel

=cut

__PACKAGE__->table("d_tipo_abastecimento_agua_imovel");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_tipo_abastecimento_agua_id_seq'

=head2 tipo_abastecimento_agua_imovel

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
    #sequence          => "d_tipo_abastecimento_agua_id_seq",
  },
  "tipo_abastecimento_agua_imovel",
  { data_type => "varchar", is_nullable => 1 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:zVHLcC/KYP2DZb6TM0oXKQ


# You can replace this text with custom content, and it will be preserved on regeneration
1;
