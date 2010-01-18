use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
BEGIN { use_ok 'Acao::Controller::Auth::Registros::Revisor::Preenchimento' }

ok( request('/auth/registros/revisor/preenchimento')->is_success, 'Request should succeed' );


