use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
BEGIN { use_ok 'Acao::Controller::Auth::Registros::Digitador' }

ok( request('/auth/registros/digitador')->is_success, 'Request should succeed' );


