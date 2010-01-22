package Acao::View::XML;
use strict;
use warnings;
use utf8;

use base 'Catalyst::View';

sub process {
  my ($self, $c) = @_;
  if ($c->stash->{document}) {
    $c->res->content_type("application/xml");
    $c->res->body($c->stash->{document});
  }
}

42;
