use strict;
use warnings;
use Test::More tests => 3;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
BEGIN { use_ok 'Acao::Controller::Auth::Registros::Digitador::Instrumento' }

ok( request('/auth/registros/digitador/instrumento')->is_success, 'Request should succeed' );


