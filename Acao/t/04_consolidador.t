use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

=head1 NAME

Classe de teste de Login/Logout.

=head1 DESCRIPTION

Essa classe executa o teste automatizado de todos os passos que se encontram abaixo 
do galho consolidador utilizando o padrão de teste da linguagem/framework. O teste é 
realizado percorrendo todos os passos executados pelo usuário do sistema na 
execução da mesma tarefa retornando as mensagens correspondentes à resposta do 
serviço.

=cut

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
my $res;

$res = request POST '/login', [user => 'acao', 
                               password => '12345'];
is( $res->code, 302, 'Usuario logado com sucesso' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.' );
my $cookie_consolidador =  $res->header('Set-Cookie');

$res = request GET('/auth/registros/consolidador', Cookie => $cookie_consolidador);
is( $res->code, 200, 'Redirecionando para pagina inicial do perfil consolidador com a listagem das definicoes de consolidacção permitidas para aquele consolidador' );
like( $res->content, qr(href="http://localhost/auth/registros/consolidador/1"), 'Mostrou o link para as consolidações pertinentes a definicao consolidacao' );

$res = request GET('/auth/registros/consolidador/1', Cookie => $cookie_consolidador);
is( $res->code, 200, 'Redirecionando para pagina de listagem das consolidacoes pertinentes a definicao consolidacao selecionada' );
like( $res->content, qr(href="http://localhost/auth/registros/consolidador/1/iniciar"),'Mostrou o link para iniciar uma nova consolidação' );

$res = request GET('/auth/registros/consolidador/1/iniciar', Cookie => $cookie_consolidador);
is( $res->code, 302, 'Redirecionando para pagina de listagem dos alertas pertinentes a consolidacao selecionada' );

(my $endereco = $res->header('Location')) =~ s{^http://localhost/}{};

$res = request GET($endereco , Cookie => $cookie_consolidador);
is( $res->code, 200, 'listando as consolidacoes pertinentes a consolidacao selecionada' );
like( $res->content, qr(url_template), 'Encontrado código javascript que atualizará a listagem dos alertas' );

my $encontrado = 1;
my $ponto = '.';

while ($encontrado){
    $res = request GET($endereco . "/fragmentos_alertas/0" , Cookie => $cookie_consolidador);
    is( $res->code, 200, 'Encontrando fragmentos_alertas' . $ponto );
    if($res->content =~ qr(<tr id=.+>\n\s*<td>5</td>)){
        $encontrado = 0;
    }
    sleep 3;
    $ponto = $ponto . '.';
}
like( $res->content, qr(<tr id="alerta_\d+">\s+<td>5</td>)s, 'Consolidação concluída' );

$res = request GET($endereco , Cookie => $cookie_consolidador);
is( $res->code, 200, 'Procurando documentos a serem visualizados' );
my $content = $res->content;
while ($content =~ m{href="http://localhost(/$endereco/entradas/consolidacao_([^"]+))}gis) {
    $res = request GET($1, Cookie => $cookie_consolidador);
    is( $res->code, 200, 'listando os documentos de entrada pertinentes ao alerta ' . $2);

    my $conteudo = $res->content;
    while ($conteudo =~ m{href="http://localhost(/auth/registros/revisor/([^"]+))}gis) {
        $res = request GET($1, Cookie => $cookie_consolidador);
        is( $res->code, 200, 'Visualizando documento ' . $2);
    }
}

done_testing();

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut
