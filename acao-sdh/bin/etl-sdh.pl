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
use Switch;

use aliased 'Acao::Plugins::SDH::DimSchema';

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');

$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

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
use constant SCHEMA_EVOLUCAO                       => catfile(HOME_SCHEMAS, 'sdh-evolucao.xsd');
use constant SCHEMA_SAUDESUBSTANCIAPSICOATIVA      => catfile(HOME_SCHEMAS, 'sdh-saudeSubstanciaPsicoativas.xsd');
use constant SCHEMA_DOCUMENTACAOFAMILIAR           => catfile(HOME_SCHEMAS, 'sdh-documentacaoFamiliar.xsd');
use constant SCHEMA_COMPOSICAOFAMILIAR             => catfile(HOME_SCHEMAS, 'sdh-composicaoFamiliar.xsd');

use constant DOSSIE_NS    => 'http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd';
use constant DOCUMENTO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/documento.xsd';
use constant AUDITORIA_NS => 'http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd';

my $schema_form = {
               'formAtendimentoEspecificoSEGARANTA' => XML::Compile::Schema->new(SCHEMA_ATENDIMENTOESPECIFICOSEGARANTA),
               'formCondicoesDeMoradia'             => XML::Compile::Schema->new(SCHEMA_CONDICOESDEMORADIA),
               'formConvivenciaFamiliarComunitaria' => XML::Compile::Schema->new(SCHEMA_CONVIVENCIAFAMILIARCOMUNITARIA),
               'formConvivenciaSocial'              => XML::Compile::Schema->new(SCHEMA_CONVIVENCIASOCIAL),
               'formDirecionamentoDoAtendimento'    => XML::Compile::Schema->new(SCHEMA_DIRECIONAMENTODOATENDIMENTO),
               'formDocumentacao'                   => XML::Compile::Schema->new(SCHEMA_DOCUMENTACAO),
               'formEducacao'                       => XML::Compile::Schema->new(SCHEMA_EDUCACAO),
               'formIdentificacaoPessoal'           => XML::Compile::Schema->new(SCHEMA_IDENTIFICACAOPESSOAL),
               'formJuridico'                       => XML::Compile::Schema->new(SCHEMA_JURIDICO),
               'formOrigemEncaminhamento'           => XML::Compile::Schema->new(SCHEMA_ORIGEMENCAMINHAMENTO),
               'formPedagogia'                      => XML::Compile::Schema->new(SCHEMA_PEDAGOGIA),
               'formPlanoIndividualDeAtendimento'   => XML::Compile::Schema->new(SCHEMA_PLANOINDIVIDUALDEATENDIMENTO),
               'formProfissionalizacaoHabilidades'  => XML::Compile::Schema->new(SCHEMA_PROFISSIONALIZACAOHABILIDADES),
               'formPsicologia'                     => XML::Compile::Schema->new(SCHEMA_PSICOLOGIA),
               'formRelatoriosEncaminhados'         => XML::Compile::Schema->new(SCHEMA_RELATORIOSENCAMINHADOS),
               'formSaude'                          => XML::Compile::Schema->new(SCHEMA_SAUDE),
               'formServicoSocial'                  => XML::Compile::Schema->new(SCHEMA_SERVICOSOCIAL),
               'formVinculacaoNaCCA'                => XML::Compile::Schema->new(SCHEMA_VINCULACAONACCA),
               'formVinculoReligioso'               => XML::Compile::Schema->new(SCHEMA_VINCULORELIGIOSO),
               'formVisitaDomiciliar'               => XML::Compile::Schema->new(SCHEMA_VISITADOMICILIAR),
               'formProtecaoEspecial'               => XML::Compile::Schema->new(SCHEMA_PROTECAOESPECIAL),
               'formIndividualFamilia'              => XML::Compile::Schema->new(SCHEMA_INDIVIDUALFAMILIA),
               'formEvolucao'                       => XML::Compile::Schema->new(SCHEMA_EVOLUCAO),
               'formSaudeSubstanciaPsicoativa'      => XML::Compile::Schema->new(SCHEMA_SAUDESUBSTANCIAPSICOATIVA),
               'formDocumentacaoFamiliar'           => XML::Compile::Schema->new(SCHEMA_DOCUMENTACAOFAMILIAR),
               'formComposicaoFamiliar'             => XML::Compile::Schema->new(SCHEMA_COMPOSICAOFAMILIAR),

                  };

my $schema = XML::Compile::Schema->new([SCHEMA_DOCUMENTO, SCHEMA_AUDITORIA]);
my $read = $schema->compile(READER => pack_type(DOCUMENTO_NS, 'documento'),  any_element => 'TAKE_ALL');

sub extract {

 #   my ($id_volume) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    for $x in collection("volume-2633497e-7395-411b-9587-a9ec8da00c05")/dos:dossie[dos:controle="017c57c9-37e9-4365-8907-1a8feefe9974"]
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
       my $data_doc = $read_doc->($data->{documento}[0]{conteudo}{pack_type(substr($namespace[0],1) ,  $namespace[1])}[0]);

       push @result, { $namespace[1] => $data_doc};
if($namespace[1] eq 'formCondicoesDeMoradia')
{
warn Dumper($data_doc);
}

       $nr++;

  }
# %{$result_hash}  = (%{$result[0]} , %{$result[1]} ,%{$result[2]});
#warn $result_hash->{formDocumentacao0}{registroDeNascimentoNumero};
    $sedna->commit;

   transform(@result);
}

sub transform {
    my (@data) = @_;
  #  transform_endereco($data->{formIdentificacaoPessoal}{endereco});

    for (my $i=0; $i < scalar(@data); $i++){
        my @array = keys(%{$data[$i]});
        switch ($array[0]) {
            case 'formAtendimentoEspecificoSEGARANTA' { }
            case 'formCondicoesDeMoradia'             {
#                                                        transform_tipo_contrucao_moradia($data[$i]->{formCondicoesDeMoradia});
#                                                        transform_tipo_abastecimento_agua($data[$i]->{formCondicoesDeMoradia});
#                                                        transform_tratamento_agua($data[$i]->{formCondicoesDeMoradia});
#                                                        transform_escoamento_sanitario($data[$i]->{formCondicoesDeMoradia});
#                                                        transform_destino_lixo($data[$i]->{formCondicoesDeMoradia});
                                                        transform_situacao_moradia($data[$i]->{formCondicoesDeMoradia});
                                                        transform_tipo_iluminacao($data[$i]->{formCondicoesDeMoradia}); 
                                                        transform_tempo_moradia($data[$i]->{formCondicoesDeMoradia});
                                                        transform_possui_banheiro($data[$i]->{formCondicoesDeMoradia});
                                                      }
            case 'formConvivenciaFamiliarComunitaria' {}
            case 'formConvivenciaSocial'              {}
            case 'formDirecionamentoDoAtendimento'    {}
            case 'formDocumentacao'                   { 
                                                        transform_registro_nascimento($data[$i]->{formDocumentacao});
                                                        transform_identidade($data[$i]->{formDocumentacao});
                                                        transform_cpf($data[$i]->{formDocumentacao});
                                                        transform_ctps($data[$i]->{formDocumentacao});
                                                        transform_titulo_eleitor($data[$i]->{formDocumentacao});
                                                        transform_reservista($data[$i]->{formDocumentacao});
                                                        transform_nis($data[$i]->{formDocumentacao});

                                                      }
            case 'formEducacao'                       {}
            case 'formIdentificacaoPessoal'           { 
                                                        transform_estado_civil($data[$i]->{formIdentificacaoPessoal}); 
                                                        transform_sexo($data[$i]->{formIdentificacaoPessoal});
                                                        transform_endereco($data[$i]->{formIdentificacaoPessoal});
                                                        transform_sexualidade($data[$i]->{formIdentificacaoPessoal});
                                                        transform_data_nascimento($data[$i]->{formIdentificacaoPessoal});
                                                       }
            case 'formJuridico'                       {}
            case 'formOrigemEncaminhamento'           {}
            case 'formPedagogia'                      {}
            case 'formPlanoIndividualDeAtendimento'   {}
            case 'formProfissionalizacaoHabilidades'  {}
            case 'formPsicologia'                     {}
            case 'formRelatoriosEncaminhados'         {}
            case 'formSaude'                          {}
            case 'formServicoSocial'                  {}
            case 'formVinculacaoNaCCA'                {}
            case 'formVinculoReligioso'               {}
            case 'formVisitaDomiciliar'               {}
            case 'formProtecaoEspecial'               {}
            case 'formIndividualFamilia'              { }
            case 'formEvolucao'                       {}
            case 'formSaudeSubstanciaPsicoativa'      {}
            case 'formDocumentacaoFamiliar'           {}
            case 'formComposicaoFamiliar'             {}
        }
    }


}

sub transform_endereco {
    my $data = shift;
    $data->{filiacao}{endereco} = $dbi->resultset('DEndereco')->find_or_create({ endereco => $data->{filiacao}{endereco},
                                                                       bairro => $data->{filiacao}{bairro},
                                                                     })->id_endereco;
}

sub transform_estado_civil {
    my $data = shift;
    my $value = 'Não Informado';
    if ($data->{aPartirDe16Anos}{estadoCivil}){
        $value = $data->{aPartirDe16Anos}{estadoCivil};
    }
    $data->{aPartirDe16Anos}{estadoCivil} = $dbi->resultset('DEstadoCivil')->find_or_create({ estado_civil =>  $value, })->id_estado_civil;
}

sub transform_raca_etnia {
    my $data = shift;
    my $value = 'Não Informado';
    if ($data->{raca_etnia}){
        $value = $data->{raca_etnia};
    }
    $data->{raca_etnia} = $dbi->resultset('DRacaEtinia')->find_or_create({ raca_etnia => $value, })->id_estado_civil;
}

sub transform_sexo {
    my $data = shift;
    my $value = 'Não Informado';
    if ($data->{sexo}){
        $value = $data->{sexo};
    }
    $data->{sexo} = $dbi->resultset('DSexo')->find_or_create({ sexo => $value, })->id_sexo;
}

sub transform_sexualidade {
    my $data = shift;
    my $value = 'Não Informado';
    if ($data->{aPartirDe14Anos}{orientacaoSexual}){
        $value = $data->{aPartirDe14Anos}{orientacaoSexual};
    }
    $data->{aPartirDe14Anos}{orientacaoSexual} = 
                            $dbi->resultset('DSexualidade')->find_or_create({ sexualidade => $value, })->id_sexualidade;
}

sub transform_registro_nascimento {
    my $data = shift;
    my $value = 'Não Informado';
    if ($data->{registroDeNascimento}){
        $value = $data->{registroDeNascimento};
    }
    $data->{registro_nascimento} = $dbi->resultset('DRegistroNascimento')->find_or_create({ situacao => $value, })->id_registro_nascimento;
}

sub transform_identidade {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{identidade}){
        $value = $data->{identidade};
    }
    $data->{identidade} = $dbi->resultset('DIdentidade')->find_or_create({ situacao => $value, })->id_identidade;
}

sub transform_cpf {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{cpf}){
        $value = $data->{cpf};
    }
    $data->{cpf} = $dbi->resultset('DCpf')->find_or_create({ situacao => $value, })->id_cpf;
}

sub transform_ctps {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{ctps}){
        $value = $data->{ctps};
    }
    $data->{ctps} = $dbi->resultset('DCtp')->find_or_create({ situacao => $value, })->id_ctps;
}

sub transform_titulo_eleitor {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{titulo_eleitor}){
        $value = $data->{titulo_eleitor};
    }
    $data->{titulo_eleitor} = $dbi->resultset('DTituloEleitor')->find_or_create({ situacao =>$value, })->id_titulo_eleitor;
}

sub transform_reservista {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{reservista}){
        $value = $data->{reservista};
    }
    $data->{reservista} = $dbi->resultset('DReservista')->find_or_create({ situacao => $value, })->id_reservista;
}

sub transform_nis {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{nis}){
        $value = $data->{nis};
    }
    $data->{nis} = $dbi->resultset('DNi')->find_or_create({ situacao => $value, })->id_nis;
}

sub transform_data_nascimento {
    my $data = shift;
    my $dt = DateTime::Format::XSD->parse_datetime( $data->{dataNascimento} );
    my $dt_int =  $data->{dataNascimento};
    $dt_int=~s/[\-]//gis;
    $data->{data} = $dbi->resultset('DData')->find_or_create({ id_data => $dt_int,
                                                               data => $data->{dataNascimento},
                                                               dia  => $dt->day,
                                                               mes  => $dt->month,
                                                               ano  => $dt->year,
                                                               bimestre => int(($dt->month-1)/2)+1,
                                                               trimestre => int(($dt->month-1)/3)+1,
                                                               semestre => $dt->month < 6 ? 1 : 2,
                                                               dia_semana => $dt->day_of_week,
                                                              })->id_data;
}

sub transform_tipo_iluminacao {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{tipoIluminacao}){
        $value = $data->{tipoIluminacao};
    }
    $data->{tipoIluminacao} = $dbi->resultset('DTipoIluminacao')->find_or_create({ tipo_iluminacao => $value, })->id_tipo_iluminacao;
}


#sub transform_destino_lixo {
#    my $data = shift;
#    my $value =  'Não informado';
#    if($data->{destinoLixo}){
#        $value = $data->{destinoLixo};
#    }
#    $data->{destinoLixo} = $dbi->resultset('DDestinoLixo')->find_or_create({ destino_lixo => $value, })->id_destino_lixo;
#}

#sub transform_escoamento_sanitario{
#    my $data = shift;
#    my $value =  'Não informado';
#    if($data->{escoamentoSanitario}){
#        $value = $data->{escoamentoSanitario};
#    }
#    $data->{escoamentoSanitario} = $dbi->resultset('DEscoamentoSanitario')->find_or_create({ escoamento_sanitario => $value,
#                                                                            })->id_escoamento_sanitario;
#}

#sub transform_tratamento_agua {
#    my $data = shift;
#    my $value =  'Não informado';
#    if($data->{tratamentoAgua}){
#        $value = $data->{tratamentoAgua};
#    }
#    $data->{tratamentoAgua} = $dbi->resultset('DTratamentoAgua')->find_or_create({ tratamento_agua => $value, })->id_tratamento_agua;
#}

#sub transform_tipo_abastecimento_agua {
#    my $data = shift;
#    my $value =  'Não informado';
#    if($data->{tipoAbastecimentoAgua}){
#        $value = $data->{tipoAbastecimentoAgua};
#    }
#    $data->{tipoAbastecimentoAgua} = $dbi->resultset('DTipoAbastecimentoAgua')->find_or_create( { tipo_abastecimento_agua => $value,
#                                                                                                   })->id_tipo_abastecimento_agua;
#}

#sub transform_tipo_contrucao_moradia {
#    my $data = shift;
#    my $value =  'Não informado';
#    if($data->{tiposConstrucao}){
#        $value = $data->{tiposConstrucao};
#    }
#    $data->{tiposConstrucao} = $dbi->resultset('DTipoConstrucaoMoradia')->find_or_create( { tipo_contrucao_moradia => $value,
#                                                                                                 })->id_tipo_contrucao_moradia;
#}

sub transform_tempo_moradia {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{tempoMoradia}){
        $value = $data->{tempoMoradia};
    }
    $data->{tempoMoradia} = $dbi->resultset('DTempoMoradia')->find_or_create( { tempo_moradia => $value, })->id_tempo_moradia;
}

sub transform_situacao_moradia {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{situacaoMoradia}){
        $value = $data->{situacaoMoradia};
    }
    $data->{situacaoMoradia} = $dbi->resultset('DSituacaoMoradia')->find_or_create( { situacao_moradia => $value, })->id_situacao_moradia;
}

sub transform_possui_banheiro{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{possuiBanheiro}){
        $value = $data->{possuiBanheiro};
    }
    $data->{possuiBanheiro} = $dbi->resultset('DPossuiBanheiro')->find_or_create( { situacao_moradia => $value,})->id_possui_banheiro;
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
            deficiencia_sensorial_surdo => $data->{deficiencia_sensorial_surd},
            deficiencia_sensorial_cego => $data->{deficiencia_sensorial_cego},
            deficiencia_fisico_motor => $data->{deficiencia_fisico_motor},
            deficiencia_mobilidade_reduzida => $data->{deficiencia_mobilidade_reduzida},
            deficiencia_intelectual => $data->{deficiencia_intelectual},
            id_registro_nascimento => $data->{id_registro_nascimento},
            data_nascimento => $data->{data_nascimento},
            id_identidade => $data->{id_identidade},
            id_cpf => $data->{id_cpf},
            id_ctps => $data->{id_ctps},
            id_titulo_eleitor => $data->{id_titulo_eleitor},
            id_reservista => $data->{id_reservista},
            id_nis => $data->{id_nis},
            ja_estagiou => $data->{ja_estagiou},
            ja_trabalhou_formalmente => $data->{ja_trabalhou_formalmente},
            ja_trabalhou_informalmente => $data->{ja_trabalhou_informalmente},
            esta_trabalhando_formalmente => $data->{esta_trabalhando_formalmente},
            esta_trabalhando_informalmente => $data->{esta_trabalhando_informalmente},
            id_nocoes_informatica => $data->{id_nocoes_informatica},
            fez_curso_profissionalizante => $data->{fez_curso_profissionalizante},
            tem_interesse_curso_profissionalizante => $data->{tem_interesse_curso_profissionalizante},
            habilidade_desenho => $data->{habilidade_desenho},
            habilidade_artesanato => $data->{habilidade_artesanato},
            habilidade_grafite => $data->{habilidade_grafite},
            habilidade_costura => $data->{habilidade_costura},
            habilidade_musica => $data->{habilidade_musica},
            habilidade_literatura => $data->{habilidade_literatura},
            habilidade_teatro => $data->{habilidade_teatro},
            habilidade_culinaria => $data->{habilidade_culinaria},
            habilidade_danca => $data->{habilidade_danca},
            habilidade_pintura => $data->{habilidade_pintura},
            id_vinculo_religioso => $data->{id_vinculo_religioso},
            situacao_moradia => $data->{situacao_moradia},
            id_tempo_moradia => $data->{id_tempo_moradia},
            possui_banheiro => $data->{possui_banheiro},
            id_tipo_abastecimento_agua => $data->{id_tipo_abastecimento_agua},
            id_tratamento_agua => $data->{id_tratamento_agua},
            id_tipo_iluminacao => $data->{id_tipo_iluminacao},
            id_escoamento_sanitario => $data->{id_escoamento_sanitario},
            id_destino_lixo => $data->{id_destino_lixo},
            id_tipo_construcao_moradia => $data->{id_tipo_construcao_moradia},
            id_origem_encaminhamento => $data->{id_origem_encaminhamento},
            id_vinculacao_cca => $data->{id_vinculacao_cca},
            id_nucleo => $data->{id_nucleo},
            id_status_vinculacao => $data->{id_status_vinculacao},
            id_violencia_intrafamiliar => $data->{id_violencia_intrafamiliar},
            violencia_intrafamiliar_discurssao_verbal => $data->{violencia_intrafamiliar_discurssao_verbal},
            violencia_intrafamiliar_agressao_fisica => $data->{violencia_intrafamiliar_agressao_fisica},
            violencia_intrafamiliar_domestica => $data->{violencia_intrafamiliar_domestica},
            violencia_intrafamiliar_abuso_sexual => $data->{violencia_intrafamiliar_abuso_sexual},
            violencia_intrafamiliar_exploracao_sexual => $data->{violencia_intrafamiliar_exploracao_sexual},
            violencia_intrafamiliar_agressao_psicologica => $data->{violencia_intrafamiliar_agressao_psicologica},
            violencia_intrafamiliar_ameaca_morte => $data->{violencia_intrafamiliar_ameaca_morte},
            id_providencia_contra_violencia_intrafamiliar => $data->{id_providencia_contra_violencia_intrafamiliar},
            id_violencia_institucional => $data->{id_violencia_institucional},
            violencia_instituicao_policial => $data->{violencia_instituicao_policial},
            violencia_instituicao_guarda_municipal => $data->{violencia_instituicao_guarda_municipal},
            violencia_instituicao_escola => $data->{violencia_instituicao_escola},
            violencia_instituicao_posto_saude => $data->{violencia_instituicao_posto_saude},
            violencia_institucional_discurssao_verbal => $data->{violencia_institucional_discurssao_verbal},
            violencia_institucional_agressao_fisica => $data->{violencia_institucional_agressao_fisica},
            violencia_institucional_abuso_sexual => $data->{violencia_institucional_abuso_sexual},
            violencia_institucional_exploracao_sexual => $data->{violencia_institucional_exploracao_sexual},
            violencia_institucional_agressao_psicologica => $data->{violencia_institucional_agressao_psicologica},
            violencia_institucional_ameassa_morte => $data->{violencia_institucional_ameassa_morte},
            id_providencia_contra_violencia_institucional => $data->{id_providencia_contra_violencia_institucional},
            id_atendimento_contra_violencia_institucional => $data->{id_atendimento_contra_violencia_institucional},
            id_frequencia_violencia_intrafamiliar => $data->{id_frequencia_violencia_intrafamiliar},
            id_frequencia_violencia_institucional => $data->{id_frequencia_violencia_institucional},
            id_violencia_ambiente_comunitario => $data->{id_violencia_ambiente_comunitario},
            violencia_ambito_comunitario_discurssao_verbal => $data->{violencia_ambito_comunitario_discurssao_verbal},
            violencia_ambito_comunitario_agressao_fisica => $data->{violencia_ambito_comunitario_agressao_fisica},
            violencia_ambito_comunitario_abuso_sexual => $data->{violencia_ambito_comunitario_abuso_sexual},
            violencia_ambito_comunitario_exploracao_sexual => $data->{violencia_ambito_comunitario_exploracao_sexual},
            violencia_ambito_comunitario_agressao_psicologica => $data->{violencia_ambito_comunitario_agressao_psicologica},
            violencia_ambito_comunitario_ameaca_morte => $data->{violencia_ambito_comunitario_ameaca_morte},
            id_frequencia_violencia_ambito_comunitario => $data->{id_frequencia_violencia_ambito_comunitario},
            id_providencia_contra_violencia_ambito_comunitario => $data->{id_providencia_contra_violencia_ambito_comunitario},
            exploracao_qualquer_tipo_trabalho_infantil => $data->{exploracao_qualquer_tipo_trabalho_infantil},
            exploracao_trabalho_infantil_domestico => $data->{exploracao_trabalho_infantil_domestico},
            exploracao_trabalho_infantil_catador => $data->{exploracao_trabalho_infantil_catador},
            exploracao_trabalho_infantil_pedinte => $data->{exploracao_trabalho_infantil_pedinte},
            exploracao_trabalho_infantil_malabarista => $data->{exploracao_trabalho_infantil_malabarista},
            exploracao_trabalho_infantil_engraxate => $data->{exploracao_trabalho_infantil_engraxate},
            exploracao_trabalho_infantil_flanelinha => $data->{exploracao_trabalho_infantil_flanelinha},
            exploracao_trabalho_infantil_jornaleiro => $data->{exploracao_trabalho_infantil_jornaleiro},
            exploracao_trabalho_infantil_ajudante_pedreiro => $data->{exploracao_trabalho_infantil_ajudante_pedreiro},
            exploracao_trabalho_infantil_comercio_drogras => $data->{exploracao_trabalho_infantil_comercio_drogras},
            exploracao_trabalho_infantil_pesca => $data->{exploracao_trabalho_infantil_pesca},
            exploracao_trabalho_carvoaria => $data->{exploracao_trabalho_carvoaria},
            inscrito_peti => $data->{inscrito_peti},
            vivencia_rua => $data->{vivencia_rua},
            id_uso_drogas => $data->{id_uso_drogas},
            id_acompanhamento_uso_drogas => $data->{id_acompanhamento_uso_drogas},
            internado_comunidade_teraupeutica_uso_drogas => $data->{internado_comunidade_teraupeutica_uso_drogas},
            deseja_tratamento_uso_drogas => $data->{deseja_tratamento_uso_drogas},
            usa_metodo_contraceptivo => $data->{usa_metodo_contraceptivo},
            usa_contraceptivo_preservativo_masculino => $data->{usa_contraceptivo_preservativo_masculino},
            usa_contraceptivo_preservativo_feminino => $data->{usa_contraceptivo_preservativo_feminino},
            usa_contraceptivo_pilula_anticoncepcional => $data->{usa_contraceptivo_pilula_anticoncepcional},
            usa_contraceptivo_diu => $data->{usa_contraceptivo_diu},
            usa_contraceptivo_tabela => $data->{usa_contraceptivo_tabela},
            usa_contraceptivo_temperatura_basal => $data->{usa_contraceptivo_temperatura_basal},
            usa_contraceptivo_metodo_biliing => $data->{usa_contraceptivo_metodo_biliing},
            usa_contraceptivo_coito_interrompido => $data->{usa_contraceptivo_coito_interrompido},
            id_contraceptivo => $data->{id_contraceptivo},
            frequenta_genecologista => $data->{frequenta_genecologista},
            frequenta_urologista => $data->{frequenta_urologista},
            id_participacao_grupo_social => $data->{id_participacao_grupo_social},
            participacao_grupo_religioso => $data->{participacao_grupo_religioso},
            participacao_movimento_estudantil => $data->{participacao_movimento_estudantil},
            participacao_associacao_bairro => $data->{participacao_associacao_bairro},
            participacao_movimento_politico => $data->{participacao_movimento_politico},
            participacao_grupo_musical => $data->{participacao_grupo_musical},
            participacao_grupo_esportivo => $data->{participacao_grupo_esportivo},
            participacao_grupo_teatro => $data->{participacao_grupo_teatro},
            participacao_grupo_danca => $data->{participacao_grupo_danca},
            participacao_grupo_defesa_meio_ambiente => $data->{participacao_grupo_defesa_meio_ambiente},
            participacao_cooperativa => $data->{participacao_cooperativa},
            participacao_ong => $data->{participacao_ong},
            participacao_grupos_produtivos => $data->{participacao_grupos_produtivos},
            participacao_movimento_cultural => $data->{participacao_movimento_cultural},
            participacao_organizacoes_lgbtt => $data->{participacao_organizacoes_lgbtt},
            participacao_movimento_mulheres => $data->{participacao_movimento_mulheres},
            participacao_movimento_negro => $data->{participacao_movimento_negro},
            participacao_grupo_rpg => $data->{participacao_grupo_rpg},
            participacao_grupos_rivais => $data->{participacao_grupos_rivais},
            participacao_atividade_comunitaria => $data->{participacao_atividade_comunitaria},
            id_tipo_escola_matriculado => $data->{id_tipo_escola_matriculado},
            frequentando_escola => $data->{frequentando_escola},
            escola_matriculado_proximo_residencia => $data->{escola_matriculado_proximo_residencia},
            id_escolaridade => $data->{id_escolaridade},
            id_avaliacao_frequencia_escolar => $data->{id_avaliacao_frequencia_escolar},
            id_avaliacao_preparacao_atividades_escolares => $data->{id_avaliacao_preparacao_atividades_escolares},
            id_avaliacao_rendimento_escolar => $data->{id_avaliacao_rendimento_escolar},
            id_avaliacao_familia_vida_escolar => $data->{id_avaliacao_familia_vida_escolar},
            id_acesso_medicacao => $data->{id_acesso_medicacao},
            id_avaliacao_servico_saude => $data->{id_avaliacao_servico_saude},
            id_avaliacao_condicao_saude_familia => $data->{id_avaliacao_condicao_saude_familia},
            id_atendimento_contra_violencia_intrafamiliar => $data->{id_atendimento_contra_violencia_intrafamiliar},
            id_atendimento_contra_violencia_comunitario => $data->{id_atendimento_contra_violencia_comunitario},
     })
}


extract();
#my $data = $read->('/tmp/bla.xml');

# load();
