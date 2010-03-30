use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
my $res;

$res = request POST '/login', [user     => 'beltrano',
                               password => '12345'];
is( $res->code, 302, 'Quando a autenticação é bem sucedida com perfil revisor, ele faz um redirect.');
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.');
my $cookie_revisor = $res->header('Set-Cookie');

$res = request GET('/auth/registros/revisor', Cookie => $cookie_revisor);
is( $res->code, 200, 'Redirecionando para pagina inicial do perfil revisor com a listagem dos instrumentos permitidas para akele revisor.');
like( $res->content, qr(href="http://localhost/auth/registros/revisor"), 'A tela mostrou link para a listagem dos documentos pertinentes ao Instrumento selecionado.' );

$res = request GET('/auth/registros/revisor/1', Cookie => $cookie_revisor);
is( $res->code, 200, 'Redirecionou para a pagina de listagem dos documentos pertinentes ao Instrumento');

done_testing();
