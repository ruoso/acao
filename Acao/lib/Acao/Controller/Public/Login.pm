package Acao::Controller::Public::Login;

use strict;
use warnings;
use parent 'Catalyst::Controller';

=head1 NAME

Acao::Controller::Public::Login - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut

=head2 index

=cut

sub base : Chained('/') : PathPart('login') : CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub login : Chained('base') : PathPart('') : Args(0) {
    my ( $self, $c ) = @_;
    my $user     = $c->request->params->{user};
    my $password = $c->request->params->{password};

    if ( defined $user && defined $password ) {
        if ( $c->authenticate( { username => $user, password => $password } ) )
        {
            $c->res->redirect(
                $c->uri_for( $c->controller('auth')->action_for('principal') )
            );
            return;
        }
        else {
            $c->flash->{erro} = 'usuario-invalido';
        }
    }
}

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
