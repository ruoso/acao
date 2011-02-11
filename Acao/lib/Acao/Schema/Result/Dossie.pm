package Acao::Schema::Result::Dossie;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Schema::Result::Dossie

=cut

__PACKAGE__->table("dossie");

=head1 ACCESSORS

=head2 id_volume

  data_type: 'varchar'
  is_foreign_key: 1
  is_nullable: 0
  size: 255

=head2 id_dossie

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 nome

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 herda_permissoes

  data_type: 'boolean'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_volume",
  { data_type => "varchar", is_foreign_key => 1, is_nullable => 0, size => 255 },
  "id_dossie",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "nome",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "herda_permissoes",
  { data_type => "boolean", is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id_volume", "id_dossie");

=head1 RELATIONS

=head2 id_volume

Type: belongs_to

Related object: L<Acao::Schema::Result::Volume>

=cut

__PACKAGE__->belongs_to(
  "id_volume",
  "Acao::Schema::Result::Volume",
  { id_volume => "id_volume" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 permissao_dossies

Type: has_many

Related object: L<Acao::Schema::Result::PermissaoDossie>

=cut

__PACKAGE__->has_many(
  "permissao_dossies",
  "Acao::Schema::Result::PermissaoDossie",
  { "foreign.id_dossie" => "self.id_dossie",
    "foreign.id_volume" => "self.id_volume"  },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 entries

Type: has_many

Related object: L<Acao::Schema::Result::Entry>

=cut

__PACKAGE__->has_many(
  "entries",
  "Acao::Schema::Result::Entry",
  { "foreign.dossie" => "self.id_dossie",
    "foreign.volume" => "self.id_volume" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07005 @ 2011-02-08 15:29:11
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:SNmkch+56z1EenO/hXDb/A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
