package Acao::Schema::Result::GinIndex;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 NAME

Acao::Schema::Result::GinIndex

=cut

__PACKAGE__->table("gin_index");

=head1 ACCESSORS

=head2 key

  data_type: 'varchar'
  is_nullable: 1
  size: 50

=head2 value

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 entry

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
    "key",
    { data_type => "varchar", is_nullable => 1, size => 50 },
    "value",
    { data_type => "varchar", is_nullable => 1, size => 255 },
    "entry",
    { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 entry

Type: belongs_to

Related object: L<Acao::Schema::Result::Entry>

=cut

__PACKAGE__->belongs_to(
    "entry",
    "Acao::Schema::Result::Entry",
    { entry_id => "entry" },
    {
        is_deferrable => 1,
        join_type     => "LEFT",
        on_delete     => "CASCADE",
        on_update     => "CASCADE",
    },
);

# Created by DBIx::Class::Schema::Loader v0.07005 @ 2011-01-27 15:39:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Sxd5X8br4+vS5axd/7l7OA

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
