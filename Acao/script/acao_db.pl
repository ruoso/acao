#!/usr/bin/perl
use strict;
use warnings;
use lib 'lib';
use SQL::Translator;

my $t = SQL::Translator->new
  (
   show_warnings       => 1,
   add_drop_table      => 1,
   quote_table_names   => 1,
   quote_field_names   => 1,
   validate            => 1,
  );
$t->parser_args
  (
   'DBIx::Schema' => 'Acao::Schema',
  );
my $r = $t->translate
  (
   from => 'SQL::Translator::Parser::DBIx::Class',
   to => 'PostgreSQL',
  ) or die $t->error;
print $r;


exit 0;
