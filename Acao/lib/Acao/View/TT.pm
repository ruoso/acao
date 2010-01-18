package Acao::View::TT;

use strict;
use base 'Catalyst::View::TT';

__PACKAGE__->config(
	TEMPLATE_EXTENSION => '.tt',
	INCLUDE_PATH => [
              Acao->path_to( 'root' ),
        ]);

=head1 NAME

Acao::View::TT - TT View for Acao

=head1 DESCRIPTION

TT View for Acao. 

=head1 SEE ALSO

L<Acao>

=head1 AUTHOR

Lafitte,,,

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
