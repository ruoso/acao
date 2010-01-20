package Acao::View::Sedna;
use strict;
use warnings;
use utf8;

use base 'Catalyst::View';

sub process {
  my ($self, $c) = @_;
  if ($c->stash->{document}) {
    my $sedna = $c->model('Sedna');
    $sedna->begin;
    $sedna->execute('for $x in doc("'.$c->stash->{document}.'") return $x');
    my $data = $sedna->get_item;
    $sedna->commit;
    if ($data) {
      $c->res->content_type("application/xml");
      $c->res->body($data);
    }
  }
}

42;
