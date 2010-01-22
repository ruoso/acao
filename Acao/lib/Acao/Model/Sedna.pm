package Acao::Model::Sedna;
use strict;
use warnings;
use utf8;

use base 'Catalyst::Model::Sedna';

sub get_document {
    my ($self, $doc) = @_;
    $self->begin;
    $self->execute('for $x in doc("'.$doc.'") return $x');
    my $data = $self->get_item;
    $self->commit;
    return $data;
}

sub store_document {
  my ($self, $xml, $doc_id, $collection) = @_;
  $self->begin;
  $self->conn->loadData($xml, $doc_id, $collection);
  $self->conn->endLoadData();
  $self->commit;
}

42;
