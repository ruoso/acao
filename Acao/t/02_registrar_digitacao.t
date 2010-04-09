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

my $res = request POST '/login', [ user => 'ciclano', password => '12345', ];

is( $res->code, 302, 'Quando a autenticação é bem sucedida, ele faz um redirect');
is( $res->header('Location'), 'http://localhost/auth', 'Ele manda para a área autenticada' );
ok( $res->header('Set-Cookie'), 'A autenticação definiu o Cookie');

my $sess_cicl = $res->header('Set-Cookie');

$res = request GET('/auth/registros/digitador/', Cookie => $sess_cicl);
is( $res->code, 200, 'Apresentando lista de cadastros' );

my $content = $res->content;
while ($content =~ m{href="http://localhost(/auth/registros/digitador/([^"]+))}gis) {
    $res = request GET($1, Cookie => $sess_cicl);
    is( $res->code, 200, 'Acessando cadastro ' . $2);

    $res = request GET('/auth/registros/digitador/'.$2.'/xsd', Cookie => $sess_cicl);
    is( $res->code, 200, 'Encontrando XSD do cadastro ' . $2);

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

    $res = request POST('/auth/registros/digitador/'.$2.'/store',
                        [ processed_xml => $xml->toString,
                          controle => 123 ],
                        Cookie => $sess_cicl);
    is($res->code, 302, 'Redirecionou depois do post.');
    is($res->header('Location'),'http://localhost/auth/registros/digitador',
       'Devolve para a tela da lista de formulários');
    $res = request GET('/auth/registros/digitador', Cookie => $sess_cicl);
    is($res->code, 200, 'Foi para a tela do digitador');
    like($res->content, qr(realizada com sucesso), 'Foi armazenado');

}

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
                                    redeColetaEsgoto => 'Sim',
                                    esgotamentoSanitario2 => {
                                                              tipoAbastecimentoAgua2Outro => 'asd',
                                                            },
                },
            }
                
    } elsif ($element =~ /formCadernoB/) {
        return{
                composicaoFamiliar => {},
                educacao           => {},
                saudeMulher        => {},
                saude              => {},
                trabalho           => {},
                renda              => {},
              }
    } else {
        return { die 'Nenhum Cadadastro encontrado'};
    }
}

