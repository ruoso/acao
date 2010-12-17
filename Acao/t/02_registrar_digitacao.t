use strict;
use warnings;
use Test::More;
use HTTP::Request::Common;

use XML::LibXML;
use XML::Compile::Schema;
use XML::Compile::Util;
use Acao::Model::Sedna;
use utf8;

=head1 NAME

Acao - Módulo principal da aplicação

=head1 DESCRIPTION

Este é o módulo principal da aplicação Catalyst, declara os plugins a
serem carregados e a versão da aplicação.

=head1 METHODS

=cut

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
my $incremento = 0;
my $leitura = 0;
for ($incremento = 0; $incremento <=1; $incremento++){

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
                              controle => $leitura ],
                            Cookie => $sess_cicl);
        is($res->code, 302, 'Redirecionou depois do post.');
        is($res->header('Location'),'http://localhost/auth/registros/digitador',
           'Devolve para a tela da lista de formulários');
        $res = request GET('/auth/registros/digitador', Cookie => $sess_cicl);
        is($res->code, 200, 'Foi para a tela do digitador');
        
        if($res->content =~ 'O estado de controle'){
           like($res->content, qr(O estado de controle),'O estado de controle deve ser Aberto');
        }
        if($res->content =~ 'sucesso'){
            if($leitura){
                 like($res->content, qr(sucesso),'FALHA: Foi armazenado um controle duplicado');
            }
            else{
                 like($res->content, qr(sucesso),'Foi armazenado');
            }
        }
    }
 $leitura = DateTime->now();
}

done_testing();

sub _obter_dados_digitados {
    my $element = shift;
    if ($element =~ /formCadernoA/) {
        return
            { 
             infraestrutura => {
                                            abastecimentoAguaPublicoPrivado => "Público",
                                            esgotamentoSanitario2 => {
                                                                       tipo => 'CAGECE (Sanear)',
                                                                       tipoAbastecimentoAgua2Outro => '1'
                                                                     },
                                            redeDeAgua => 'Sim',
                                            tipoDrenagem => {
                                                              sarjeta => 1,
                                                              cursoDaguaCanalizado => 1,
                                                              tipoDrenagemOutro => '1',
                                                              outro => 1,
                                                              cursoDaguaNaoCanalizado => 1,
                                                              galeriaSubterranea => 1
                                                            },
                                            tipoLigacaoRedeEletrica => 'Inexistente',
                                            tipoPavimentacao => 'Asfalto',
                                            esgotamentoSanitario => 'Rede Oficial',
                                            tipoServicoTelefonicoPredominante => 'Fixo',
                                            abastecimentoAgua => {
                                                                   tipoAbastecimentoAguaOutro => '1',
                                                                   tipoAbastecimentoAgua => "Hidrômetro Individual"
                                                                 },
                                            destinoLixo => {
                                                             queimado => 1,
                                                             cursoDagua => 1,
                                                             passeio => 1,
                                                             tipoDrenagemOutro => '1',
                                                             enterrado => 1,
                                                             terrenoBaldio => 1,
                                                             sistemaColeta => 1,
                                                             conteiner => 1,
                                                             logradouro => 1,
                                                             outro => 1
                                                           },
                                            redeColetaEsgoto => 'Sim'
                                          },
                        outrasObservacoes => '1',
                        identificacao => {
                                           codigoPMFNaoTem => 1,
                                           codigoPMF => 1,
                                           data => '2010-01-01',
                                           orgaoCadastrador => '1',
                                           cartao => 'Entregue',
                                           tipoDemanda => "Espontânea",
                                           entrevistador => '1',
                                           titularBeneficiario => '1'
                                         },
                        necessitaReparos => {
                                              tipoReparoOutro => '1',
                                              pintura => 1,
                                              outro => 1,
                                              instalacoesHidrosanitarias => 1,
                                              cobertaTelhado => 1
                                            },
                        caracteristicasImovel => {
                                                   cartorio => '1',
                                                   situacaoFundiaria => "Público",
                                                   tipoServico => '1',
                                                   tipoPiso => 'Barro Batido',
                                                   telefoneProprietario => '1',
                                                   zona => '1',
                                                   revestimentoParede => 'Com Reboco',
                                                   tipoCobertura => 'Telha',
                                                   TempoMoradia => 'Menos de 1 ano',
                                                   casaEmSituacaRisco => 'Sim',
                                                   tipoMoradia => "Própria",
                                                   tipologiaUso => 'Residencial',
                                                   tipoRisco => {
                                                                  tipoRiscoOutro => '1',
                                                                  viaFerrea => 1,
                                                                  linhaAltaTensao => 1,
                                                                  deslizamento => 1,
                                                                  alagamento => 1,
                                                                  outro => 1,
                                                                  inundacao => 1
                                                                },
                                                   localizacao => {
                                                                    leitoDeRua => 1,
                                                                    localizacaoOutro => '1',
                                                                    terroParaEquipamentoComunitario => 1,
                                                                    areaVerde => 1,
                                                                    quadraloteada => 1,
                                                                    outro => 1,
                                                                    praca => 1
                                                                  },
                                                   areaPreservacao => 'Sim',
                                                   nomeProprietario => '1',
                                                   enderecoProprietario => '1',
                                                   numMatricula =>1,
                                                   valor => 1,
                                                   compartimentosMoradia => {
                                                                              qtdCozinhas => 1,
                                                                              qtdQuartos => 1,
                                                                              qtdUotros => 1,
                                                                              qtdSalas => 1,
                                                                              localizacaoOutro => '1',
                                                                              qtdQuintais => 1,
                                                                              qtdBanheiros' => 1
                                                                            },
                                                   tipologiaConstrucao => 'Alvenaria'
                                                 },
                        enderecoImovel => {
                                            bairro => '1',
                                            observacoes => '1',
                                            numero => 1,
                                            notificacao => '2010-01-01T11:11:11',
                                            visita3 => '2010-01-01T11:11:11',
                                            informante => 'Presente',
                                            visita2 => '2010-01-01T11:11:11',
                                            localizacaoCartografica => '1',
                                            visita1 => '2010-01-01T11:11:11',
                                            telefone => '1',
                                            complemento => '1',
                                            logradouro => '1',
                                            setor => '1'
                                          }
            }
                
    } elsif ($element =~ /formCadernoB/) {
        return{          
              saude => {
                         deficienciaVisual => 'Sim',
                         deficienciaVisualOutras => '1',
                         unidadeMedicaProcurada => 'Hospital',
                         deficienciaAuditivoOutras => '1',
                         historicoDoencas => {
                                               doencasnaotem => 1,
                                               verminose => 1,
                                               doencasRespiratoria => 1,
                                               alcoolismo => 1,
                                               outroespecifique => '1',
                                               naosei => 1,
                                               drogas => 1,
                                               virose => 1,
                                               dengue => 1,
                                               outro => 1,
                                               doencaPele => 1,
                                               diarreia => 1
                                             },
                         postoSaudeTratamento => '1',
                         deficienciaFisicaOutras => '1',
                         deficienciaMental => 'Sim',
                         situacaoRisco => {
                                            hivAids => 1,
                                            transtornopisicologico => 1,
                                            doencasChagas => 1,
                                            epilepsia => 1,
                                            malaria => 1,
                                            tuberculose => 1,
                                            outro => 1,
                                            fragilidadesnaotem => 1,
                                            pcl => 1,
                                            tabagismo => 1,
                                            hipertencao => 1,
                                            situacaoRiscoOutro => '1',
                                            hanseniase => 1,
                                            maustratosviolencia => 1,
                                            diabetes => 1,
                                            dst => 1
                                          },
                         deficienciaMentalOutras => '1',
                         deficienciaAuditiva => 'Sim',
                         emtratamento => 'Sim',
                         deficienciaFisica => 'Sim'
                       },
              saudeMulher => {
                               fezPrevencao => 'Sim',
                               tratamentoContraceptivo => {
                                                            pilula => 1,
                                                            diu => 1,
                                                            tabela => 1,
                                                            camisinha => 1,
                                                            nao => 1,
                                                            laqueadura => 1,
                                                            tratramentoContraceptivoOutros => 1,
                                                            remedioCaseiro => 1
                                                          },
                               qtdGravidou => 'nenhuma',
                               obitoInfantilUltimoAno => "Não",
                               causasObitos => "Infecção Respeiratória",
                               fezPrenatal => 'Sempre',
                               causaObitosOutras => '1'
                             },
              trabalho => {
                            horasTrabalhada => '1',
                            statusAtual => 'Empregado c/ Carteira Assinada',
                            profissaoAtividade => '1',
                            porqueNaoEcontraTrabalho => {
                                                          outrasCausasPessoais => 1,
                                                          lugarResidencia => 1,
                                                          problemasDeSaude => 1,
                                                          faltaExperiencia => 1,
                                                          problemasDeSaudeQual => '1',
                                                          naoHaTrabalhoEspecialidade => 1,
                                                          naoHaTrabalho => 1,
                                                          Outros => '1',
                                                          faltaCapacitacao => 1,
                                                          nivelEscolaridade => 1,
                                                          outrasCausasTrabalhista => 1,
                                                          idade => 1
                                                        },
                            tempoprocurandotrabalho => '30 dias',
                            diasTrabalhado => '1',
                            meioTransporteTrabalho => {
                                                        trem => 1,
                                                        carro => 1,
                                                        ape => 1,
                                                        naoSeAplica'=> 1,
                                                        bicicleta => 1,
                                                        onibus => 1
                                                      }
                          },
              outrasObservacoes => '1',
              educacao => {
                            grauEscolaridade => "Pré-escolar",
                            motivoDeParaDeEstudar => 'Trabalho',
                            opcoesDeLazer => {
                                               festas => 1,
                                               assistirTV => 1,
                                               sairComVizinhos => 1,
                                               futebolOutrosEsportes => 1,
                                               opcoesDeLazerOutras => 1,
                                               frequentarBares => 1,
                                               outras => '1',
                                               vaiaPracas => 1,
                                               escultarMusica => 1,
                                               participarDeAlumaOrganizacao => 1,
                                               igrejasOuAssociacoesReligiosas => 1
                                             },
                            cursandoAtualmente=> 'Sim',
                            tipoDeEscola => "Pública",
                            desejaEstudar => 'Sim',
                            motivoDepararDeEstudarOutro => '1',
                            nomeDaEscola => '1'
                          },
              composicaoFamiliar => {
                                      nome => '1',
                                      formularioPrincipal => 1,
                                      apelido => '1',
                                      data => '2010-01-01',
                                      expedidor => '1',
                                      informante => 'Chefe',
                                      documentos => {
                                                      tituloDeEleitor => 1,
                                                      cpf => 1,
                                                      rg => 1,
                                                      nis => 1,
                                                      naotem => 1
                                                    },
                                      sexo => 'Masculino',
                                      cpf => 1,
                                      rg => 1,
                                      nis => 1,
                                      situacaoConjugal => 'Solteiro(a)',
                                      idade => 1
                                    },
              renda => {
                         rendaMensal => "0 a 1\2 salário mínimo",
                         origemRenda => {
                                          ongs => 1,
                                          bolsaFamilia => 1,
                                          vizinhoComunidade => 1,
                                          igreja => 1,
                                          origemRendaOutroDesc => '1',
                                          origemRendaOutros => 1,
                                          salario => 1,
                                          projovem => 1,
                                          naoAplica => 1,
                                          bpcPne => 1,
                                          jovemAmbientalista => 1,
                                          familiaCidada => 1,
                                          bpcIdoso => 1,
                                          familiares => 1
                                        }
                       }
              }
    } else {
        return { die 'Nenhum Cadadastro encontrado'};
    }
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut
