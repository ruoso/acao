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
use constant SCHEMA_IDENTIFICACAO_PESSOAL => catfile(HOME_SCHEMAS, 'sdh-identificacaoPessoal.xsd');

use constant SCHEMA_CONSOLIDADO => catfile(HOME_SCHEMAS, 'sdh-consolidado.xsd');
use constant SDH_CONSOLIDADO_NS =>"http://schemas.fortaleza.ce.gov.br/acao/sdh-consolidado.xsd";

my $schema = XML::Compile::Schema->new(SCHEMA_CONSOLIDADO);
my $read = $schema->compile(READER => pack_type(SDH_CONSOLIDADO_NS , 'conteudo'));


sub extract {

 #   my ($id_volume) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    for $x in collection("volume-48F1B8CA-CAFF-11DF-9F68-C6003924FB0B")/dos:dossie[dos:controle="4A982326-CAFF-11DF-9F68-C6003924FB0B"]
                    /dos:doc/dc:documento[dc:invalidacao/text() eq "1970-01-01T00:00:00Z"]/dc:documento/* return $x';

    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);

  while ($sedna->next){
        #atribui os itens retornados da consulta acima na variavel $xsd sob a forma de XML String
        my $xml_string = $sedna->getItem();
  }
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

# load();
