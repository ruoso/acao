package Acao::Schema::Result::Entry;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Schema::Result::Entry

=cut

__PACKAGE__->table("entries");

=head1 ACCESSORS

=head2 entry_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'serial_entries'

=head2 volume

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 dossie

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 documento

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 resumo

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
    sequence          => "serial_entries",
  },
  "volume",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "dossie",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "documento",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "resumo",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("entry_id");

=head1 RELATIONS

=head2 gin_indexes

Type: has_many

Related object: L<Acao::Schema::Result::GinIndex>

=cut

__PACKAGE__->has_many(
  "gin_indexes",
  "Acao::Schema::Result::GinIndex",
  { "foreign.entry" => "self.entry_id" },
  { cascade_copy => 1, cascade_delete => 1 },
);

=head2 gin_indexes

Type: has_many

Related object: L<Acao::Schema::Result::Permissao>

=cut

__PACKAGE__->has_many(
  "permissoes",
  "Acao::Schema::Result::Permissao",
  { "foreign.entry_id" => "self.entry_id" },
  { cascade_copy => 1, cascade_delete => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.07005 @ 2011-01-27 15:39:05
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:pPGrpgZSykyHGw/AdkJB4Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
