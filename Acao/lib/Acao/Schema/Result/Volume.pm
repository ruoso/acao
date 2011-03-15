package Acao::Schema::Result::Volume;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 NAME

Acao::Schema::Result::Volume

=cut

__PACKAGE__->table("volume");

=head1 ACCESSORS

=head2 id_volume

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 nome

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
    "id_volume", { data_type => "varchar", is_nullable => 0, size => 255 },
    "nome",      { data_type => "varchar", is_nullable => 1, size => 255 },
);
__PACKAGE__->set_primary_key("id_volume");

=head1 RELATIONS

=head2 permissao_volumes

Type: has_many

Related object: L<Acao::Schema::Result::PermissaoVolume>

=cut

__PACKAGE__->has_many(
    "permissao_volumes",
    "Acao::Schema::Result::PermissaoVolume",
    { "foreign.id_volume" => "self.id_volume" },
    { cascade_copy        => 0, cascade_delete => 0 },
);

=head2 dossies

Type: has_many

Related object: L<Acao::Schema::Result::Dossie>

=cut

__PACKAGE__->has_many(
    "dossies",
    "Acao::Schema::Result::Dossie",
    { "foreign.id_volume" => "self.id_volume" },
    { cascade_copy        => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<Acao::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
    "entries", "Acao::Schema::Result::Entry",
    { "foreign.volume" => "self.id_volume" },
    { cascade_copy     => 0, cascade_delete => 0 },
);

# Created by DBIx::Class::Schema::Loader v0.07005 @ 2011-02-08 15:29:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:jgujivHmbjKfMxuPKa4sEg

# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
