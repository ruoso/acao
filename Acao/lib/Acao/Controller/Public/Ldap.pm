package Acao::Controller::Public::Ldap;

use strict;
use warnings;
use parent 'Catalyst::Controller';
use Data::Dumper;

sub base : Chained('/') : PathPart('ldap') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub login :Chained('base') :PathPart('') : Args(0) {
    my ( $self, $c) = @_;
    my $mesg = $c->model('Ldap')->search('(cn=bastos_tiago)');
    warn Dumper($mesg);
    warn 'WWWWWWWWWWWWWWWWWWWWWWW';
    my @entries = $mesg->entries;

    $c->res->redirect( $c->uri_for( $c->controller('auth')->action_for('principal') ) );

  #  warn $entries[0]->sn;
}

1;
