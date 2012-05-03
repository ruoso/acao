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

$res = request POST '/login', [user => 'jackson.gomes', 
                               password => '12345'];
is( $res->code, 302, 'Usuario logado com sucesso' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.' );
my $cookie_volume =  $res->header('Set-Cookie');

#$res = request GET('/auth/registros/volume', Cookie => $cookie_volume);
#is( $res->code, 200, 'Redirecionando para pagina inicial do perfil volume com a listagem dos volumes permitidas para aquele usuario' );
#like( $res->content, qr(href="http://localhost/auth/registros/volume/volume-2633497e-7395-411b-9587-a9ec8da00c05"), 'Mostrou o link para Volume PSC' );

#$res = request GET('/auth/registros/consolidador/volume-2633497e-7395-411b-9587-a9ec8da00c05', Cookie => $cookie_volume);
#is( $res->code, 200, 'Redirecionando para pagina de listagem dos prontuarios/dossies pertinentes ao volume selecionado' );
#like( $res->content, qr(href="http://localhost/auth/registros/volume/volume-2633497e-7395-411b-9587-a9ec8da00c05/?interval_ini=1"),'Mostrou o link para a segunda lista da paginacao de prontuarios' );

my $encontrado = 1;
my $i = 2;

while ($encontrado){
    $res = request GET("auth/registros/volume/volume-2633497e-7395-411b-9587-a9ec8da00c05/?interval_ini=" . $i , Cookie => $cookie_volume);
    is( $res->code, 200, 'Encontrada pagina' . $i );
    $i++;
    if($res->content !~ qr(Próximo)){
        $encontrado = 0;
    }
    #sleep 3;
}
done_testing();

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut
