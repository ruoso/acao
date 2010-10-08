use Sedna;
use XML::Compile::Schema;
use XML::Compile::Util qw(pack_type);
use DBIx::Class::Schema;
use File::Spec::Functions;
use FindBin qw($Bin);
use lib catfile($Bin, '..', 'lib');
use DateTime::Format::XSD;
use strict;
use warnings;
use Data::Dumper;

use aliased 'Acao::Plugins::SDH::DimSchema';

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');

my $dbi = DimSchema->connect("dbi:Pg:dbname=sdh;host=127.0.0.1;port=5432",'acao','blableblibloblu');

BEGIN {
    die 'Informe a variavel de ambiente ACAO_HOME' unless -d $ENV{ACAO_HOME};
}

#define as constantes para os caminhos dos schemas, utilizando variável de ambiente
use constant HOME_SCHEMAS => $ENV{HOME_SCHEMAS} || catfile($Bin, '..', 'schemas');
use constant SCHEMA_DOSSIE    => catfile($ENV{ACAO_HOME}, 'schemas', 'dossie.xsd');
use constant SCHEMA_AUDITORIA => catfile($ENV{ACAO_HOME}, 'schemas', 'auditoria.xsd');
use constant SCHEMA_DOCUMENTO => catfile($ENV{ACAO_HOME}, 'schemas', 'documento.xsd');
use constant SCHEMA_ATENDIMENTOESPECIFICOSEGARANTA => catfile(HOME_SCHEMAS, 'sdh-atendimentoEspecificoSEGARANTA.xsd');
use constant SCHEMA_CONDICOESDEMORADIA             => catfile(HOME_SCHEMAS, 'sdh-condicoesDeMoradia.xsd');
use constant SCHEMA_CONVIVENCIAFAMILIARCOMUNITARIA => catfile(HOME_SCHEMAS, 'sdh-convivenciaFamiliarComunitaria.xsd');
use constant SCHEMA_CONVIVENCIASOCIAL              => catfile(HOME_SCHEMAS, 'sdh-convivenciaSocial.xsd');
use constant SCHEMA_DIRECIONAMENTODOATENDIMENTO    => catfile(HOME_SCHEMAS, 'sdh-direcionamentoDoAtendimento.xsd');
use constant SCHEMA_DOCUMENTACAO                   => catfile(HOME_SCHEMAS, 'sdh-documentacao.xsd');
use constant SCHEMA_EDUCACAO                       => catfile(HOME_SCHEMAS, 'sdh-educacao.xsd');
use constant SCHEMA_IDENTIFICACAOPESSOAL           => catfile(HOME_SCHEMAS, 'sdh-identificacaoPessoal.xsd');
use constant SCHEMA_JURIDICO                       => catfile(HOME_SCHEMAS, 'sdh-juridico.xsd');
use constant SCHEMA_ORIGEMENCAMINHAMENTO           => catfile(HOME_SCHEMAS, 'sdh-origemEncaminhamento.xsd');
use constant SCHEMA_PEDAGOGIA                      => catfile(HOME_SCHEMAS, 'sdh-pedagogia.xsd');
use constant SCHEMA_PLANOINDIVIDUALDEATENDIMENTO   => catfile(HOME_SCHEMAS, 'sdh-planoIndividualDeAtendimento.xsd');
use constant SCHEMA_PROFISSIONALIZACAOHABILIDADES  => catfile(HOME_SCHEMAS, 'sdh-profissionalizacaoHabilidades.xsd');
use constant SCHEMA_PSICOLOGIA                     => catfile(HOME_SCHEMAS, 'sdh-psicologia.xsd');
use constant SCHEMA_RELATORIOSENCAMINHADOS         => catfile(HOME_SCHEMAS, 'sdh-relatoriosEncaminhados.xsd');
use constant SCHEMA_SAUDE                          => catfile(HOME_SCHEMAS, 'sdh-saude.xsd');
use constant SCHEMA_SERVICOSOCIAL                  => catfile(HOME_SCHEMAS, 'sdh-servicoSocial.xsd');
use constant SCHEMA_VINCULACAONACCA                => catfile(HOME_SCHEMAS, 'sdh-vinculacaoNaCCA.xsd');
use constant SCHEMA_VINCULORELIGIOSO               => catfile(HOME_SCHEMAS, 'sdh-vinculoReligioso.xsd');
use constant SCHEMA_VISITADOMICILIAR               => catfile(HOME_SCHEMAS, 'sdh-visitaDomiciliar.xsd');
use constant SCHEMA_PROTECAOESPECIAL               => catfile(HOME_SCHEMAS, 'sdh-protecaoEspecial.xsd');
use constant SCHEMA_INDIVIDUALFAMILIA              => catfile(HOME_SCHEMAS, 'sdh-individualFamilia.xsd');

use constant DOSSIE_NS    => 'http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd';
use constant DOCUMENTO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/documento.xsd';
use constant AUDITORIA_NS => 'http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd';

my $schema_form = {
               'formAtendimentoEspecificosegaranta' => XML::Compile::Schema->new(SCHEMA_ATENDIMENTOESPECIFICOSEGARANTA),
               'formCondicoesDeMoradia'             => XML::Compile::Schema->new(SCHEMA_CONDICOESDEMORADIA),
               'formConvivenciafamiliarcomunitaria' => XML::Compile::Schema->new(SCHEMA_CONVIVENCIAFAMILIARCOMUNITARIA),
               'formconvivenciasocial'              => XML::Compile::Schema->new(SCHEMA_CONVIVENCIASOCIAL),
               'formdirecionamentodoatendimento'    => XML::Compile::Schema->new(SCHEMA_DIRECIONAMENTODOATENDIMENTO),
               'formDocumentacao'                   => XML::Compile::Schema->new(SCHEMA_DOCUMENTACAO),
               'formeducacao'                       => XML::Compile::Schema->new(SCHEMA_EDUCACAO),
               'formidentificacaopessoal'           => XML::Compile::Schema->new(SCHEMA_IDENTIFICACAOPESSOAL),
               'formjuridico'                       => XML::Compile::Schema->new(SCHEMA_JURIDICO),
               'formorigemencaminhamento'           => XML::Compile::Schema->new(SCHEMA_ORIGEMENCAMINHAMENTO),
               'formpedagogia'                      => XML::Compile::Schema->new(SCHEMA_PEDAGOGIA),
               'formplanoindividualdeatendimento'   => XML::Compile::Schema->new(SCHEMA_PLANOINDIVIDUALDEATENDIMENTO),
               'formprofissionalizacaohabilidades'  => XML::Compile::Schema->new(SCHEMA_PROFISSIONALIZACAOHABILIDADES),
               'formPsicologia'                     => XML::Compile::Schema->new(SCHEMA_PSICOLOGIA),
               'formrelatoriosencaminhados'         => XML::Compile::Schema->new(SCHEMA_RELATORIOSENCAMINHADOS),
               'formsaude'                          => XML::Compile::Schema->new(SCHEMA_SAUDE),
               'formservicosocial'                  => XML::Compile::Schema->new(SCHEMA_SERVICOSOCIAL),
               'formvinculacaonacca'                => XML::Compile::Schema->new(SCHEMA_VINCULACAONACCA),
               'formvinculoreligioso'               => XML::Compile::Schema->new(SCHEMA_VINCULORELIGIOSO),
               'formvisitadomiciliar'               => XML::Compile::Schema->new(SCHEMA_VISITADOMICILIAR),
               'formprotecaoespecial'               => XML::Compile::Schema->new(SCHEMA_PROTECAOESPECIAL),
               'formindividualfamilia'              => XML::Compile::Schema->new(SCHEMA_INDIVIDUALFAMILIA),
                  };

my $schema = XML::Compile::Schema->new([SCHEMA_DOCUMENTO, SCHEMA_AUDITORIA]);
my $read = $schema->compile(READER => pack_type(DOCUMENTO_NS, 'documento'),  any_element => 'TAKE_ALL');

sub extract {

 #   my ($id_volume) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    for $x in collection("volume-BE4B7112-D214-11DF-97B9-284E42D8BC49")/dos:dossie[dos:controle="BFB8827E-D214-11DF-97B9-284E42D8BC49"]
                    /dos:doc/dc:documento[dc:invalidacao/text() eq "1970-01-01T00:00:00Z"] return $x';

    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);
  my @result;
  my $result_hash = ();
my $nr = 0;
  while ($sedna->next){
       #atribui os itens retornados da consulta acima na variavel $xsd sob a forma de XML String
       my $xml_string = $sedna->getItem();
       my $data = $read->($xml_string);

       my @array_keys = keys( %{ $data->{documento}[0]{conteudo}} );
       my @namespace = split(/}/, $array_keys[0]);

       my $read_doc = $schema_form->{$namespace[1]}->compile(READER => pack_type( substr($namespace[0],1) , $namespace[1] ));
       my $data_doc =  $read_doc->($data->{documento}[0]{conteudo}{pack_type(substr($namespace[0],1) ,  $namespace[1])}[0]);

      push @result, { $namespace[1] . $nr => $data_doc};
$nr++;
  }

 %{$result_hash}  = (%{$result[0]} , %{$result[1]} ,%{$result[2]});
warn $result_hash->{formDocumentacao0}{registroDeNascimentoNumero};
    $sedna->commit;
    
}

sub transform {
    my ($data) = @_;
    transform_endereco($data->{formIdentificacaoPessoal}{endereco});
}

sub transform_endereco {
    my $data = shift;
    $data->{endereco} = $dbi->resultset('DEndereco')->find_or_create({ endereco => $data->{endereco},
                                                                       bairro => $data->{bairro},
                                                                       cidade => $data->{cidade},
                                                                     })->id_endereco;
}

sub transform_estado_civil {
    my $data = shift;
    $data->{estado_civil} = $dbi->resultset('DEstadoCivil')->find_or_create({ estado_civil => $data->{estado_civil},
                                                                            })->id_estado_civil;
}

sub transform_raca_etnia {
    my $data = shift;
    $data->{raca_etnia} = $dbi->resultset('DRacaEtinia')->find_or_create({ raca_etnia => $data->{raca_etnia},
                                                                            })->id_estado_civil;
}

sub transform_sexo {
    my $data = shift;
    $data->{sexo} = $dbi->resultset('DSexo')->find_or_create({ raca_etnia => $data->{sexo},
                                                                            })->id_sexo;
}

sub transform_sexualidade {
    my $data = shift;
    $data->{sexualidade} = $dbi->resultset('DSexualidade')->find_or_create({ raca_etnia => $data->{sexualidade},
                                                                            })->id_sexualidade;
}

sub transform_registro_nascimento {
    my $data = shift;
    $data->{registro_nascimento} = $dbi->resultset('DRegistroNascimento')->find_or_create({ situacao => $data->{registro_nascimento},
                                                                            })->id_registro_nascimento;
}

sub transform_identidade {
    my $data = shift;
    $data->{identidade} = $dbi->resultset('DIdentidade')->find_or_create({ situacao => $data->{identidade},
                                                                            })->id_identidade;
}

sub transform_cpf {
    my $data = shift;
    $data->{cpf} = $dbi->resultset('DCpf')->find_or_create({ situacao => $data->{cpf},
                                                                            })->id_cpf;
}

sub transform_ctps {
    my $data = shift;
    $data->{ctps} = $dbi->resultset('DCtps')->find_or_create({ situacao => $data->{ctps},
                                                                            })->id_ctps;
}

sub transform_titulo_eleitor {
    my $data = shift;
    $data->{titulo_eleitor} = $dbi->resultset('DTitulo_eleitor')->find_or_create({ situacao => $data->{titulo_eleitor},
                                                                            })->id_titulo_eleitor;
}

sub transform_reservista {
    my $data = shift;
    $data->{reservista} = $dbi->resultset('DReservista')->find_or_create({ situacao => $data->{reservista},
                                                                            })->id_reservista;
}

sub transform_nis {
    my $data = shift;
    $data->{nis} = $dbi->resultset('DNis')->find_or_create({ situacao => $data->{nis},
                                                                            })->id_nis;
}

sub transform_data {
    my $data = shift;
    my $dt = DateTime::Format::XSD->parse_datetime( $data->{data} );
    $data->{data} = $dbi->resultset('DData')->find_or_create({ data => $data->{data},
                                                               dia  => $dt->day,
                                                               mes  => $dt->month,
                                                               ano  => $dt->year,
                                                               bimestre => int(($dt->month-1)/2)+1,
                                                               trimestre => int(($dt->month-1)/3)+1,
                                                               semestre => $dt->month < 6 ? 1 : 2,
                                                               dia_semana => $dt->day_of_week,
                                                              })->id_data;
}

sub transform_destino_lixo {
    my $data = shift;
    $data->{destino_lixo} = $dbi->resultset('DDestinoLixo')->find_or_create({ destino_lixo => $data->{destino_lixo},
                                                                            })->id_destino_lixo;
}

sub transform_escoamento_sanitario{
    my $data = shift;
    $data->{escoamento_sanitario} = $dbi->resultset('DEscoamentoSanitario')->find_or_create({ escoamento_sanitario => $data->{escoamento_sanitario},
                                                                            })->id_escoamento_sanitario;
}

sub transform_tipo_iluminacao {
    my $data = shift;
    $data->{tipo_iluminacao} = $dbi->resultset('DTipoIluminacao')->find_or_create({ tipo_iluminacao => $data->{tipo_iluminacao},
                                                                            })->id_tipo_iluminacao;
}

sub transform_tratamento_agua {
    my $data = shift;
    $data->{tratamento_agua} = $dbi->resultset('DTratamentoAgua')->find_or_create({ tratamento_agua => $data->{tratamento_agua},
                                                                            })->id_tratamento_agua;
}

sub transform_tipo_abastecimento_agua {
    my $data = shift;
    $data->{tipo_abastecimento_agua} = $dbi->resultset('DTipoAbastecimentoAgua')->find_or_create(
                                                                            { tipo_abastecimento_agua => $data->{tipo_abastecimento_agua},
                                                                            })->id_tipo_abastecimento_agua;
}

sub transform_tipo_contrucao_moradia {
    my $data = shift;
    $data->{tipo_contrucao_moradia} = $dbi->resultset('DTipoConstrucaoMoradia')->find_or_create(
                                                                            { tipo_contrucao_moradia => $data->{tipo_contrucao_moradia},
                                                                            })->id_tipo_contrucao_moradia;
}

sub transform_tempo_moradia {
    my $data = shift;
    $data->{tempo_moradia} = $dbi->resultset('DTempoMoradia')->find_or_create(
                                                                            { tempo_moradia => $data->{tempo_moradia},
                                                                            })->id_tempo_moradia;
}

sub transform_situacao_moradia {
    my $data = shift;
    $data->{situacao_moradia} = $dbi->resultset('DSituacaoMoradia')->find_or_create(
                                                                            { situacao_moradia => $data->{situacao_moradia},
                                                                            })->id_situacao_moradia;
}

sub transform_vinculo_religioso {
    my $data = shift;
    $data->{vinculo_religioso} = $dbi->resultset('DVinculoReligioso')->find_or_create(
                                                                            { vinculo_religioso => $data->{vinculo_religioso},
                                                                            })->id_vinculo_religioso;
}

sub transform_origem_encaminhamento {
    my $data = shift;
    $data->{origem_encaminhamento} = $dbi->resultset('DOrigemEncaminhamento')->find_or_create(
                                                                            { origem_encaminhamento => $data->{origem_encaminhamento},
                                                                            })->id_origem_encaminhamento;
}

sub transform_vinculacao_cca {
    my $data = shift;
    $data->{vinculacao_cca} = $dbi->resultset('DVinculacaoCca')->find_or_create({ vinculacao_cca => $data->{vinculacao_cca},
                                                                            })->id_vinculacao_cca;
}

sub transform_nucleo {
    my $data = shift;
    $data->{nucleo} = $dbi->resultset('DNucleo')->find_or_create({ nucleo => $data->{nucleo},})->id_nucleo;
}

sub transform_uso_drogas {
    my $data = shift;
    $data->{uso_drogas} = $dbi->resultset('DUsoDrogas')->find_or_create({ uso_drogas => $data->{uso_drogas},})->id_uso_drogas;
}

sub transform_acompanhamento_uso_drogas {
    my $data = shift;
    $data->{acompanhamento_uso_drogas} = $dbi->resultset('DAcompanhamentoUsoDrogas')->find_or_create(
                                                                        { acompanhamento_uso_drogas => $data->{acompanhamento_uso_drogas},
                                                                        })->id_acompanhamento_uso_drogas;
}

sub transform_contraceptivo {
    my $data = shift;
    $data->{contraceptivo} = $dbi->resultset('DContraceptivo')->find_or_create({ contraceptivo => $data->{contraceptivo},})->id_contraceptivo;
}

sub transform_avaliacao_servico_saude {
    my $data = shift;
    $data->{avaliacao_servico_saude} = $dbi->resultset('DAvaliacaoServicoSaude')->find_or_create(
                                                                                      { avaliacao_servico_saude => $data->{avaliacao_servico_saude},
                                                                                      })->id_avaliacao_servico_saude;
}

sub transform_acesso_medicacao {
    my $data = shift;
    $data->{acesso_medicacao} = $dbi->resultset('DAcessoMedicacao')->find_or_create({ acesso_medicacao => $data->{acesso_medicacao},
                                                                                    })->id_acesso_medicacao;
}

sub transform_avaliacao_condicao_saude_familia {
    my $data = shift;
    $data->{avaliacao_condicao_saude_familia} = $dbi->resultset('DAvaliacaoCondicaoSaudeFamilia')->find_or_create(
                                                            { avaliacao_condicao_saude_familia => $data->{avaliacao_condicao_saude_familia},
                                                            })->id_avaliacao_condicao_saude_familia;
}

sub transform_participacao_grupo_social {
    my $data = shift;
    $data->{participacao_grupo_social} = $dbi->resultset('DParticipacaoGrupoSocial')->find_or_create(
                                                                            { participacao_grupo_social => $data->{participacao_grupo_social},
                                                                            })->id_participacao_grupo_social;
}

sub transform_tipo_escola_matriculado {
    my $data = shift;
    $data->{tipo_escola_matriculado} = $dbi->resultset('DTipoEscolaMatriculado')->find_or_create(
                                                                    { tipo_escola_matriculado => $data->{tipo_escola_matriculado},
                                                                    })->id_tipo_escola_matriculado;
}

sub transform_escolaridade {
    my $data = shift;
    $data->{escolaridade} = $dbi->resultset('DEscolaridade')->find_or_create({ escolaridade => $data->{escolaridade},})->id_escolaridade;
}

sub transform_turno_estuda {
    my $data = shift;
    $data->{turno_estuda} = $dbi->resultset('DTurnoEstuda')->find_or_create({ turno_estuda => $data->{turno_estuda},})->id_turno_estuda;
}

sub transform_avaliacao_frequencia_escolar {
    my $data = shift;
    $data->{avaliacao_frequencia_escolar} = $dbi->resultset('DAvaliacaoFrequenciaEscolar')->find_or_create(
                                                                { avaliacao_frequencia_escolar => $data->{avaliacao_frequencia_escolar},
                                                                })->id_avaliacao_frequencia_escolar;
}

sub transform_avaliacao_rendimento_escolar {
    my $data = shift;
    $data->{avaliacao_rendimento_escolar} = $dbi->resultset('DAvaliacaoRendimentoEscolar')->find_or_create(
                                                                { avaliacao_rendimento_escolar => $data->{avaliacao_rendimento_escolar},
                                                                })->id_avaliacao_rendimento_escolar;
}

sub load{
    my ($data) = @_;
     $dbi->resultset('FAtendimento')
      ->create({
              id_endereco => $data->{endereco},
              id_estado_civil => $data->{estado_civil},
              id_raca_etnia => $data->{raca_etnia},
              id_sexo => $data->{sexo},
              id_sexualidade => $data->{sexualidade},
              id_data => $data->{data},
              id_idade => $data->{idade},
              id_endereco => $data->{endereco},
              deficiencia_sensorial_surdo =>$data->{deficiencia_sensorial_surd},
              deficiencia_sensorial_cego =>$data->{deficiencia_sensorial_cego},
              deficiencia_fisico_motor =>$data->{deficiencia_fisico_motor},
              deficiencia_mobilidade_reduzida =>$data->{deficiencia_mobilidade_reduzida},
              deficiencia_intelectual =>$data->{deficiencia_intelectual},
     })
}


extract();
#my $data = $read->('/tmp/bla.xml');

# load();
