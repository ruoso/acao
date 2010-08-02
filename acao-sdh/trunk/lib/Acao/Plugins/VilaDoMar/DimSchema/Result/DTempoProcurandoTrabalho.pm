package Acao::Plugins::VilaDoMar::DimSchema::Result::DTempoProcurandoTrabalho;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::DTempoProcurandoTrabalho

=cut

__PACKAGE__->table("d_tempo_procurando_trabalho");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'd_tempo_procurando_trabalho_id_seq'

=head2 tempoprocurandotrabalho

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
    sequence          => "d_tempo_procurando_trabalho_id_seq",
  },
  "tempoprocurandotrabalho",
  { data_type => "character", is_nullable => 1, size => 50 },
);
__PACKAGE__->set_primary_key("id");


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vZrOpqFYP1S42WPo40h+Bg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
