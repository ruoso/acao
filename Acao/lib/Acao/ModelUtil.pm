package Acao::ModelUtil;
use strict;
use warnings;
use base 'Exporter';

our @EXPORT = qw(txn_method authorized);

sub txn_method {
  my ($name, $code) = @_;
  my $method_name = caller().'::'.$name;
  no strict 'refs';
  *{$method_name} = sub {
    $_[0]->dbic->txn_do($code, @_)
  };
}

sub authorized {
  my ($role, $code) = @_;
  return sub {
    if ($_[0]->user->in_role($role)) {
      $code->(@_);
    } else {
      die 'Access Denied!';
    }
  }
}

1;
