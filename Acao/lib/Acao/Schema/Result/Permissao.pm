package Acao::Schema::Result::Permissao;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Estrutura::DimSchema::Result::Permissao

=cut

__PACKAGE__->table("permissao");

=head1 ACCESSORS

=head2 entry_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'serial_permissions'

=head2 dn

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "entry_id",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "serial_permissions",
  },
  "dn",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("entry_id");


# Created by DBIx::Class::Schema::Loader v0.07005 @ 2011-01-27 15:39:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+z8Q9BSTJyDPzjNvt1rA3w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
