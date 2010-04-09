use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

use XML::LibXML;
use XML::Compile::Schema;
use XML::Compile::Util;
use Acao::Model::Sedna;
use utf8;

use constant DIGITACAO_NS =>
  'http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd';

my $controle =
  XML::Compile::Schema->new( Acao->path_to('schemas/controledigitacao.xsd') );
my $controle_w = $controle->compile(
    WRITER                => pack_type( DIGITACAO_NS, 'registroDigitacao' ),
    use_default_namespace => 1
);

BEGIN { use_ok 'Catalyst::Test', 'Acao' }
my $res;

$res = request POST '/login', [user     => 'beltrano',
                               password => '12345'];
is( $res->code, 302, 'Quando a autenticação é bem sucedida com perfil revisor, ele faz um redirect.');
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie.');
my $cookie_revisor = $res->header('Set-Cookie');

$res = request GET('/auth/registros/revisor', Cookie => $cookie_revisor);
is( $res->code, 200, 'Redirecionando para pagina inicial do perfil revisor com a listagem dos instrumentos permitidas para aquele revisor.');
like( $res->content, qr(href="http://localhost/auth/registros/revisor"), 'A tela mostrou link para a listagem dos documentos pertinentes ao Instrumento selecionado.' );

my $content = $res->content;
while ($content =~ m{href="http://localhost/(auth/registros/revisor/(\d+))"}gis){
	
	$res = request GET($1, Cookie => $cookie_revisor);
	is($res->code, 200, 'Abrindo listagem de documentos referentes a Leitura ' . $2);
	my $content = $res->content;
	
	while ($content =~ m{href="http://localhost/(auth/registros/revisor/\d+/fecharDocumento/([^"]+))"}gis){
		$res = request GET($1, Cookie => $cookie_revisor);
		is($res->code, 302, 'Fechando digitação ' . $2);
	}

	while ($content =~ m{href="http://localhost/(auth/registros/revisor/\d+/aprovar/digitacao_([^"]+)/([^"]+))"}gis){
		$res = request GET($1, Cookie => $cookie_revisor);
		is($res->code, 302, 'Aprovando digitação ' . $3);
	}

	while ($content =~ m{href="http://localhost/(auth/registros/revisor/\d+/rejeitar/digitacao_([^"]+)/([^"]+))"}gis){
		$res = request GET($1, Cookie => $cookie_revisor);
		is($res->code, 302, 'Rejeitando digitação ' . $3);
	}

	while ($content =~ m{href="http://localhost(/auth/registros/revisor/(\d+)/visualizar/(digitacao_[^"]+))"}gis){
        $res = request GET($1, Cookie => $cookie_revisor);
        is($res->code, 200, 'Visualizando Cadastro ' . $3);

        my $content = $res->content;        

		$res = request GET('/auth/registros/revisor/'.$2.'/xsd', Cookie => $cookie_revisor);
		is( $res->code, 200, 'Encontrando XSD do revisor ' . $2);

        my $xsd = $res->content;
		my $x_c_s    = XML::Compile::Schema->new($xsd);
		ok($x_c_s, 'XSD retornado é valido.');

		my ($element) = $x_c_s->elements;
		my $writer = $x_c_s->compile( WRITER => $element );
		ok($writer, 'Consegue produzir o writer do documento xml');

		my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
		my $xml = 
		   $writer->( $doc,
		              _obter_dados_digitados($element)
		            );

        $res = request POST('/auth/registros/revisor/'.$2.'/visualizar/'.$3.'/store',
		                    [ processed_xml => $xml->toString,
		                      controle => 123],
		                      Cookie => $cookie_revisor);

        is($res->code, 302, 'Redirecionou depois do post.');
		is($res->header('Location'),'http://localhost/auth/registros/revisor/'.$2,
		   'Devolve para a tela da lista de formulários');
        $res = request GET($res->header('Location'), Cookie => $cookie_revisor);
        like($res->content, qr(Negado),'Este usuário não tem permissão para esta operação');




        $res = request POST '/login', [user     => 'acao',
                               password => '12345'];
        is( $res->code, 302, 'Logando-se com perfil revisor_digitador, ele faz um redirect.');
        ok( $res->header('Set-Cookie'), 'A autenticação redefiniu o Cookie.');
        my $cookie_revisor_digitador = $res->header('Set-Cookie');

        $res = request POST('/auth/registros/revisor/'.$2.'/visualizar/'.$3.'/store',
		                    [ processed_xml => $xml->toString,
		                      controle => 123],
		                      Cookie => $cookie_revisor_digitador);

        is($res->code, 302, 'Redirecionou depois do post.');
		is($res->header('Location'),'http://localhost/auth/registros/revisor/'.$2,
		   'Devolve para a tela da lista de formulários');
        $res = request GET($res->header('Location'), Cookie => $cookie_revisor_digitador);
        if($res->content =~ 'O estado de controle'){
            like($res->content, qr(O estado de controle),'O estado de controle deve ser Aberto');
        }
        if($res->content =~ 'sucesso'){
            like($res->content, qr(sucesso),'Foi armazenado');
        }


	}
}

$res = request GET('/auth/registros/revisor', Cookie => $cookie_revisor);
is( $res->code, 200, 'Redirecionando para pagina inicial do perfil revisor com a listagem dos instrumentos permitidas para aquele revisor.');

$res = request GET('/auth/registros/revisor/1', Cookie => $cookie_revisor);
is( $res->code, 200, 'Redirecionou para a pagina de listagem dos documentos pertinentes ao Instrumento');

done_testing();

sub _obter_dados_digitados {
    my $element = shift;
    if ($element =~ /formCadernoA/) {
        return
            { identificacao => {
                                    codigoPMF           => 1,
                                    codigoPMFNaoTem     => 'false',
                                    data                => 2010-01-01,
                                    orgaoCadastrador    => 'asd',
                                    entrevistador       => 'asd',
                                    titularBeneficiario => 'asd',
                                    tipoDemanda         => 'Espontânea',
                                    cartao              => 'Entregue',
                                },
            enderecoImovel => {
                                    logradouro              => 1,
                                    numero                  => 1,
                                    complemento             => 'asd',
                                    setor                   => 'asd',
                                    localizacaoCartografica => 'asd',
                                    bairro                  => 'asd',
                                    telefone                => '123456',
                                },
            caracteristicasImovel => {
                                    localizacao => {
                                                    quadraloteada                   => 'false',
                                                    leitoDeRua                      => 'false',
                                                    praca                           => 'false',
                                                    areaVerde                       => 'false',
                                                    terroParaEquipamentoComunitario => 'false',
                                                    outro                           => 'false',
                                                    },
                                    compartimentosMoradia => {
                                                    qtdQuartos       => 1,
                                                    qtdSalas         => 1,
                                                    qtdCozinhas      => 1,
                                                    qtdBanheiros     => 1,
                                                    qtdQuintais      => 1,
                                                    qtdUotros        => 1,
                                                    localizacaoOutro => '1',
                                                        }
                },
                infraestrutura => {
                                    redeDeAgua => 'Sim',
                                    abastecimentoAguaPublicoPrivado => 'Público',
                                    abastecimentoAgua => {
                                                    tipoAbastecimentoAgua =>  'Hidrômetro Individual',
                                                         },
                                    esgotamentoSanitario2 => {
                                                              tipoAbastecimentoAgua2Outro => 'asd',
                                                            }
                },
            }
                
    } elsif ($element =~ /formCadernoB/) {
		return 
			{ composicaoFamiliar => {},
			  educacao 			 => {},
			  saudeMulher 		 => {},
			  saude 			 => {},
			  trabalho   		 => {},
			  renda 			 => {
			  							rendaMensal => '1⁄2 a 1 salário mínimo'				
			   						},
            };
    } else {
		die 'era para eu ter retornado uma estrutura aqui!'
    }
}
