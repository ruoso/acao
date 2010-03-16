package Acao::ModelUtil;
use strict;
use warnings;
use base 'Exporter';

use Data::Dumper;
our @EXPORT = qw(txn_method authorized);

sub txn_method {
    my ( $name, $code ) = @_;
    my $method_name = caller() . '::' . $name;
    no strict 'refs';
    *{$method_name} = sub {
        my $ret;
        my $committed = 0;
        eval {
            $_[0]->sedna->begin;
            $ret = $_[0]->dbic->txn_do( $code, @_ );
            $_[0]->sedna->commit;
	          $committed = 1;
        };
        if ($@) {
					  my $erro_original = $@;
            eval {
               $_[0]->sedna->rollback unless $committed;
            };
            die $erro_original;
        }
        $ret;
    };
}

sub authorized {
    my ( $role, $code ) = @_;
    return sub {
        if ( grep { $_ eq $role } $_[0]->user->roles ) {
            $code->(@_);
        }
        else {
            die 'access-denied!';
        }
      }
}

1;
