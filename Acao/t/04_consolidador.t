use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
my $res;

$res = request POST '/login', [user => 'acao', 
                               password => '12345'];
is( $res->code, 302, 'Usuario logado com sucesso' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.' );
my $cookie_consolidador =  $res->header('Set-Cookie');

$res = request GET('/auth/registros/consolidador', Cookie => $cookie_consolidador);
is( $res->code, 200, 'Redirecionando para pagina inicial do perfil consolidador com a listagem das definicoes de consolidacao' );
like( $res->content, qr(href="http://localhost/auth/registros/consolidador/1"), 'Mostrou o link para as consolidacoes pertinetes a definicao consolidacao' );

$res = request GET('/auth/registros/consolidador/1', Cookie => $cookie_consolidador);
is( $res->code, 200, 'Redirecionando para pagina de listagem das consolidacoes pertinetes a definicao consolidacao' );
like( $res->content, qr(href="http://localhost/auth/registros/consolidador/1/iniciar"),'Mostrou o link para os alertas pertinetes a consolidacao' );

$res = request GET('/auth/registros/consolidador/1/1', Cookie => $cookie_consolidador);
is( $res->code, 200, 'Redirecionando para pagina de listagem dos alertas pertinetes a consolidacao' );

done_testing();
