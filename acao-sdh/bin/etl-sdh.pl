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
use constant SCHEMA_SAUDEFAMILIAR                  => catfile(HOME_SCHEMAS, 'sdh-saudeFamiliar.xsd');

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
               'formSaudeFamiliar'                  => XML::Compile::Schema->new(SCHEMA_SAUDEFAMILIAR),
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
if($namespace[1] eq 'formProtecaoEspecial')
{
#warn $xml_string;
}


       my $read_doc = $schema_form->{$namespace[1]}->compile(READER => pack_type( substr($namespace[0],1) , $namespace[1] ));
       my $data_doc = $read_doc->($data->{documento}[0]{conteudo}{pack_type(substr($namespace[0],1) ,  $namespace[1])}[0]);

       push @result, { $namespace[1] => $data_doc};
if($namespace[1] eq 'formSaude')
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
            case 'formAtendimentoEspecificoSEGARANTA' {}
            case 'formCondicoesDeMoradia'             {
                                                        transform_situacao_moradia($data[$i]->{formCondicoesDeMoradia});
                                                        transform_tipo_iluminacao($data[$i]->{formCondicoesDeMoradia}); 
                                                        transform_tempo_moradia($data[$i]->{formCondicoesDeMoradia});
                                                        transform_possui_banheiro($data[$i]->{formCondicoesDeMoradia});
                                                      }
            case 'formConvivenciaFamiliarComunitaria' {}
            case 'formConvivenciaSocial'              {
                                                        transform_participacao_grupo_social($data[$i]->{formConvivenciaSocial});
                                                       }
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
            case 'formEducacao'                       {
                                                       transform_tipo_escola_matriculado($data[$i]->{formEducacao}); 
                                                       transform_esta_frequentando_escola($data[$i]->{formEducacao}); 
                                                       transform_turno_estuda($data[$i]->{formEducacao});
                                                       transform_escolaridade($data[$i]->{formEducacao});
                                                       transform_criancas_familia_todas_matriculadas($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_rendimento_escolar($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_participacao_atividade_escolar($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_participacao_familia_escola($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_frequencia_escolar($data[$i]->{formEducacao});
                                                       }
            case 'formIdentificacaoPessoal'           { 
                                                        transform_estado_civil($data[$i]->{formIdentificacaoPessoal}); 
                                                        transform_sexo($data[$i]->{formIdentificacaoPessoal});
                                                        transform_endereco($data[$i]->{formIdentificacaoPessoal});
                                                        transform_sexualidade($data[$i]->{formIdentificacaoPessoal});
                                                        transform_data_nascimento($data[$i]->{formIdentificacaoPessoal});
                                                        transform_nucleo($data[$i]->{formIdentificacaoPessoal});
                                                      }
            case 'formJuridico'                       {}
            case 'formOrigemEncaminhamento'           {}
            case 'formPedagogia'                      {}
            case 'formPlanoIndividualDeAtendimento'   {}
            case 'formProfissionalizacaoHabilidades'  {
                                                        transform_ja_estagiou($data[$i]->{formProfissionalizacaoHabilidades});
                                                        transform_esta_trabalhando($data[$i]->{formProfissionalizacaoHabilidades});
                                                        transform_ja_trabalhou($data[$i]->{formProfissionalizacaoHabilidades});
                                                        transform_nocoes_informatica($data[$i]->{formProfissionalizacaoHabilidades});
                                                        transform_fez_curso_profissionalizante($data[$i]->{formProfissionalizacaoHabilidades});
                                                        transform_interesse_curso_profissionalizante($data[$i]->{formProfissionalizacaoHabilidades});
                                                       }
            case 'formPsicologia'                     {}
            case 'formRelatoriosEncaminhados'         {}
            case 'formSaude'                          {
                                                       transform_frequenta_ginecologista_regularmente($data[$i]->{formSaude});
                                                       transform_frequenta_urologista_regularmente($data[$i]->{formSaude});
                                                       transform_avaliacao_condicao_saude_familia($data[$i]->{formSaude});
                                                       transform_avaliacao_servico_saude($data[$i]->{formSaude});
                                                       transform_avaliacao_acesso_medicacao($data[$i]->{formSaude});
                                                       }
            case 'formServicoSocial'                  {}
            case 'formVinculacaoNaCCA'                {
                                                       transform_status_vinculacao_cca($data[$i]->{formVinculoReligioso});
                                                       }
            case 'formVinculoReligioso'               {
                                                        transform_vinculo_religioso($data[$i]->{formVinculoReligioso});
                                                       }
            case 'formVisitaDomiciliar'               {}
            case 'formProtecaoEspecial'               {
                                                        transform_frequencia_violencia_intra_familiar($data[$i]->{formProtecaoEspecial});
                                                        transform_sofre_violencia_intra_familiar($data[$i]->{formProtecaoEspecial});
                                                        transform_sofreu_violencia_intra_familiar($data[$i]->{formProtecaoEspecial});
                                                        transform_frequencia_violencia_comunitaria($data[$i]->{formProtecaoEspecial});
                                                        transform_sofre_violencia_comunitaria($data[$i]->{formProtecaoEspecial});
                                                        transform_sofreu_violencia_comunitaria($data[$i]->{formProtecaoEspecial});
                                                        transform_frequencia_violencia_institucional($data[$i]->{formProtecaoEspecial});
                                                        transform_sofre_violencia_institucional($data[$i]->{formProtecaoEspecial});
                                                        transform_sofreu_violencia_institucional($data[$i]->{formProtecaoEspecial});
                                                      }
            case 'formIndividualFamilia'              {}
            case 'formEvolucao'                       {}
            case 'formSaudeSubstanciaPsicoativa'      {
                                                        transform_uso_drogas($data[$i]->{formSaudeSubstanciaPsicoativa});
                                                       }
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
    $data->{possuiBanheiro} = $dbi->resultset('DPossuiBanheiro')->find_or_create( { possui_banheiro => $value,})->id_possui_banheiro;
}

sub transform_nucleo {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{nucleo}){
        $value = $data->{nucleo};
    }
    $data->{nucleo} = $dbi->resultset('DNucleo')->find_or_create({ nucleo => $value,})->id_nucleo;
}



sub transform_participacao_grupo_social {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{participaOuParticipouDeAlgumGrupoSocial}){
        $value = $data->{participaOuParticipouDeAlgumGrupoSocial};
    }
    $data->{participacao_grupo_social} = $dbi->resultset('DParticipacaoGrupoSocial')->find_or_create( { participacao_grupo_social => $value,
                                                                                                       })->id_participacao_grupo_social;
}

sub transform_tipo_escola_matriculado {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{estaMaticuladoEmAlgumaEscola}){
        $value = $data->{estaMaticuladoEmAlgumaEscola};
        $value=~s/Sim. No ensino |\.//gis;
    }
    $data->{tipo_escola_matriculado} = $dbi->resultset('DTipoEscolaMatriculado')->find_or_create( { tipo_escola_matriculado => $value,
                                                                                                  })->id_tipo_escola_matriculado;
}

sub transform_esta_frequentando_escola {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{casoEstejaMatriculadoEstaFrenquentandoEscola}){
        $value = $data->{casoEstejaMatriculadoEstaFrenquentandoEscola};
    }
    $data->{tipo_escola_matriculado} = $dbi->resultset('DEstaFrequentandoEscola')->find_or_create( { esta_frequentando_escola => $value,
                                                                                                  })->id_esta_frequentando_escola;
}

sub transform_escolaridade {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{emCasoAfirmativo}{escolaridade}){
        $value = $data->{emCasoAfirmativo}{escolaridade};
    }
    $data->{emCasoAfirmativo}{escolaridade} = $dbi->resultset('DEscolaridade')->find_or_create({ escolaridade => $value,})->id_escolaridade;
}

sub transform_escola_matriculado_proximo_residencia {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia}){
        $value = $data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia};
    }
    $data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia} = $dbi->resultset('DEscolaMatriculadoProximoResidencia')
                                                            ->find_or_create({ escola_matriculado_proximo_residencia => $value,
                                                                            })->id_escola_matriculado_proximo_residencia;
}

sub transform_criancas_familia_todas_matriculadas {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola}){
        $value = $data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola};
    }
    $data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola} = $dbi->resultset('DCriancasFamiliaTodasMatriculada')
                                                                                ->find_or_create({ criancas_familia_todas_matriculadas => $value,
                                                                                                 })->id_criancas_familia_todas_matriculadas;
}

sub transform_turno_estuda {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{emCasoAfirmativo}{turno}){
        $value = $data->{emCasoAfirmativo}{turno};
    }
    $data->{emCasoAfirmativo}{turno} = $dbi->resultset('DTurnoEstuda')->find_or_create({ turno_estuda => $value,})->id_turno_estuda;
}

sub transform_auto_avaliacao_frequencia_escolar {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar}){
        $value = $data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar};
    }
    $data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar} = $dbi->resultset('DAutoAvaliacaoFrequenciaEscolar')
                                                            ->find_or_create( { auto_avaliacao_frequencia_escolar => $value, 
                                                                })->id_auto_avaliacao_frequencia_escolar;
}

sub transform_auto_avaliacao_rendimento_escolar {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{avaliacaoDaVidaEscolar}{rendimentoEscolar}){
        $value = $data->{avaliacaoDaVidaEscolar}{rendimentoEscolar};
    }
    $data->{avaliacaoDaVidaEscolar}{rendimentoEscolar} = $dbi->resultset('DAutoAvaliacaoRendimentoEscolar')->find_or_create(
                                                                { auto_avaliacao_rendimento_escolar => $value, })->id_auto_avaliacao_rendimento_escolar;
}

sub transform_auto_avaliacao_participacao_atividade_escolar {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares}){
        $value = $data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares};
    }
    $data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares} = $dbi->resultset('DAutoAvaliacaoParticipacaoAtividadeEscolar')
                                                        ->find_or_create({ auto_avaliacao_participacao_atividade_escolar => $value,
                                                                        })->id_auto_avaliacao_participacao_atividade_escolar;
}

sub transform_auto_avaliacao_participacao_familia_escola {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{avaliacaoDaVidaEscolar}{participacaoDaFamiliaNaSuaVidaEscolar}){
        $value = $data->{avaliacaoDaVidaEscolar}{participacaoDaFamiliaNaSuaVidaEscolar};
    }
    $data->{avaliacaoDaVidaEscolar}{participacaoDaFamiliaNaSuaVidaEscolar} = 
                                                            $dbi->resultset('DAutoAvaliacaoParticipacaoFamiliaEscola')
                                                                            ->find_or_create({ auto_avaliacao_participacao_familia_escola => $value, 
                                                                                            })->id_auto_avaliacao_participacao_familia_escola;
}


sub transform_ja_estagiou {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{jaEstagiouAlgumaVez}){
        $value = $data->{jaEstagiouAlgumaVez};
    }
    $data->{jaEstagiouAlgumaVez} = $dbi->resultset('DJaEstagiou')->find_or_create({ ja_estagiou => $value,})->id_ja_estagiou;
}

sub transform_ja_trabalhou {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{jaTrabalhouAlgumaVez}){
        $value = $data->{jaTrabalhouAlgumaVez};
    }
    $data->{jaTrabalhouAlgumaVez} = $dbi->resultset('DJaTrabalhou')->find_or_create({ ja_trabalhou => $value,})->id_ja_trabalhou;
}

sub transform_esta_trabalhando {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{estaTrabalhandoAtualmente}){
        $value = $data->{estaTrabalhandoAtualmente};
    }
    $data->{estaTrabalhandoAtualmente} = $dbi->resultset('DEstaTrabalhando')->find_or_create({ esta_trabalhando => $value,})->id_esta_trabalhando;
}

sub transform_nocoes_informatica {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{nossoesInformatica}){
        $value = $data->{nossoesInformatica};
    }
    $data->{nossoesInformatica} = $dbi->resultset('DNocoesInformatica')->find_or_create({ nocoes_informatica => $value,})->id_nocoes_informatica;
}

sub transform_fez_curso_profissionalizante {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{cursosProficionalizantes}){
        $value = $data->{cursosProficionalizantes};
    }
    $data->{cursosProficionalizantes} = $dbi->resultset('DFezCursoProfissionalizante')->find_or_create({ fez_curso_profissionalizante => $value,
                                                                                                        })->id_fez_curso_profissionalizante;
}

sub transform_interesse_curso_profissionalizante {
    my $data = shift;
    my $value =  'Não informado';
    if($data->{casoNaoTenhacursosProficionalizantes}){
        $value = $data->{casoNaoTenhacursosProficionalizantes};
    }
    $data->{casoNaoTenhacursosProficionalizantes} = $dbi->resultset('DInteresseCursoProfissionalizante')
                                                                ->find_or_create({ interesse_curso_profissionalizante 
                                                                 => $value,})->id_interesse_curso_profissionalizante;
}

sub transform_vinculo_religioso{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{qualSeuVinculoReligiao}){
        $value = $data->{qualSeuVinculoReligiao};
    }
    $data->{qualSeuVinculoReligiao} = $dbi->resultset('DVinculoReligioso')->find_or_create({ vinculo_religioso => $value,})->id_vinculo_religioso;
}

sub transform_status_vinculacao_cca{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{status}){
        $value = $data->{status};
    }
    $data->{status} = $dbi->resultset('DStatusVinculacaoCca')->find_or_create({ status_vinculacao_cca => $value,})->id_status_vinculacao_cca;
}

sub transform_sofre_violencia_intra_familiar{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoIntrafamiliar}{nuncaSofreNenhumTipoDeViolenciaIntrafamiliar} ){
        $value = $data->{violenciaNoAmbitoIntrafamiliar}{nuncaSofreNenhumTipoDeViolenciaIntrafamiliar} == 1 ? 'Nunca Sofreu' : 'Sim Sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoIntrafamiliar}{sofreAlgumTipoDeViolenciaIntrafamiliar}){
             $value = $data->{violenciaNoAmbitoIntrafamiliar}{sofreAlgumTipoDeViolenciaIntrafamiliar};
         }
    }
    $data->{violenciaNoAmbitoIntrafamiliar}{sofreAlgumTipoDeViolenciaIntrafamiliar} = 
                                                                                 $dbi->resultset('DSofreViolenciaIntrafamiliar')
                                                                                    ->find_or_create({sofre_violencia_intrafamiliar => $value,
                                                                                                     })->id_sofre_violencia_intrafamiliar;
}

sub transform_sofreu_violencia_intra_familiar{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoIntrafamiliar}{nuncaSofreNenhumTipoDeViolenciaIntrafamiliar} ){
        $value = $data->{violenciaNoAmbitoIntrafamiliar}{nuncaSofreNenhumTipoDeViolenciaIntrafamiliar} == 1 ? 'Nunca Sofreu' : 'Sim Sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoIntrafamiliar}{sofreuAlgumTipoDeViolenciaIntrafamiliar}){
             $value = $data->{violenciaNoAmbitoIntrafamiliar}{sofreuAlgumTipoDeViolenciaIntrafamiliar};
         }
    }
    $data->{violenciaNoAmbitoIntrafamiliar}{sofreuAlgumTipoDeViolenciaIntrafamiliar} = 
                                                                                 $dbi->resultset('DSofreuViolenciaIntrafamiliar')
                                                                                    ->find_or_create({sofreu_violencia_intrafamiliar => $value,
                                                                                                     })->id_sofreu_violencia_intrafamiliar;
}

sub transform_frequencia_violencia_intra_familiar{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia}{frequentemente} + 
                 $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia}{raramente}      +  
                 $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia}{asVezes};

    if ($value == 0 or $value > 1){
        $value = 'Não informado'; 
    }
    else
    {
        my $hash = ();
        %{$hash} = reverse %{$data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia}};
        $value = $hash->{1};
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia} = 
                                                                                 $dbi->resultset('DFrequenciaViolenciaIntrafamiliar')
                                                                                    ->find_or_create({frequencia_violencia_intrafamiliar => $value,
                                                                                                     })->id_frequencia_violencia_intrafamiliar;
}

sub transform_sofre_violencia_comunitaria{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoComunitario}{nuncaSofreuNenhumTipoDeViolenciaComunitaria} ){
        $value = $data->{violenciaNoAmbitoComunitario}{nuncaSofreuNenhumTipoDeViolenciaComunitaria} == 1 ? 'Nunca Sofreu' : 'Sim Sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoComunitario}{sofreAlgumTipoDeViolenciaComunitaria}){
             $value = $data->{violenciaNoAmbitoComunitario}{sofreAlgumTipoDeViolenciaComunitaria};
         }
    }
    $data->{violenciaNoAmbitoComunitario}{sofreAlgumTipoDeViolenciaComunitaria} = 
                                                                                 $dbi->resultset('DSofreViolenciaAmbienteComunitario')
                                                                                    ->find_or_create({sofre_violencia_ambiente_comunitario => $value,
                                                                                                     })->id_sofre_violencia_ambiente_comunitario;
}

sub transform_sofreu_violencia_comunitaria{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoComunitario}{nuncaSofreuNenhumTipoDeViolenciaComunitaria} ){
        $value = $data->{violenciaNoAmbitoComunitario}{nuncaSofreuNenhumTipoDeViolenciaComunitaria} == 1 ? 'Nunca sofreu' : 'Sim sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoComunitario}{sofreuAlgumTipoDeViolenciaComunitaria}){
             $value = $data->{violenciaNoAmbitoComunitario}{sofreuAlgumTipoDeViolenciaComunitaria};
         }
    }
    $data->{violenciaNoAmbitoComunitario}{sofreuAlgumTipoDeViolenciaComunitaria} = 
                                                                                 $dbi->resultset('DSofreuViolenciaAmbienteComunitario')
                                                                                    ->find_or_create({sofreu_violencia_ambiente_comunitario => $value,
                                                                                                     })->id_sofreu_violencia_ambiente_comunitario;
}

sub transform_frequencia_violencia_comunitaria{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{frequencia}{frequentemente} + 
                 $data->{violenciaNoAmbitoComunitario}{frequencia}{raramente}      +  
                 $data->{violenciaNoAmbitoComunitario}{frequencia}{asVezes};
    if ($value == 1){
        my $hash = ();
        %{$hash} = reverse %{$data->{violenciaNoAmbitoComunitario}{frequencia}};
        $value = $hash->{1};
    }
    else
    {
        $value = 'Não informado'; 
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia} = 
                                                                                 $dbi->resultset('DFrequenciaViolenciaAmbitoComunitario')
                                                                                    ->find_or_create({frequencia_violencia_ambito_comunitario => $value,
                                                                                                     })->id_frequencia_violencia_ambito_comunitario;

}

sub transform_sofre_violencia_institucional{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoInstitucional}{nuncaSofreuNenhumTipoDeViolenciaInstitucional} ){
        $value = $data->{violenciaNoAmbitoInstitucional}{nuncaSofreuNenhumTipoDeViolenciaInstitucional} == 1 ? 'Nunca Sofreu' : 'Sim Sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoInstitucional}{sofreAlgumTipoDeViolenciaInstitucional}){
             $value = $data->{violenciaNoAmbitoInstitucional}{sofreAlgumTipoDeViolenciaInstitucional};
         }
    }
    $data->{violenciaNoAmbitoInstitucional}{sofreAlgumTipoDeViolenciaInstitucional} = 
                                                                                 $dbi->resultset('DSofreViolenciaInstitucional')
                                                                                    ->find_or_create({sofre_violencia_institucional => $value,
                                                                                                     })->id_sofre_violencia_institucional;
}

sub transform_sofreu_violencia_institucional{
    my $data = shift;
    my $value =  'Não informado';
    if($data->{violenciaNoAmbitoInstitucional}{nuncaSofreuNenhumTipoDeViolenciaInstitucional} ){
        $value = $data->{violenciaNoAmbitoInstitucional}{nuncaSofreuNenhumTipoDeViolenciaInstitucional} == 1 ? 'Nunca sofreu' : 'Sim sofreu';
    }
     else {
        if($data->{violenciaNoAmbitoInstitucional}{sofreuAlgumTipoDeViolenciaInstitucional}){
             $value = $data->{violenciaNoAmbitoInstitucional}{sofreuAlgumTipoDeViolenciaInstitucional};
         }
    }
    $data->{violenciaNoAmbitoInstitucional}{sofreuAlgumTipoDeViolenciaInstitucional} = 
                                                                                 $dbi->resultset('DSofreuViolenciaInstitucional')
                                                                                    ->find_or_create({sofreu_violencia_institucional => $value,
                                                                                                     })->id_sofreu_violencia_institucional;
}

sub transform_uso_drogas{
    my $data = shift;
    my $value =  'Não informado';
    my @drogas = ('maconha', 'inalantes', 'cigarro', 'cocaina', 'comprimidos', 'cola', 'mesclado', 'alcool', 'crack');
   if($data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{naoQuisInformar}
                                                                                        {naoQuisInformarUsoSubstanciaPisicoativa} == 0){
   if($data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                        {parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas} ){
        if($data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                    {parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas} eq 'Socioeducando' ){
               for (my $valor=0; $valor < scalar(@drogas); $valor++){
                   $value = $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                            {fezUso}{$drogas[$valor]} +
                            $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                            {jaExperimentou}{$drogas[$valor]} +
                            $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                            {nuncaUsou}{$drogas[$valor]} +
                            $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                            {costumaDeVezEmQuando}{$drogas[$valor]};
                    if($value == 1){
                              $value = $data->{saudeSubstanciaPsicoativa}
                                         {algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                               {fezUso}{$drogas[$valor]} == 1 ? 'fez uso' : $value;
                              $value = $data->{saudeSubstanciaPsicoativa}
                                         {algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                              {jaExperimentou}{$drogas[$valor]} == 1 ? 'Já experimentou' : $value;
                              $value = $data->{saudeSubstanciaPsicoativa}
                                         {algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                              {nuncaUsou}{$drogas[$valor]} == 1 ? 'Nunca usou' : $value;
                              $value = $data->{saudeSubstanciaPsicoativa}
                                         {algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                 {costumaDeVezEmQuando}{$drogas[$valor]} == 1 ? 'Costuma de vez em quando' : $value;
                               $value = $data->{saudeSubstanciaPsicoativa}
                                         {algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                 {costumeFrequentemente}{$drogas[$valor]} == 1 ? 'Costuma frequentemente' : $value;
                              $drogas[$valor] = $value;
                    } else{ $drogas[$valor] = 'Não Informado'; }
               }         
        }
        else{
          foreach my $item (@drogas){
            $item = 'Não Informado'; 
          }
        }
    }
    else{
      foreach my $item (@drogas){
        $item = 'Não Informado'; 
      }
    }
    }
    else{
    foreach my $item (@drogas){
        $item = 'Não quis informar'; 
      }
    }

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{maconha} = 
                                                                                 $dbi->resultset('DUsaMaconha')
                                                                                    ->find_or_create({usa_maconha => $drogas[0],
                                                                                                     })->id_usa_maconha;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{inalantes} = 
                                                                                 $dbi->resultset('DUsaInalante')
                                                                                    ->find_or_create({usa_inalantes => $drogas[1],
                                                                                                     })->id_usa_inalantes;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cigarro} = 
                                                                                 $dbi->resultset('DUsaCigarro')
                                                                                    ->find_or_create({usa_cigarro => $drogas[2],
                                                                                                     })->id_usa_cigarro;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cocaina} = 
                                                                                 $dbi->resultset('DUsaCocaina')
                                                                                    ->find_or_create({usa_cocaina => $drogas[3],
                                                                                                     })->id_usa_cocaina;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{comprimidos} = 
                                                                                 $dbi->resultset('DUsaComprimido')
                                                                                    ->find_or_create({usa_comprimidos => $drogas[4],
                                                                                                     })->id_usa_comprimidos;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cola} = 
                                                                                 $dbi->resultset('DUsaCola')
                                                                                    ->find_or_create({usa_cola => $drogas[5],
                                                                                                     })->id_usa_cola;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{mesclado} = 
                                                                                 $dbi->resultset('DUsaMesclado')
                                                                                    ->find_or_create({usa_mesclado => $drogas[6],
                                                                                                     })->id_usa_mesclado;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{alcool} = 
                                                                                 $dbi->resultset('DUsaAlcool')
                                                                                    ->find_or_create({usa_alcool => $drogas[7],
                                                                                                     })->id_usa_alcool;

    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{crack} = 
                                                                                 $dbi->resultset('DUsaCrack')
                                                                                    ->find_or_create({usa_crack => $drogas[8],
                                                                                                     })->id_usa_crack;
}

sub transform_frequenta_ginecologista_regularmente{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente}){
        $value = $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente};
    }
   $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente} = $dbi->resultset('DFrequentaGinecologistaRegularmente')
                                                                ->find_or_create({frequenta_ginecologista_regularmente 
                                                                 => $value,})->id_frequenta_ginecologista_regularmente;
}

sub transform_frequenta_urologista_regularmente{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{saude}{aPartirDe12Anos}{frequentaUrologistaRegularmente}){
        $value = $data->{saude}{aPartirDe12Anos}{frequentaUrologistaRegularmente};
    }
   $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente} = $dbi->resultset('DFrequentaUrologistaRegularmente')
                                                                ->find_or_create({frequenta_urologista_regularmente 
                                                                 => $value,})->id_frequenta_urologista_regularmente;
}

sub transform_avaliacao_acesso_medicacao{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao} = $dbi->resultset('DAvaliacaoAcessoMedicacao')
                                                                ->find_or_create({avaliacao_acesso_medicacao 
                                                                 => $value,})->id_avaliacao_acesso_medicacao;
}

sub transform_avaliacao_servico_saude{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude} = $dbi->resultset('DAvaliacaoServicoSaude')
                                                                ->find_or_create({avaliacao_servico_saude 
                                                                 => $value,})->id_avaliacao_servico_saude;
}

sub transform_avaliacao_condicao_saude_familia{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia} = $dbi->resultset('DAvaliacaoCondicaoSaudeFamilia')
                                                                ->find_or_create({avaliacao_condicao_saude_familia 
                                                                 => $value,})->id_avaliacao_condicao_saude_familia;
}

sub transform_idade{
    my $data  = shift;
    my $value = 'Não informado';
    if($data->{idade}){
        $value = $data->{idade};
    }
    $data->{idade} = $dbi->resultset('DIdade')->find_or_create({idade => $value,})->id_idade;
}




sub load{
    my ($data) = @_;
     $dbi->resultset('FAtendimento')
      ->create({
              id_sexo => $data->{sexo};
              id_sexualidade => $data->{aPartirDe14Anos}{orientacaoSexual};
              id_data =>  $data->{data};
              id_idade => $data->{idade};
              id_endereco => $data->{endereco};
              id_raca_etnia => $data->{raca_etnia}
              id_estado_civil => $data->{estado_civil}
              deficiencia_sensorial_surdo => $data->{deficiencia_sensorial_surd},
              deficiencia_sensorial_cego => $data->{deficiencia_sensorial_cego},
              deficiencia_fisico_motor => $data->{deficiencia_fisico_motor},
              deficiencia_mobilidade_reduzida => $data->{deficiencia_mobilidade_reduzida},
              deficiencia_intelectual => $data->{deficiencia_intelectual},
              id_registro_nascimento => $data->{id_registro_nascimento},
              id_identidade => $data->{id_identidade},
              id_cpf => $data->{id_cpf},
              id_ctps => $data->{id_ctps},
              id_titulo_eleitor => $data->{id_titulo_eleitor},
              id_reservista => $data->{id_reservista},
              id_nis => $data->{id_nis},
              id_nocoes_informatica => $data->{id_nocoes_informatica},
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
              id_vinculo_religioso => $data->{qualSeuVinculoReligiao},
              situacao_moradia =>  $data->{situacaoMoradia},
              id_tempo_moradia => $data->{tempoMoradia},
              possui_banheiro =>  $data->{possuiBanheiro},
              id_tipo_iluminacao =>  $data->{tipoIluminacao},
              id_nucleo =>  $data->{nucleo},
              id_status_vinculacao_cca => $data->{status},
              id_sofre_violencia_intrafamiliar => $data->{violenciaNoAmbitoIntrafamiliar}{sofreAlgumTipoDeViolenciaIntrafamiliar},
              id_sofreu_violencia_intrafamiliar => $data->{violenciaNoAmbitoIntrafamiliar}{sofreuAlgumTipoDeViolenciaIntrafamiliar},
              violencia_intrafamiliar_discussao_verbal =>
              violencia_intrafamiliar_agressao_fisica =>
              violencia_intrafamiliar_domestica =>
              violencia_intrafamiliar_abuso_sexual =>
              violencia_intrafamiliar_exploracao_sexual =>
              violencia_intrafamiliar_agressao_psicologica =>
              violencia_intrafamiliar_ameaca_morte =>
              id_sofre_violencia_institucional => $data->{violenciaNoAmbitoInstitucional}{sofreAlgumTipoDeViolenciaInstitucional},
              sofre_violencia_instituicao_policial =>
              sofre_violencia_instituicao_guarda_municipal =>
              sofre_violencia_instituicao_escola =>
              sofre_violencia_instituicao_posto_saude =>
              sofre_violencia_institucional_discussao_verbal =>
              sofre_violencia_institucional_agressao_fisica =>
              sofre_violencia_institucional_abuso_sexual =>
              sofre_violencia_institucional_exploracao_sexual =>
              sofre_violencia_institucional_agressao_psicologica =>
              sofre_violencia_institucional_ameassa_morte =>
              sofreu_violencia_instituicao_policial =>
              sofreu_violencia_instituicao_guarda_municipal =>
              sofreu_violencia_instituicao_escola =>
              sofreu_violencia_instituicao_posto_saude =>
              sofreu_violencia_institucional_discussao_verbal =>
              sofreu_violencia_institucional_agressao_fisica =>
              sofreu_violencia_institucional_abuso_sexual =>
              sofreu_violencia_institucional_exploracao_sexual =>
              sofreu_violencia_institucional_agressao_psicologica =>
              sofreu_violencia_institucional_ameassa_morte =>
              id_frequencia_violencia_intrafamiliar => $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia},
    #          id_frequencia_violencia_institucional => falta resolver
              violencia_ambito_comunitario_discussao_verbal =>
              violencia_ambito_comunitario_agressao_fisica =>
              violencia_ambito_comunitario_abuso_sexual =>
              violencia_ambito_comunitario_exploracao_sexual =>
              violencia_ambito_comunitario_agressao_psicologica =>
              violencia_ambito_comunitario_ameaca_morte =>
              id_frequencia_violencia_ambito_comunitario => $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequencia},
              exploracao_qualquer_tipo_trabalho_infantil =>
              exploracao_trabalho_infantil_domestico =>
              exploracao_trabalho_infantil_catador =>
              exploracao_trabalho_infantil_pedinte =>
              exploracao_trabalho_infantil_malabarista =>
              exploracao_trabalho_infantil_engraxate =>
              exploracao_trabalho_infantil_flanelinha =>
              exploracao_trabalho_infantil_jornaleiro =>
              exploracao_trabalho_infantil_ajudante_pedreiro =>
              exploracao_trabalho_infantil_comercio_drogas =>
              exploracao_trabalho_infantil_pesca =>
              exploracao_trabalho_carvoaria =>
              inscrito_peti =>
              vivencia_rua =>
              internado_comunidade_teraupeutica_uso_drogas =>
              deseja_tratamento_uso_drogas =>
              usa_metodo_contraceptivo =>
              usa_contraceptivo_preservativo_masculino =>
              usa_contraceptivo_preservativo_feminino =>
              usa_contraceptivo_pilula_anticoncepcional =>
              usa_contraceptivo_diu =>
              usa_contraceptivo_tabela =>
              usa_contraceptivo_temperatura_basal =>
              usa_contraceptivo_metodo_biliing =>
              usa_contraceptivo_coito_interrompido =>
 #             id_contraceptivo => verificar...
              frequenta_genecologista =>
              frequenta_urologista =>
              id_participacao_grupo_social => $data->{participacao_grupo_social},
              participacao_grupo_religioso =>
              participacao_movimento_estudantil =>
              participacao_associacao_bairro =>
              participacao_movimento_politico =>
              participacao_grupo_musical =>
              participacao_grupo_esportivo =>
              participacao_grupo_teatro =>
              participacao_grupo_danca =>
              participacao_grupo_defesa_meio_ambiente =>
              participacao_cooperativa =>
              participacao_ong =>
              participacao_grupos_produtivos =>
              participacao_movimento_cultural =>
              participacao_organizacoes_lgbtt =>
              participacao_movimento_mulheres =>
              participacao_movimento_negro =>
              participacao_grupo_rpg =>
              participacao_grupos_rivais =>
              participacao_atividade_comunitaria =>
              id_tipo_escola_matriculado =>  $data->{tipo_escola_matriculado},
              id_escolaridade => $data->{emCasoAfirmativo}{escolaridade},
              id_auto_avaliacao_frequencia_escolar => $data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar},
  #            id_auto_avaliacao_rendimento_escolar =>  verificar ..
              id_avaliacao_acesso_medicacao => $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao},
  #            id_avaliacao_servico_saude =>  verificar ..
              id_avaliacao_condicao_saude_familia => $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia},
              data_nascimento =>
              id_possui_banheiro => $data->{possuiBanheiro},
              tipo_construcao_moradia_taipa_nao_resvestida =>
              tipo_construcao_moradia_madeira =>
              tipo_construcao_moradia_taipa_revestida =>
              tipo_construcao_moradia_material_aproveitado =>
              tipo_construcao_moradia_tijolo_alvenaria =>
              tipo_abastecimento_agua_rede_publica =>
              tipo_abastecimento_agua_poco_profundo =>
              tipo_abastecimento_agua_cacimba =>
              tipo_abastecimento_agua_carro_pipa =>
              tipo_abastecimento_agua_rio_lagoa =>
              tratamento_agua_filtracao =>
              tratamento_agua_fervura =>
              tratamento_agua_cloracao =>
              tratamento_agua_sem_tratamento =>
              escoamento_sanitario_rede_publica =>
              escoamento_sanitario_fossa_rudimentar =>
              escoamento_sanitario_fossa_septica =>
              escoamento_sanitario_ceu_aberto =>
              destino_lixo_coleta =>
              destino_lixo_queima =>
              destino_lixo_queima_enterramento =>
              destino_lixo_ceu_aberto =>
              id_esta_frequentando_escola => $data->{tipo_escola_matriculado},
              id_escola_matriculado_proximo_residencia => $data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia},
              id_criancas_familia_todas_matriculadas => $data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola},
              id_auto_avaliacao_participacao_atividade_escolar => $data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares},
              id_auto_avaliacao_participacao_familia_escola => $data->{avaliacaoDaVidaEscolar}{participacaoDaFamiliaNaSuaVidaEscolar},
              id_ja_estagiou => $data->{jaEstagiouAlgumaVez},
              id_ja_trabalhou => $data->{jaTrabalhouAlgumaVez},
              id_esta_trabalhando => $data->{estaTrabalhandoAtualmente},
              id_fez_curso_profissionalizante => $data->{cursosProficionalizantes},
              id_interesse_curso_profissionalizante => $data->{casoNaoTenhacursosProficionalizantes},
              origem_encaminhamento_associacoes character varying NOT NULL,
              origem_encaminhamento_conselho_tutelar =>
              origem_encaminhamento_demanda_espontanea =>
              origem_encaminhamento_judiciario =>
              origem_encaminhamento_programas_projetos_funci =>
              vinculacao_cca_adolescente_cidadao =>
              vinculacao_cca_aquarela =>
              vinculacao_cca_bromelia =>
              vinculacao_cca_casa_meninas =>
              vinculacao_cca_casa_meninos =>
              vinculacao_cca_cozinha_experimental =>
              vinculacao_cca_crescer_arte_cidadania =>
              vinculacao_cca_ddca =>
              vinculacao_cca_erradicacao_trabalho_infantil =>
              vinculacao_cca_estilo_solitario =>
              vinculacao_cca_ponte_encontro =>
              vinculacao_cca_se_garanta_liberdade_assitida =>
              vinculacao_cca_se_garanta_prestacao_servico_comunidade =>
              contra_violencia_intrafamiliar_procurou_instituicao =>
              contra_violencia_intrafamiliar_resolveu_conta_propia =>
              contra_violencia_intrafamiliar_procurou_amigos =>
              contra_violencia_intrafamiliar_nao_tomou_atitude =>
              teve_atendimento_especializado_contra_violencia_intrafamiliar =>
              esta_tendo_atendimento_especializado_contra_violencia_intrafami =>
              nao_tem_gostaria_atendimento_especializado_contra_violencia_int =>
              nao_quer_interesse_atendimento_especializado_contra_violencia_i =>
              id_sofre_violencia_ambiente_comunitario => $data->{violenciaNoAmbitoComunitario}{sofreAlgumTipoDeViolenciaComunitaria},
              id_sofreu_violencia_ambiente_comunitario => $data->{violenciaNoAmbitoComunitario}{sofreuAlgumTipoDeViolenciaComunitaria},
              contra_violencia_comunitaria_procurou_instituicao =>
              contra_violencia_comunitaria_resolveu_conta_propria =>
              contra_violencia_comunitaria_procurou_amigos =>
              contra_violencia_comunitaria_nao_tomou_atitude =>
              teve_atendimento_especializado_contra_violencia_comunitaria =>
              esta_tendo_atendimento_especializado_contra_violencia_comunitar =>
              nao_tem_gostaria_atendimento_especializado_contra_violencia_com =>
              nao_quer_atendimento_especializado_contra_violencia_comunitaria =>
              id_sofreu_violencia_institucional => $data->{violenciaNoAmbitoInstitucional}{sofreuAlgumTipoDeViolenciaInstitucional},
              contra_violencia_institucional_procurou_instituicao =>
              contra_violencia_institucional_resolveu_conta_propia =>
              contra_violencia_institucional_procurou_amigos =>
              contra_violencia_institucional_nao_tomou_atitude =>
              teve_atendimento_especializado_contra_violencia_institucional =>
              esta_tendo_atendimento_especializado_contra_violencia_instituci =>
              nao_tem_gostaria_atendimento_especializado_contra_violencia_ins =>
              nao_quer_atendimento_especializado_contra_violencia_institucion =>
              id_usa_alcool => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{alcool},
              id_usa_cigarro => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cigarro},
              id_usa_maconha => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{maconha},
              id_usa_cocaina => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cocaina},
              id_usa_mesclado => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                                                {fezUso}{mesclado},
              id_usa_crack => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                                                {fezUso}{crack},
              id_usa_comprimidos => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                                                {fezUso}{comprimidos},
              id_usa_cola => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cola},
              id_usa_inalantes => $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                                                {fezUso}{inalantes},
              nunca_fez_acompanhamento_contra_drogas =>
              fez_acompanhamento_contra_drogas_capsad =>
              fez_acompanhamento_contra_drogas_hospital_mental =>
              faz_acompanhamento_contra_drogas_hospital_mental =>
              faz_acompanhamento_contra_drogas_capsad =>
              ja_foi_internado_comunidade_terapeutica_contra_drogas =>
              deseja_tratamento_contra_drogas =>
              utiliza_contraceptivo_aids_dst =>
              utiliza_contraceptivo_preservativo_masculino =>
              utiliza_contraceptivo_preservativo_femenino =>
              utiliza_contraceptivo_pilula_anticoncepcional =>
              utiliza_contraceptivo_diu =>
              utiliza_contraceptivo_tabela =>
              utiliza_contraceptivo_temperatura_basal =>
              utiliza_contraceptivo_metodo_biling =>
              utiliza_contraceptivo_coito_interrompido =>
              id_frequenta_ginecologista_regularmente => $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente},
              id_frequenta_urologista_regularmente => $data->{saude}{aPartirDe12Anos}{frequentaUrologistaRegularmente},
              recebe_medicamento_quando_necessario =>
     })
}


extract();
#my $data = $read->('/tmp/bla.xml');

# load();
