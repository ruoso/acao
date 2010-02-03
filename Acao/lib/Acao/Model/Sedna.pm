package Acao::Model::Sedna;
use strict;
use warnings;
use utf8;

use base 'Catalyst::Model::Sedna';

sub new {
    my $self = shift;
    $self = $self->SUPER::new(@_);
    $self->conn->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF);
    return $self;
}

sub get_document {
    my ( $self, $doc ) = @_;
    $self->execute( 'for $x in doc("' . $doc . '") return $x' );
    my $data = $self->get_item;
    return $data;
}

sub store_document {
    my ( $self, $xml, $doc_id, $collection ) = @_;
    $self->conn->loadData( $xml, $doc_id, $collection );
    $self->conn->endLoadData();
}

42;
