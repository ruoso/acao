#!/usr/bin/env perl

use Catalyst::ScriptRunner;
Catalyst::ScriptRunner->run('Acao', 'Test');

1;

=head1 NAME

acao_test.pl - Catalyst Test

=head1 SYNOPSIS

acao_test.pl [options] uri

 Options:
   --help    display this help and exits

 Examples:
   acao_test.pl http://localhost/some_action
   acao_test.pl /some_action

 See also:
   perldoc Catalyst::Manual
   perldoc Catalyst::Manual::Intro

=head1 DESCRIPTION

Run a Catalyst action from the command line.

=head1 AUTHORS

Catalyst Contributors, see Catalyst.pm

=head1 COPYRIGHT

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
