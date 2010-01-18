use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
BEGIN { use_ok 'Acao::Controller::Acao' }

ok( request('/acao')->is_success, 'Request should succeed' );


