use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

BEGIN { use_ok 'Catalyst::Test', 'Acao' }

my $res = request('/');
is( $res->code, 302, 'Acessando o /, retorna um redir' );
is( $res->header('Location'), 'http://localhost/auth',
    'Ainda não temos área pública, só temos área autenticada.');

$res = request('/auth');
is( $res->code, 302, 'Não estamos autenticados, por isso deve fazer redirect.');
is( $res->header('Location'), 'http://localhost/login',
    'Quando não está autenticado, e tenta acessar a área autenticada, redireciona para a tela de login.');

$res = request('/login');
ok( $res->is_success, 'Exibe a página de login');
like( $res->content, qr(action="http://localhost/login"),
      'Apresenta o formulário de login');

$res = request POST '/login', [
    user     => 'usuario_que_nao_existe',
    password => '12345'
];
is( $res->code, 200, 'Apesar de falhar a autenticação, o resultado http é sucesso.');
like( $res->content, qr(inv.lido),
      'Retornou o erro de autenticação' );

$res = request POST '/login', [
    user     => 'acao',
    password => '12345',
];
is( $res->code, 302, 'Quando a autenticação é bem sucedida, ele faz um redirect.');
is( $res->header('Location'), 'http://localhost/auth',
    'Ele manda para a área autenticada.' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.');
my $sess = $res->header('Set-Cookie');

$res = request GET('/auth', Cookie => $sess);
is( $res->code, 302, 'Mesmo autenticado ele faz um redirect.');
is( $res->header('Location'), 'http://localhost/auth/registros',
    'Ele manda para a área de registros, que é a única implementada.' );

$res = request GET('/auth/registros/', Cookie => $sess);
is( $res->code, 200, 'Este usuário tem vários papéis, por isso ve a lista.' );
like( $res->content, qr(href="http://localhost/auth/registros/digitador"),
      'A tela mostra o link para a área de digitador');

$res = request POST '/login', [
    user     => 'ciclano',
    password => '12345',
];
is( $res->code, 302, 'Quando a autenticação é bem sucedida, ele faz um redirect.');
is( $res->header('Location'), 'http://localhost/auth',
    'Ele manda para a área autenticada.' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.');
my $sess_cicl = $res->header('Set-Cookie');

$res = request GET('/auth/registros/', Cookie => $sess_cicl);
is( $res->code, 302, 'Este usuário só tem um papel, portanto deve ser redirecionado.' );
is( $res->header('Location'), 'http://localhost/auth/registros/digitador',
      'Redirecionou para a área de digitador');

$res = request GET('/auth/logout', Cookie => $sess_cicl);
is( $res->code, 302, 'Usuário fez logout, deve ser redirecionado');
is( $res->header('Location'), 'http://localhost/',
    'Quando faz logout, é redirecionado para o /' );

done_testing();
