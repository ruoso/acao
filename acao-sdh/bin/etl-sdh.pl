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

#my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');
my $sedna = Sedna->connect('172.30.116.22', 'AcaoDb', 'acao', 'acao');

$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

#my $dbi = DimSchema->connect("dbi:Pg:dbname=sdh;host=127.0.0.1;port=5432",'acao','blableblibloblu');
my $dbi = DimSchema->connect("dbi:Pg:dbname=acaodw;host=127.0.0.1;port=5432",'acao','12345');

BEGIN {
    die 'Informe a variavel de ambiente ACAO_HOME' unless -d $ENV{ACAO_HOME};
}

#define as constantes para os caminhos dos schemas, utilizando variável de ambiente
use constant HOME_SCHEMAS => $ENV{HOME_SCHEMAS} || catfile($Bin, '..', 'schemas');
use constant SCHEMA_DOSSIE    => catfile($ENV{ACAO_HOME}, 'schemas', 'dossie.xsd');
#use constant SCHEMA_AUDITORIA => catfile($ENV{ACAO_HOME}, 'schemas', 'auditoria.xsd');
use constant SCHEMA_DOCUMENTO => catfile($ENV{ACAO_HOME}, 'schemas', 'documento.xsd');
use constant SCHEMA_AUTORIZACAO => catfile($ENV{ACAO_HOME}, 'schemas', 'autorizacoes.xsd');
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
use constant SCHEMA_ATENDIMENTO                    => catfile(HOME_SCHEMAS, 'sdh-atendimento.xsd');
use constant SCHEMA_VISITAINSTITUCIONAL            => catfile(HOME_SCHEMAS, 'sdh-visitaInstitucional.xsd');

use constant DOSSIE_NS    => 'http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd';
use constant DOCUMENTO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/documento.xsd';
use constant AUTORIZACAO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd';
#use constant AUDITORIA_NS => 'http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd';

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
               'formAtendimento'                    => XML::Compile::Schema->new(SCHEMA_ATENDIMENTO),
               'formVisitaInstitucional'            => XML::Compile::Schema->new(SCHEMA_VISITAINSTITUCIONAL),
                  };

my $schema = XML::Compile::Schema->new([SCHEMA_DOCUMENTO, SCHEMA_AUTORIZACAO]);
#my $schema = XML::Compile::Schema->new([SCHEMA_DOCUMENTO]);
my $read = $schema->compile(READER => pack_type(DOCUMENTO_NS, 'documento'),  any_element => 'TAKE_ALL');

sub getVolumes{

    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
              for $x in collection("volume")/vol:volume/vol:collection/text() return $x';
    my @volumes;
    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);
     while ($sedna->next){
        push(@volumes, $sedna->getItem());
     }
    $sedna->commit;
    getDossies(@volumes);
}

sub getDossies{

    my @volume = @_;
    my @dossies;

    for (my $i=0; $i < scalar(@volume); $i++){
        $volume[$i]=~ s/^\s+//;
        my $xq = ' declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                   declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                   for $x in collection("'.$volume[$i].'")/dos:dossie/dos:controle/text() return $x';
        #inicia a conexão com o sedna
        $sedna->begin;

        #executa a consulta
        $sedna->execute($xq);
         while ($sedna->next){
            push(@dossies, $volume[$i], $sedna->getItem());
         }
        $sedna->commit;
    }

    for (my $i=0; $i < scalar(@dossies); $i+= 2){
#        warn 'Faltando ' . ((scalar(@dossies)) - ($i)) . ' .....................................';
        $dossies[$i+1]=~ s/^\s+//;
        extract($dossies[$i], $dossies[$i + 1]);
#drop_auditoria($dossies[$i], $dossies[$i + 1]);
    }

}

sub geIdtDocumentos{
    my ($id_volume, $controle) = @_;
    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    for $x in collection("' . $id_volume . '")/dos:dossie[dos:controle="'. $controle .'"]
                    /dos:doc/dc:documento/dc:id/text() return $x';
    my @documentos;
    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);
     while ($sedna->next){
        push(@documentos, $sedna->getItem());
     }
    $sedna->commit;

    for (my $i=0; $i < scalar(@documentos); $i++){
        $documentos[$i]=~ s/^\s+//;
    }
    return @documentos;
}
#este metodo é usado apenas para corrigir a estrutura dos xml antigos que usavam auditoria.
sub drop_auditoria {
    my ($id_volume, $controle) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    update delete collection("' . $id_volume . '")/dos:dossie[dos:controle="'. $controle .'"]
                    /dos:doc/dc:documento/dc:audit';

    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);

    $sedna->commit;
warn "auditoria dropado do controle $controle do volume $id_volume"
}

sub extract {
#volume-2633497e-7395-411b-9587-a9ec8da00c05
#017c57c9-37e9-4365-8907-1a8feefe9974
    my ($id_volume, $controle) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                    for $x in collection("' . $id_volume . '")/dos:dossie[dos:controle="'. $controle .'"]
                    /dos:doc/dc:documento[dc:invalidacao/text() eq "1970-01-01T00:00:00Z"] return $x';
    #inicia a conexão com o sedna
    $sedna->begin;
#warn $id_volume . "\n";
#warn $controle . "\n";
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
if($namespace[1] eq 'formIdentificacaoPessoal')
{
warn $xml_string;
}

#warn $namespace[1];
       my $read_doc = $schema_form->{$namespace[1]}->compile(READER => pack_type( substr($namespace[0],1) , $namespace[1] ));
       my $data_doc = $read_doc->($data->{documento}[0]{conteudo}{pack_type(substr($namespace[0],1) ,  $namespace[1])}[0]);
       push @result, { $namespace[1] => $data_doc};
       
if($namespace[1] eq 'formProfissionalizacaoHabilidades')
{
#warn Dumper($data_doc);
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
                                                        transform_participacao_atividade_comunitaria($data[$i]->{formConvivenciaSocial});
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
                                                       transform_escola_matriculado_proximo_residencia($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_rendimento_escolar($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_participacao_atividade_escolar($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_participacao_familia_escola($data[$i]->{formEducacao});
                                                       transform_auto_avaliacao_frequencia_escolar($data[$i]->{formEducacao});
                                                       }
            case 'formIdentificacaoPessoal'           { 
                                                        transform_estado_civil($data[$i]->{formIdentificacaoPessoal}); 
                                                        transform_sexo($data[$i]->{formIdentificacaoPessoal});
                                                        transform_raca_etnia($data[$i]->{formIdentificacaoPessoal});
                                                        transform_endereco($data[$i]->{formIdentificacaoPessoal});
                                                        transform_sexualidade($data[$i]->{formIdentificacaoPessoal});
                                                        transform_data_nascimento($data[$i]->{formIdentificacaoPessoal});
                                                        transform_regional($data[$i]->{formIdentificacaoPessoal});
                                                        transform_idade($data[$i]->{formIdentificacaoPessoal});
                                                      }
            case 'formJuridico'                       {}
            case 'formOrigemEncaminhamento'           {
                                                      }
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
                                                       transform_usa_contraceptivo($data[$i]->{formSaude});
                                                       transform_recebe_medicamento_quando_necessario($data[$i]->{formSaude});
                                                       }
            case 'formServicoSocial'                  {}
            case 'formVinculacaoNaCCA'                {
                                                       transform_status_vinculacao_cca($data[$i]->{formVinculacaoNaCCA});
                                                       transform_data($data[$i]->{formVinculacaoNaCCA});
                                                       }
            case 'formVinculoReligioso'               {
                                                        transform_vinculo_religioso($data[$i]->{formVinculoReligioso});
                                                       }
            case 'formVisitaDomiciliar'               {}
            case 'formProtecaoEspecial'               {
                                            transform_frequencia_violencia_intra_familiar_agressaoPsicologica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_agressaoFisica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_abusoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_exploracaoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_discussaoVerbal($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_ameacaDeMorte($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_violencia_intra_familiar_violenciaDomestica($data[$i]->{formProtecaoEspecial});
                                            transform_sofre_violencia_intra_familiar($data[$i]->{formProtecaoEspecial});
                                            transform_sofreu_violencia_intra_familiar($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_agressaoPsicologica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_agressaoFisica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_abusoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_exploracaoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_discussaoVerbal($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_comunitaria_ameacaDeMorte($data[$i]->{formProtecaoEspecial});
                                            transform_sofre_violencia_comunitaria($data[$i]->{formProtecaoEspecial});
                                            transform_sofreu_violencia_comunitaria($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_agressaoPsicologica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_agressaoFisica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_abusoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_exploracaoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_discussaoVerbal($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofre_violencia_institucional_ameacaDeMorte($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_agressaoPsicologica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_agressaoFisica($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_abusoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_exploracaoSexual($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_discussaoVerbal($data[$i]->{formProtecaoEspecial});
                                            transform_frequencia_sofreu_violencia_institucional_ameacaDeMorte($data[$i]->{formProtecaoEspecial});
                                            transform_sofre_violencia_institucional($data[$i]->{formProtecaoEspecial});
                                            transform_sofreu_violencia_institucional($data[$i]->{formProtecaoEspecial});
                                            transform_exploracao_trabalho_infantil($data[$i]->{formProtecaoEspecial});
                                            transform_vivencia_rua($data[$i]->{formProtecaoEspecial});
                                            transform_inscrito_peti($data[$i]->{formProtecaoEspecial});
                                                      }
            case 'formIndividualFamilia'              {}
            case 'formEvolucao'                       {}
            case 'formSaudeSubstanciaPsicoativa'      {
                                            transform_uso_drogas($data[$i]->{formSaudeSubstanciaPsicoativa});
                                            transform_deseja_tratamento_uso_droga($data[$i]->{formSaudeSubstanciaPsicoativa});
                                            transform_foi_internado_comunidade_teraupeutica_uso_droga($data[$i]->{formSaudeSubstanciaPsicoativa});
                                                       }
            case 'formDocumentacaoFamiliar'           {}
            case 'formComposicaoFamiliar'             {}
        }
    }

 load(@data);
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
    $data->{aPartirDe16Anos}{estadoCivil} =  $dbi->resultset('DEstadoCivil')->find_or_create({ estado_civil =>  $value, })->id_estado_civil;

}

sub transform_raca_etnia {
    my $data = shift;
    my $value = 'Não Informado';
warn $data->{racaEtinia};
    if ($data->{racaEtinia}){
        $value = $data->{racaEtinia};
    }
    $data->{racaEtinia} = $dbi->resultset('DRacaEtnia')->find_or_create({ raca_etnia => $value, })->id_raca_etnia;
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
    my $value =  'Não Informado';
    if($data->{identidade}){
        $value = $data->{identidade};
    }
    $data->{identidade} = $dbi->resultset('DIdentidade')->find_or_create({ situacao => $value, })->id_identidade;
}

sub transform_cpf {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{cpf}){
        $value = $data->{cpf};
    }
    $data->{cpf} = $dbi->resultset('DCpf')->find_or_create({ situacao => $value, })->id_cpf;
}

sub transform_ctps {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{ctps}){
        $value = $data->{ctps};
    }
    $data->{ctps} = $dbi->resultset('DCtp')->find_or_create({ situacao => $value, })->id_ctps;
}

sub transform_titulo_eleitor {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{titulo_eleitor}){
        $value = $data->{titulo_eleitor};
    }
    $data->{titulo_eleitor} = $dbi->resultset('DTituloEleitor')->find_or_create({ situacao =>$value, })->id_titulo_eleitor;
}

sub transform_reservista {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{reservista}){
        $value = $data->{reservista};
    }
    $data->{reservista} = $dbi->resultset('DReservista')->find_or_create({ situacao => $value, })->id_reservista;
}

sub transform_nis {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{nis}){
        $value = $data->{nis};
    }
    $data->{nis} = $dbi->resultset('DNi')->find_or_create({ situacao => $value, })->id_nis;
}

sub transform_data_nascimento {
    my $data = shift;
    my ($dt,$dt_int);
    if($data->{dataNascimento}){
        $dt = DateTime::Format::XSD->parse_datetime( $data->{dataNascimento} );
        $dt_int =  $data->{dataNascimento};
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
         $data->{dataNascimento} = $dt_int;
    }
    else{
        $data->{dataNascimento} = "1970-01-01";
        $data->{dataNascimento} = $dbi->resultset('DData')->find_or_create({ id_data => 0,
                                                                   data => $data->{dataEncaminhamento},
                                                                   dia  => 0,
                                                                   mes  => 0,
                                                                   ano  => 0,
                                                                   bimestre => 0,
                                                                   trimestre => 0,
                                                                   semestre => 0,
                                                                   dia_semana => 0,
                                                                  })->id_data;
    }
}

sub transform_tipo_iluminacao {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{tipoIluminacao}){
        $value = $data->{tipoIluminacao};
    }
    $data->{tipoIluminacao} = $dbi->resultset('DTipoIluminacao')->find_or_create({ tipo_iluminacao => $value, })->id_tipo_iluminacao;
}

sub transform_tempo_moradia {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{tempoMoradia}){
        $value = $data->{tempoMoradia};
    }
    $data->{tempoMoradia} = $dbi->resultset('DTempoMoradia')->find_or_create( { tempo_moradia => $value, })->id_tempo_moradia;
}

sub transform_situacao_moradia {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{situacaoMoradia}){
        $value = $data->{situacaoMoradia};
    }
    $data->{situacaoMoradia} = $dbi->resultset('DSituacaoMoradia')->find_or_create( { situacao_moradia => $value, })->id_situacao_moradia;
}

sub transform_possui_banheiro{
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{possuiBanheiro}){
        $value = $data->{possuiBanheiro};
    }
    $data->{possuiBanheiro} = $dbi->resultset('DPossuiBanheiro')->find_or_create( { possui_banheiro => $value,})->id_possui_banheiro;
}

sub transform_regional {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{filiacao}{regional}){
        $value = 'Regional ' . $data->{filiacao}{regional};
    }
    $data->{filiacao}{regional} = $dbi->resultset('DRegional')->find_or_create({ regional => $value,})->id_regional;
}



sub transform_participacao_grupo_social {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{participaOuParticipouDeAlgumGrupoSocial}){
        $value = $data->{participaOuParticipouDeAlgumGrupoSocial};
    }
    $data->{participaOuParticipouDeAlgumGrupoSocial} = $dbi->resultset('DParticipacaoGrupoSocial')->find_or_create( 
                                                                            { participacao_grupo_social => $value,})->id_participacao_grupo_social;
}
sub transform_participacao_atividade_comunitaria{
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{emCasoNegativoDesenvolveAlgumaAtividadeComunitaria}){
        $value = $data->{emCasoNegativoDesenvolveAlgumaAtividadeComunitaria};
    }
    $data->{emCasoNegativoDesenvolveAlgumaAtividadeComunitaria} = $dbi->resultset('DParticipacaoAtividadeComunitaria')->find_or_create( 
                                                            { participacao_atividade_comunitaria => $value,})->id_participacao_atividade_comunitaria;

}

sub transform_tipo_escola_matriculado {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{estaMaticuladoEmAlgumaEscola}){
        $value = $data->{estaMaticuladoEmAlgumaEscola};
        $value=~s/Sim. No ensino |\.//gis;
    }
    $data->{tipo_escola_matriculado} = $dbi->resultset('DTipoEscolaMatriculado')->find_or_create( { tipo_escola_matriculado => $value,
                                                                                                  })->id_tipo_escola_matriculado;
}

sub transform_esta_frequentando_escola {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{casoEstejaMatriculadoEstaFrenquentandoEscola}){
        $value = $data->{casoEstejaMatriculadoEstaFrenquentandoEscola};
    }
    $data->{casoEstejaMatriculadoEstaFrenquentandoEscola} = $dbi->resultset('DEstaFrequentandoEscola')->find_or_create( { esta_frequentando_escola => $value,
                                                                                                  })->id_esta_frequentando_escola;
}

sub transform_escolaridade {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{emCasoAfirmativo}{escolaridade}){
        $value = $data->{emCasoAfirmativo}{escolaridade};
    }
    $data->{emCasoAfirmativo}{escolaridade} = $dbi->resultset('DEscolaridade')->find_or_create({ escolaridade => $value,})->id_escolaridade;
}

sub transform_escola_matriculado_proximo_residencia {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia}){
        $value = $data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia};
    }
    $data->{escolaEmQueEstaMatriculadoSituaseProximoAResidencia} = $dbi->resultset('DEscolaMatriculadoProximoResidencia')
                                                            ->find_or_create({ escola_matriculado_proximo_residencia => $value,
                                                                            })->id_escola_matriculado_proximo_residencia;
}

sub transform_criancas_familia_todas_matriculadas {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola}){
        $value = $data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola};
    }
    $data->{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola} = $dbi->resultset('DCriancasFamiliaTodasMatriculada')
                                                                                ->find_or_create({ criancas_familia_todas_matriculadas => $value,
                                                                                                 })->id_criancas_familia_todas_matriculadas;
}

sub transform_turno_estuda {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{emCasoAfirmativo}{turno}){
        $value = $data->{emCasoAfirmativo}{turno};
    }
    $data->{emCasoAfirmativo}{turno} = $dbi->resultset('DTurnoEstuda')->find_or_create({ turno_estuda => $value,})->id_turno_estuda;
}

sub transform_auto_avaliacao_frequencia_escolar {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar}){
        $value = $data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar};
    }
    $data->{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar} = $dbi->resultset('DAutoAvaliacaoFrequenciaEscolar')
                                                            ->find_or_create( { auto_avaliacao_frequencia_escolar => $value, 
                                                                })->id_auto_avaliacao_frequencia_escolar;
}

sub transform_auto_avaliacao_rendimento_escolar {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{avaliacaoDaVidaEscolar}{rendimentoEscolar}){
        $value = $data->{avaliacaoDaVidaEscolar}{rendimentoEscolar};
    }
    $data->{avaliacaoDaVidaEscolar}{rendimentoEscolar} = $dbi->resultset('DAutoAvaliacaoRendimentoEscolar')->find_or_create(
                                                                { auto_avaliacao_rendimento_escolar => $value, })->id_auto_avaliacao_rendimento_escolar;
}

sub transform_auto_avaliacao_participacao_atividade_escolar {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares}){
        $value = $data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares};
    }
    $data->{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares} = $dbi->resultset('DAutoAvaliacaoParticipacaoAtividadeEscolar')
                                                        ->find_or_create({ auto_avaliacao_participacao_atividade_escolar => $value,
                                                                        })->id_auto_avaliacao_participacao_atividade_escolar;
}

sub transform_auto_avaliacao_participacao_familia_escola {
    my $data = shift;
    my $value =  'Não Informado';
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
    my $value =  'Não Informado';
    if($data->{jaEstagiouAlgumaVez}){
        $value = $data->{jaEstagiouAlgumaVez};
    }
    $data->{jaEstagiouAlgumaVez} = $dbi->resultset('DJaEstagiou')->find_or_create({ ja_estagiou => $value,})->id_ja_estagiou;
}

sub transform_ja_trabalhou {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{jaTrabalhouAlgumaVez}){
        $value = $data->{jaTrabalhouAlgumaVez};
    }
    $data->{jaTrabalhouAlgumaVez} = $dbi->resultset('DJaTrabalhou')->find_or_create({ ja_trabalhou => $value,})->id_ja_trabalhou;
}

sub transform_esta_trabalhando {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{estaTrabalhandoAtualmente}){
        $value = $data->{estaTrabalhandoAtualmente};
    }

    my $tipo = $data->{seEstaTabalhando}{fromalmente} + $data->{seEstaTabalhando}{informalmente};
    if ($tipo == 1){
       my $hash = ();
       %{$hash} = reverse %{$data->{seEstaTabalhando}};
       $tipo = $hash->{1};
    }
    $data->{estaTrabalhandoAtualmente} = $dbi->resultset('DEstaTrabalhando')->find_or_create({ esta_trabalhando => $value, 
                                                                                               tipo_trabalho => $tipo })->id_esta_trabalhando;
}

sub transform_nocoes_informatica {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{nossoesInformatica}){
        $value = $data->{nossoesInformatica};
    }
    $data->{nossoesInformatica} = $dbi->resultset('DNocoesInformatica')->find_or_create({ nocoes_informatica => $value,})->id_nocoes_informatica;
}

sub transform_fez_curso_profissionalizante {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{cursosProficionalizantes}){
        $value = $data->{cursosProficionalizantes};
    }
    $data->{cursosProficionalizantes} = $dbi->resultset('DFezCursoProfissionalizante')->find_or_create({ fez_curso_profissionalizante => $value,
                                                                                                        })->id_fez_curso_profissionalizante;
}

sub transform_interesse_curso_profissionalizante {
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{casoNaoTenhacursosProficionalizantes}){
        $value = $data->{casoNaoTenhacursosProficionalizantes};
    }
    $data->{casoNaoTenhacursosProficionalizantes} = $dbi->resultset('DInteresseCursoProfissionalizante')
                                                                ->find_or_create({ interesse_curso_profissionalizante 
                                                                 => $value,})->id_interesse_curso_profissionalizante;
}

sub transform_vinculo_religioso{
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{qualSeuVinculoReligiao}){
        $value = $data->{qualSeuVinculoReligiao};
    }
    $data->{qualSeuVinculoReligiao} = $dbi->resultset('DVinculoReligioso')->find_or_create({ vinculo_religioso => $value,})->id_vinculo_religioso;
}

sub transform_status_vinculacao_cca{
    my $data = shift;
    my $value =  'Não Informado';
    if($data->{status}){
        $value = $data->{status};
    }
    $data->{status} = $dbi->resultset('DStatusVinculacaoCca')->find_or_create({ status_vinculacao_cca => $value,})->id_status_vinculacao_cca;
}

sub transform_data{
    my $data = shift;
    my ($dt, $dt_int);
    if($data->{dataEncaminhamento}){
        $dt = DateTime::Format::XSD->parse_datetime( $data->{dataEncaminhamento} );
        $dt_int =  $data->{dataEncaminhamento};
        $dt_int=~s/[\-]//gis;
        $data->{dataEncaminhamento} = $dbi->resultset('DData')->find_or_create({ id_data => $dt_int,
                                                               data => $data->{dataEncaminhamento},
                                                               dia  => $dt->day,
                                                               mes  => $dt->month,
                                                               ano  => $dt->year,
                                                               bimestre => int(($dt->month-1)/2)+1,
                                                               trimestre => int(($dt->month-1)/3)+1,
                                                               semestre => $dt->month < 6 ? 1 : 2,
                                                               dia_semana => $dt->day_of_week,
                                                              })->id_data;
    }
    else{
        $data->{dataEncaminhamento} = "1970-01-01";
        $data->{dataEncaminhamento} = $dbi->resultset('DData')->find_or_create({ id_data => 0,
                                                                   data => $data->{dataEncaminhamento},
                                                                   dia  => 0,
                                                                   mes  => 0,
                                                                   ano  => 0,
                                                                   bimestre => 0,
                                                                   trimestre => 0,
                                                                   semestre => 0,
                                                                   dia_semana => 0,
                                                                  })->id_data;
    }
}

sub transform_sofre_violencia_intra_familiar{
    my $data = shift;
    my $value =  'Não Informado';
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
    my $value =  'Não Informado';
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

sub transform_frequencia_violencia_intra_familiar_agressaoPsicologica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{agressaoPsicologica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoPsicologica} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoPsicologica};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoPsicologica} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarAgressaoPsicologica')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_agressao_psicologica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_agressao_psicologica;
}

sub transform_frequencia_violencia_intra_familiar_agressaoFisica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{agressaoFisica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoFisica} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoFisica};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoFisica} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarAgressaoFisica')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_agressao_fisica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_agressao_fisica;
}

sub transform_frequencia_violencia_intra_familiar_abusoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{abusoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAbusoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAbusoSexual};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAbusoSexual} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarAbusoSexual')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_abuso_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_abuso_sexual;
}

sub transform_frequencia_violencia_intra_familiar_exploracaoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{exploracaoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreExploracaoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreExploracaoSexual};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreExploracaoSexual} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarExploracaoSexual')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_exploracao_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_exploracao_sexual;
}

sub transform_frequencia_violencia_intra_familiar_discussaoVerbal{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{discussaoVerbal} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreDiscussaoVerbal} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreDiscussaoVerbal};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreDiscussaoVerbal} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarDiscussaoVerbal')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_discussao_verbal => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_discussao_verbal;
}

sub transform_frequencia_violencia_intra_familiar_ameacaDeMorte{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{ameacaDeMorte} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAmeacaDeMorte} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAmeacaDeMorte};
        }
    }
    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAmeacaDeMorte} = 1;
                               $dbi->resultset('DSofreViolenciaIntrafamiliarAmeacaMorte')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_ameaca_morte => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_ameaca_morte;
}

sub transform_frequencia_violencia_intra_familiar_violenciaDomestica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{violenciaDomestica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreViolenciaDomestica} ){
            $frequencia = $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreViolenciaDomestica};
        }
    }

    $data->{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreViolenciaDomestica} = 
                               $dbi->resultset('DSofreViolenciaIntrafamiliarDomestica')
                                                  ->find_or_create({ sofre_violencia_intrafamiliar_domestica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_intrafamiliar_domestica;
}

sub transform_sofre_violencia_comunitaria{
    my $data = shift;
    my $value =  'Não Informado';
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
    my $value =  'Não Informado';
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

sub transform_frequencia_sofre_violencia_comunitaria_agressaoPsicologica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{agressaoPsicologica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica};
        }
    }

    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioAgressaoPsicologica')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_agressao_psicologica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_agressao_psicologica;
}

sub transform_frequencia_sofre_violencia_comunitaria_agressaoFisica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{agressaoFisica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica};
        }
    }

    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioAgressaoFisica')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_agressao_fisica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_agressao_fisica;
}

sub transform_frequencia_sofre_violencia_comunitaria_abusoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{abusoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual};
        }
    }
    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioAbusoSexual')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_abuso_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_abuso_sexual;
}

sub transform_frequencia_sofre_violencia_comunitaria_exploracaoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{exploracaoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual};
        }
    }

    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioExploracaoSexual')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_exploracao_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_exploracao_sexual;
}

sub transform_frequencia_sofre_violencia_comunitaria_discussaoVerbal{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{discussaoVerbal} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal};
        }
    }

    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioDiscussaoVerbal')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_discussao_verbal => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_discussao_verbal;
}

sub transform_frequencia_sofre_violencia_comunitaria_ameacaDeMorte{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{ameacaDeMorte} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte} ){
            $frequencia = $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte};
        }
    }

    $data->{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte} = 
                               $dbi->resultset('DSofreViolenciaAmbitoComunitarioAmeacaMorte')
                                                  ->find_or_create({ sofre_violencia_ambito_comunitario_ameaca_morte => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_ambito_comunitario_ameaca_morte;
}


sub transform_sofre_violencia_institucional{
    my $data = shift;
    my $value =  'Não Informado';
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
    my $value =  'Não Informado';
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

sub transform_frequencia_sofre_violencia_institucional_agressaoPsicologica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{agressaoPsicologica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalAgressaoPsicologica')
                                                  ->find_or_create({ sofre_violencia_institucional_agressao_psicologica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_agressao_psicologica;
}

sub transform_frequencia_sofre_violencia_institucional_agressaoFisica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{agressaoFisica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalAgressaoFisica')
                                                  ->find_or_create({ sofre_violencia_institucional_agressao_fisica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_agressao_fisica;
}

sub transform_frequencia_sofre_violencia_institucional_abusoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{abusoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalAbusoSexual')
                                                  ->find_or_create({ sofre_violencia_institucional_abuso_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_abuso_sexual;
}

sub transform_frequencia_sofre_violencia_institucional_exploracaoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{exploracaoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalExploracaoSexual')
                                                  ->find_or_create({ sofre_violencia_institucional_exploracao_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_exploracao_sexual;
}

sub transform_frequencia_sofre_violencia_institucional_discussaoVerbal{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{discussaoVerbal} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalDiscussaoVerbal')
                                                  ->find_or_create({ sofre_violencia_institucional_discussao_verbal => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_discussao_verbal;
}

sub transform_frequencia_sofre_violencia_institucional_ameacaDeMorte{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{ameacaDeMorte} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte} = 
                               $dbi->resultset('DSofreViolenciaInstitucionalAmeacaMorte')
                                                  ->find_or_create({ sofre_violencia_institucional_ameaca_morte => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofre_violencia_institucional_ameaca_morte;
}

sub transform_frequencia_sofreu_violencia_institucional_agressaoPsicologica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{agressaoPsicologica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoPsicologica} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoPsicologica};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoPsicologica} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalAgressaoPsicologica')
                                                  ->find_or_create({ sofreu_violencia_institucional_agressao_psicologica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_agressao_psicologica;
}

sub transform_frequencia_sofreu_violencia_institucional_agressaoFisica{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{agressaoFisica} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoFisica} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoFisica};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoFisica} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalAgressaoFisica')
                                                  ->find_or_create({ sofreu_violencia_institucional_agressao_fisica => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_agressao_fisica;
}

sub transform_frequencia_sofreu_violencia_institucional_abusoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{abusoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAbusoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAbusoSexual};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAbusoSexual} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalAbusoSexual')
                                                  ->find_or_create({ sofreu_violencia_institucional_abuso_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_abuso_sexual;
}

sub transform_frequencia_sofreu_violencia_institucional_exploracaoSexual{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{exploracaoSexual} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreExploracaoSexual} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreExploracaoSexual};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreExploracaoSexual} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalExploracaoSexual')
                                                  ->find_or_create({ sofreu_violencia_institucional_exploracao_sexual => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_exploracao_sexual;
}

sub transform_frequencia_sofreu_violencia_institucional_discussaoVerbal{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{discussaoVerbal} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreDiscussaoVerbal} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreDiscussaoVerbal};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreDiscussaoVerbal} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalDiscussaoVerbal')
                                                  ->find_or_create({ sofreu_violencia_institucional_discussao_verbal => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_discussao_verbal;
}

sub transform_frequencia_sofreu_violencia_institucional_ameacaDeMorte{
    my $data = shift;
    my $value = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{ameacaDeMorte} == 1 ? 'Sim' : 'Não' ;
    my $frequencia = 'Não Informado';
    if($value eq 'Sim'){
        if($data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAmeacaDeMorte} ){
            $frequencia = $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAmeacaDeMorte};
        }
    }

    $data->{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAmeacaDeMorte} = 
                               $dbi->resultset('DSofreuViolenciaInstitucionalAmeacaMorte')
                                                  ->find_or_create({ sofreu_violencia_institucional_ameaca_morte => $value,
                                                                      frequencia => $frequencia,
                                                                   })->id_sofreu_violencia_institucional_ameaca_morte;
}

sub transform_exploracao_trabalho_infantil{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{sofreOuSofreuAlgumTipoDeViolencia}){
        $value = $data->{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{sofreOuSofreuAlgumTipoDeViolencia};
    }
    $data->{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{sofreOuSofreuAlgumTipoDeViolencia} = 
                                                $dbi->resultset('DExploracaoTrabalhoInfantil')
                                                ->find_or_create({exploracao_trabalho_infantil => $value,})->id_exploracao_trabalho_infantil;
}

sub transform_vivencia_rua{
    my $data  = shift;
    my $value = $data->{vivenciaNaRua}{sim} + $data->{vivenciaNaRua}{nao};
    if($value == 1){
       my $hash = ();
       %{$hash} = reverse %{$data->{vivenciaNaRua}};
       $value = $hash->{1};
    }
    else{
    $value = 'Não Informado';
    }

    $data->{vivenciaNaRua}{sim} = $dbi->resultset('DVivenciaRua')->find_or_create({vivencia_rua => $value,})->id_vivencia_rua;
}

sub transform_inscrito_peti{
    my $data  = shift;
    my $value = $data->{estaInscritoNoPeti}{sim} + $data->{estaInscritoNoPeti}{nao};
    if($value == 1){
       my $hash = ();
       %{$hash} = reverse %{$data->{estaInscritoNoPeti}};
       $value = $hash->{1};
    }
    else{
    $value = 'Não Informado';
    }
    $data->{estaInscritoNoPeti}{sim} = $dbi->resultset('DInscritoPeti')->find_or_create({inscrito_peti => $value,})->id_inscrito_peti;
}

sub transform_uso_drogas{
    my $data = shift;
    my $value =  'Não Informado';
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

sub transform_deseja_tratamento_uso_droga{
    my $data  = shift;
    my $value = 'Não Informado';
    if( $data->{parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{desejaTratamento}){
        $value =  $data->{parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{desejaTratamento};
    }
    $data->{parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{desejaTratamento} = $dbi->resultset('DDesejaTratamentoUsoDroga')
                                               ->find_or_create({deseja_tratamento_uso_drogas => $value,})->id_deseja_tratamento_uso_drogas;
}

sub transform_foi_internado_comunidade_teraupeutica_uso_droga{
   my $data  = shift;
   my $value = 'Não Informado';
   if($data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{jaInternadoEmAlgumaComunidadeTerapeutica}){
      $value =  $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}
                                                                                                           {jaInternadoEmAlgumaComunidadeTerapeutica};
    }
    $data->{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{jaInternadoEmAlgumaComunidadeTerapeutica} = 
              $dbi->resultset('DFoiInternadoComunidadeTerapeuticaUsoDroga')->find_or_create({
                        foi_internado_comunidade_terapeutica_uso_droga => $value,})->id_foi_internado_comunidade_terapeutica_uso_droga;
}

sub transform_frequenta_ginecologista_regularmente{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente}){
        $value = $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente};
    }
   $data->{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente} = $dbi->resultset('DFrequentaGinecologistaRegularmente')
                                    ->find_or_create({frequenta_ginecologista_regularmente => $value,})->id_frequenta_ginecologista_regularmente;
}

sub transform_frequenta_urologista_regularmente{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{aPartirDe12Anos}{frequenteUrologistaRegularmente}){
        $value = $data->{saude}{aPartirDe12Anos}{frequenteUrologistaRegularmente};
    }
   $data->{saude}{aPartirDe12Anos}{frequenteUrologistaRegularmente} = $dbi->resultset('DFrequentaUrologistaRegularmente')
                                       ->find_or_create({frequenta_urologista_regularmente => $value,})->id_frequenta_urologista_regularmente;
}

sub transform_avaliacao_acesso_medicacao{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao} = $dbi->resultset('DAvaliacaoAcessoMedicacao')
                                               ->find_or_create({avaliacao_acesso_medicacao => $value,})->id_avaliacao_acesso_medicacao;
}

sub transform_usa_contraceptivo{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{aPartirDe12Anos}{utilizaAlgumMetodoContaceptivoOuContraDSTAIDS}){
        $value = $data->{saude}{aPartirDe12Anos}{utilizaAlgumMetodoContaceptivoOuContraDSTAIDS};
    }
    if ($value eq 'Não' || $value eq 'Não Informado'){
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{preservativoMasculino} = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{preservativoFemenino}  = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{pilulaAnticoncpcional} = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{diu}                   = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{tabela}                = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{temperaturaBasal}      = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{metododeBilling}       = 0;
         $data->{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{coitoInterrompido}     = 0;
    }
   $data->{saude}{aPartirDe12Anos}{utilizaAlgumMetodoContaceptivoOuContraDSTAIDS} = $dbi->resultset('DUsaContraceptivo')
                                                                ->find_or_create({usa_contraceptivo => $value,})->id_usa_contraceptivo;
}

sub transform_recebe_medicamento_quando_necessario{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{recebeMedicamentoQuandonecessario}){
        $value = $data->{saude}{recebeMedicamentoQuandonecessario};
    }
   $data->{saude}{recebeMedicamentoQuandonecessario} = $dbi->resultset('DRecebeMedicamentoQuandoNecessario')
                                               ->find_or_create({ recebe_medicamento_quando_necessario => $value,
                                                                })->id_recebe_medicamento_quando_necessario;
}

sub transform_avaliacao_servico_saude{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude} = $dbi->resultset('DAvaliacaoServicoSaude')
                                                       ->find_or_create({avaliacao_servico_saude => $value,})->id_avaliacao_servico_saude;
}

sub transform_avaliacao_condicao_saude_familia{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia}){
        $value = $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia};
    }
   $data->{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia} = $dbi->resultset('DAvaliacaoCondicaoSaudeFamilia')
                                               ->find_or_create({avaliacao_condicao_saude_familia => $value,})->id_avaliacao_condicao_saude_familia;
}

sub transform_idade{
    my $data  = shift;
    my $value = 'Não Informado';
    if($data->{idade}){
        $value = $data->{idade};
    }
    $data->{idade} = $dbi->resultset('DIdade')->find_or_create({idade => $value,})->id_idade;
}


sub load{
  my (@data) = @_;
  my @result;
  my %hashes = ();

    for (my $i=0; $i < scalar(@data); $i++){
        my @array = keys(%{$data[$i]});
        switch ($array[0]) {
            case 'formAtendimentoEspecificoSEGARANTA' {}
            case 'formCondicoesDeMoradia'             {
                     push (@result , (
                          situacao_moradia =>  $data[$i]->{formCondicoesDeMoradia}{situacaoMoradia},
                          id_tempo_moradia => $data[$i]->{formCondicoesDeMoradia}{tempoMoradia},
                          id_possui_banheiro =>  $data[$i]->{formCondicoesDeMoradia}{possuiBanheiro},
                          id_tipo_iluminacao =>  $data[$i]->{formCondicoesDeMoradia}{tipoIluminacao},
                          tipo_construcao_moradia_taipa_nao_resvestida => $data[$i]->{formCondicoesDeMoradia}{tiposConstrucao}{taipaNaoResvestida},
                          tipo_construcao_moradia_madeira => $data[$i]->{formCondicoesDeMoradia}{tiposConstrucao}{madeira},
                          tipo_construcao_moradia_taipa_revestida => $data[$i]->{formCondicoesDeMoradia}{tiposConstrucao}{taipaRevestida},
                          tipo_construcao_moradia_material_aproveitado => $data[$i]->{formCondicoesDeMoradia}{tiposConstrucao}{materialAproveitado},
                          tipo_construcao_moradia_tijolo_alvenaria => $data[$i]->{formCondicoesDeMoradia}{tiposConstrucao}{tijoloAlvenaria},
                          tipo_abastecimento_agua_rede_publica => $data[$i]->{formCondicoesDeMoradia}{tipoAbastecimentoAgua}{redePublica},
                          tipo_abastecimento_agua_poco_profundo => $data[$i]->{formCondicoesDeMoradia}{tipoAbastecimentoAgua}{pocoProfundo},
                          tipo_abastecimento_agua_cacimba => $data[$i]->{formCondicoesDeMoradia}{tipoAbastecimentoAgua}{cacimba},
                          tipo_abastecimento_agua_carro_pipa => $data[$i]->{formCondicoesDeMoradia}{tipoAbastecimentoAgua}{carroPipa},
                          tipo_abastecimento_agua_rio_lagoa => $data[$i]->{formCondicoesDeMoradia}{tipoAbastecimentoAgua}{nascenteRioLagoa},
                          tratamento_agua_filtracao => $data[$i]->{formCondicoesDeMoradia}{tratamentoAgua}{filtracao},
                          tratamento_agua_fervura => $data[$i]->{formCondicoesDeMoradia}{tratamentoAgua}{fervura},
                          tratamento_agua_cloracao => $data[$i]->{formCondicoesDeMoradia}{tratamentoAgua}{cloracao},
                          tratamento_agua_sem_tratamento => $data[$i]->{formCondicoesDeMoradia}{tratamentoAgua}{semTratamento},
                          escoamento_sanitario_rede_publica =>  $data[$i]->{formCondicoesDeMoradia}{escoamentoSanitario}{redePublica},
                          escoamento_sanitario_fossa_rudimentar => $data[$i]->{formCondicoesDeMoradia}{escoamentoSanitario}{fossaRudimentar},
                          escoamento_sanitario_fossa_septica =>  $data[$i]->{formCondicoesDeMoradia}{escoamentoSanitario}{fossaSeptica},
                          escoamento_sanitario_ceu_aberto => $data[$i]->{formCondicoesDeMoradia}{escoamentoSanitario}{ceuAberto},
                          destino_lixo_coleta => $data[$i]->{formCondicoesDeMoradia}{destinoLixo}{coleta},
                          destino_lixo_queima => $data[$i]->{formCondicoesDeMoradia}{destinoLixo}{queima},
                          destino_lixo_enterramento => $data[$i]->{formCondicoesDeMoradia}{destinoLixo}{enterramento},
                          destino_lixo_ceu_aberto => $data[$i]->{formCondicoesDeMoradia}{destinoLixo}{ceuAberto},
                                )
                      );
                                                      }
            case 'formConvivenciaFamiliarComunitaria' {}
            case 'formConvivenciaSocial'              {
    push (@result , ( 
    id_participacao_grupo_social => $data[$i]->{formConvivenciaSocial}{participaOuParticipouDeAlgumGrupoSocial},
    participacao_grupo_religioso => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoReligioso},
    participacao_movimento_estudantil => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{gremioMovimentoEstudantil},
    participacao_associacao_bairro => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{associacaoDeBairro},
    participacao_movimento_politico => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{gruposProdutivos},
    participacao_grupo_musical => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoMusical},
    participacao_grupo_esportivo => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoEsportivo},
    participacao_grupo_teatro => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoDeTeatro},
    participacao_grupo_danca => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoDeDanca},
    participacao_grupo_defesa_meio_ambiente => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoDeDefesaDoMeioAmbiente},
    participacao_cooperativa => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{cooperativa},
    participacao_ong => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{ong},
    participacao_grupos_produtivos => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{gruposProdutivos},
    participacao_movimento_cultural => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{movimentoCultural},
    participacao_organizacoes_lgbtt => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{organizacoesLgbtt},
    participacao_movimento_mulheres => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{movimentoDeMulheres},
    participacao_movimento_negro => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{movimentoNegro},
    participacao_grupo_rpg => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{grupoDeRpg},
    participacao_grupos_rivais => $data[$i]->{formConvivenciaSocial}{teveOuEstaTendoAlgumTipoDeAtendimento}{gruposRivaisGuangues},
    id_participacao_atividade_comunitaria => $data[$i]->{formConvivenciaSocial}{emCasoNegativoDesenvolveAlgumaAtividadeComunitaria},
                 )
      );
                                                       }
            case 'formDirecionamentoDoAtendimento'    {}
            case 'formDocumentacao'                   { 
                        push (@result , (
                                         id_registro_nascimento => $data[$i]->{formDocumentacao}{registro_nascimento},
                                         id_identidade => $data[$i]->{formDocumentacao}{identidade},
                                         id_cpf => $data[$i]->{formDocumentacao}{cpf},
                                         id_ctps => $data[$i]->{formDocumentacao}{ctps},
                                         id_titulo_eleitor => $data[$i]->{formDocumentacao}{titulo_eleitor},
                                         id_reservista => $data[$i]->{formDocumentacao}{reservista},
                                         id_nis => $data[$i]->{formDocumentacao}{nis},
                                        )
                              );
                                                      }
            case 'formEducacao'                       {
                        push (@result , (
  id_tipo_escola_matriculado =>  $data[$i]->{formEducacao}{tipo_escola_matriculado},
  id_escolaridade => $data[$i]->{formEducacao}{emCasoAfirmativo}{escolaridade},
  id_auto_avaliacao_frequencia_escolar => $data[$i]->{formEducacao}{avaliacaoDaVidaEscolar}{suaFrequenciaEscolar},
  id_auto_avaliacao_rendimento_escolar =>   $data[$i]->{formEducacao}{avaliacaoDaVidaEscolar}{rendimentoEscolar},
  id_esta_frequentando_escola => $data[$i]->{formEducacao}{casoEstejaMatriculadoEstaFrenquentandoEscola},
  id_escola_matriculado_proximo_residencia => $data[$i]->{formEducacao}{escolaEmQueEstaMatriculadoSituaseProximoAResidencia},
  id_criancas_familia_todas_matriculadas => $data[$i]->{formEducacao}{naSuaFamiliaTodasAsCriancasAdolescentesIdadeEscolarEstaoMatriculadasNaEscola},
  id_auto_avaliacao_participacao_atividade_escolar => $data[$i]->{formEducacao}{avaliacaoDaVidaEscolar}{participacaoNasAtividadesEscolares},
  id_auto_avaliacao_participacao_familia_escola => $data[$i]->{formEducacao}{avaliacaoDaVidaEscolar}{participacaoDaFamiliaNaSuaVidaEscolar},
  id_turno_estuda => $data[$i]->{formEducacao}{emCasoAfirmativo}{turno},
                                        )
                              );
                                                       }
            case 'formIdentificacaoPessoal'           {
                    push (@result , (
                         id_sexo => $data[$i]->{formIdentificacaoPessoal}{sexo},
                         id_sexualidade => $data[$i]->{formIdentificacaoPessoal}{aPartirDe14Anos}{orientacaoSexual},
                         id_idade => $data[$i]->{formIdentificacaoPessoal}{idade},
                         id_endereco => $data[$i]->{formIdentificacaoPessoal}{filiacao}{endereco},
                         id_raca_etnia => $data[$i]->{formIdentificacaoPessoal}{racaEtinia},
                         id_estado_civil => $data[$i]->{formIdentificacaoPessoal}{aPartirDe16Anos}{estadoCivil}, 
                         id_regional => $data[$i]->{formIdentificacaoPessoal}{filiacao}{regional},
                         deficiencia_sensorial_surdo => $data[$i]->{formIdentificacaoPessoal}{possuiAlgumaDeficiencia}{sensorialSurdo},
                         deficiencia_sensorial_cego => $data[$i]->{formIdentificacaoPessoal}{possuiAlgumaDeficiencia}{sensorialCego},
                         deficiencia_fisico_motor => $data[$i]->{formIdentificacaoPessoal}{possuiAlgumaDeficiencia}{deficienciaFisicoMotor},
                         deficiencia_mobilidade_reduzida => $data[$i]->{formIdentificacaoPessoal}{possuiAlgumaDeficiencia}{mobilidadeReduzida},
                         deficiencia_intelectual => $data[$i]->{formIdentificacaoPessoal}{possuiAlgumaDeficiencia}{deficienciaIntelectual},
                         data_nascimento => $data[$i]->{formIdentificacaoPessoal}{dataNascimento},
                         id_data => $data[$i]->{formIdentificacaoPessoal}{dataNascimento},
                                        )
                             );
                                                      }
            case 'formJuridico'                       {}
            case 'formOrigemEncaminhamento'           {
                push (@result , (
                                  origem_encaminhamento_associacoes => $data[$i]->{formOrigemEncaminhamento}{associacoes},
                                  origem_encaminhamento_conselho_tutelar => $data[$i]->{formOrigemEncaminhamento}{conselhoTutelar},
                                  origem_encaminhamento_demanda_espontanea => $data[$i]->{formOrigemEncaminhamento}{demandaEspontanea},
                                  origem_encaminhamento_judiciario => $data[$i]->{formOrigemEncaminhamento}{judiciario},
                                  origem_encaminhamento_programas_projetos_funci => $data[$i]->{formOrigemEncaminhamento}{programasOuProjetosDaFunci},
                                )
                             );
                                                       }
            case 'formPedagogia'                      {}
            case 'formPlanoIndividualDeAtendimento'   {}
            case 'formProfissionalizacaoHabilidades'  {
                   push (@result , (                                          
                      id_nocoes_informatica => $data[$i]->{formProfissionalizacaoHabilidades}{nossoesInformatica},
                      id_ja_estagiou => $data[$i]->{formProfissionalizacaoHabilidades}{jaEstagiouAlgumaVez},
                      id_ja_trabalhou => $data[$i]->{formProfissionalizacaoHabilidades}{jaTrabalhouAlgumaVez},
                      id_esta_trabalhando => $data[$i]->{formProfissionalizacaoHabilidades}{estaTrabalhandoAtualmente},
                      id_fez_curso_profissionalizante => $data[$i]->{formProfissionalizacaoHabilidades}{cursosProficionalizantes},
                      id_interesse_curso_profissionalizante => $data[$i]->{formProfissionalizacaoHabilidades}{casoNaoTenhacursosProficionalizantes},
                      habilidade_desenho => $data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{desenho},
                      habilidade_artesanato =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{artesanato},
                      habilidade_grafite =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{grafite},
                      habilidade_costura =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{costura},
                      habilidade_musica =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{musica},
                      habilidade_literatura =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{literatura},
                      habilidade_teatro =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{teatro},
                      habilidade_culinaria =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{culinaria},
                      habilidade_danca =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{danca},
                      habilidade_pintura =>$data[$i]->{formProfissionalizacaoHabilidades}{possuiAlgumasDestahabilidades}{pintura},
                                )
                     );
                                                       }
            case 'formPsicologia'                     {}
            case 'formRelatoriosEncaminhados'         {}
            case 'formSaude'                          {
           push (@result , (                                          
             usa_contraceptivo_preservativo_masculino => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{preservativoMasculino},
             usa_contraceptivo_preservativo_feminino => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{preservativoFeminino},
             usa_contraceptivo_pilula_anticoncepcional => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{pilulaAnticoncpcional},
             usa_contraceptivo_diu => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{diu},
             usa_contraceptivo_tabela => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{tabela},
             usa_contraceptivo_temperatura_basal => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{temperaturaBasal},
             usa_contraceptivo_metodo_biliing => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{metododeBilling},
             usa_contraceptivo_coito_interrompido => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{qualContaceptivoUsa}{coitoInterrompido},
             id_usa_contraceptivo => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{utilizaAlgumMetodoContaceptivoOuContraDSTAIDS},
             id_avaliacao_acesso_medicacao => $data[$i]->{formSaude}{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoAmedicacao},
             id_avaliacao_servico_saude =>  $data[$i]->{formSaude}{saude}{avaliacaoDoAcessoAosServicosDeSaude}{acessoDaFamiliaAoServicoDeSaude},
             id_avaliacao_condicao_saude_familia => $data[$i]->{formSaude}{saude}{avaliacaoDoAcessoAosServicosDeSaude}{condicoesDeSaudeDaFamilia},
             id_frequenta_ginecologista_regularmente => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{frequentaGinecologistaRegularmente},
             id_frequenta_urologista_regularmente => $data[$i]->{formSaude}{saude}{aPartirDe12Anos}{frequenteUrologistaRegularmente},
             id_recebe_medicamento_quando_necessario => $data[$i]->{formSaude}{saude}{recebeMedicamentoQuandonecessario},
                            )
             );
                                                       }
            case 'formServicoSocial'                  {}
            case 'formVinculacaoNaCCA'                {
               push (@result , ( 
                  id_status_vinculacao_cca => $data[$i]->{formVinculacaoNaCCA}{status},
                  id_data =>  $data[$i]->{formVinculacaoNaCCA}{dataEncaminhamento},
                  vinculacao_cca_adolescente_cidadao =>  $data[$i]->{formVinculacaoNaCCA}{adolescenteCidadao},
                  vinculacao_cca_aquarela =>  $data[$i]->{formVinculacaoNaCCA}{aquarela},
                  vinculacao_cca_bromelia =>  $data[$i]->{formVinculacaoNaCCA}{bromelia},
                  vinculacao_cca_casa_meninas =>  $data[$i]->{formVinculacaoNaCCA}{casaDasMeninas},
                  vinculacao_cca_casa_meninos =>  $data[$i]->{formVinculacaoNaCCA}{casaDosMeninos},
                  vinculacao_cca_cozinha_experimental =>  $data[$i]->{formVinculacaoNaCCA}{cozinhaExperimental},
                  vinculacao_cca_crescer_arte_cidadania =>  $data[$i]->{formVinculacaoNaCCA}{crescerComArteCidadania},
                  vinculacao_cca_ddca =>  $data[$i]->{formVinculacaoNaCCA}{disqueDireitosCriacaoEAdolescentes},
                  vinculacao_cca_erradicacao_trabalho_infantil =>  $data[$i]->{formVinculacaoNaCCA}{erradicacaoDoTrabalhoInfantil},
                  vinculacao_cca_estilo_solitario =>  $data[$i]->{formVinculacaoNaCCA}{estiloSolidario},
                  vinculacao_cca_ponte_encontro =>  $data[$i]->{formVinculacaoNaCCA}{ponteDeEncontro},
                  vinculacao_cca_se_garanta_liberdade_assitida =>  $data[$i]->{formVinculacaoNaCCA}{seGarantaLiberdadeAssitida},
                  vinculacao_cca_se_garanta_prestacao_servico_comunidade =>  $data[$i]->{formVinculacaoNaCCA}{seGarantaPrestacaoDeServicosAComunidade},
                                )
                     );
                                                       }
            case 'formVinculoReligioso'               {
                   push (@result , ( id_vinculo_religioso => $data[$i]->{formVinculoReligioso}{qualSeuVinculoReligiao} ) );
                                                       }
            case 'formVisitaDomiciliar'               {}
            case 'formProtecaoEspecial'               {
                   push (@result , (                                          
id_sofre_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{sofreAlgumTipoDeViolenciaIntrafamiliar},
id_sofreu_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{sofreuAlgumTipoDeViolenciaIntrafamiliar},
id_sofre_violencia_institucional => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{sofreAlgumTipoDeViolenciaInstitucional},
id_sofre_violencia_ambito_comunitario_ameaca_morte => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte},
id_sofre_violencia_ambito_comunitario_agressao_psicologica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica},
id_sofre_violencia_ambito_comunitario_exploracao_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual},
id_sofre_violencia_ambito_comunitario_abuso_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual},
id_sofre_violencia_ambito_comunitario_agressao_fisica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica},
id_sofre_violencia_ambito_comunitario_discussao_verbal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal},
id_sofreu_violencia_institucional_ameaca_morte => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAmeacaDeMorte},
id_sofreu_violencia_institucional_agressao_psicologica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoPsicologica},
id_sofreu_violencia_institucional_exploracao_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreExploracaoSexual},
id_sofreu_violencia_institucional_abuso_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAbusoSexual},
id_sofreu_violencia_institucional_agressao_fisica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreAgressaoFisica},
id_sofreu_violencia_institucional_discussao_verbal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaSofrida}{frequenciaSofreDiscussaoVerbal},
id_sofre_violencia_institucional_ameaca_morte =>  $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAmeacaDeMorte},
id_sofre_violencia_institucional_agressao_psicologica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoPsicologica},
id_sofre_violencia_institucional_exploracao_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreExploracaoSexual},
id_sofre_violencia_institucional_abuso_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAbusoSexual},
id_sofre_violencia_institucional_agressao_fisica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreAgressaoFisica},
id_sofre_violencia_institucional_discussao_verbal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{tipoDeViolenciaQueSofre}{frequenciaSofreDiscussaoVerbal},
id_sofre_violencia_intrafamiliar_ameaca_morte =>   $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAmeacaDeMorte},
id_sofre_violencia_intrafamiliar_agressao_psicologica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoPsicologica},
id_sofre_violencia_intrafamiliar_exploracao_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreExploracaoSexual},
id_sofre_violencia_intrafamiliar_abuso_sexual => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAbusoSexual},
id_sofre_violencia_intrafamiliar_agressao_fisica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreAgressaoFisica},
id_sofre_violencia_intrafamiliar_discussao_verbal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreDiscussaoVerbal},
id_sofre_violencia_intrafamiliar_domestica => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{frequenciaSofreViolenciaDomestica}, 
sofre_violencia_instituicao_policial => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{policia} eq ''? 0 : $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{policia},
sofre_violencia_instituicao_guarda_municipal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{guardaMunicipal}  eq ''? 0 : $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{guardaMunicipal},
sofre_violencia_instituicao_escola => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{escola} eq ''? 0 : $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{escola},
sofre_violencia_instituicao_posto_saude => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{postoDeSaude} eq ''? 0 : $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreViolencia}{postoDeSaude},
sofreu_violencia_instituicao_policial => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreuViolencia}{policia},
sofreu_violencia_instituicao_guarda_municipal => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreuViolencia}{guardaMunicipal},
sofreu_violencia_instituicao_escola => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreuViolencia}{escola},
sofreu_violencia_instituicao_posto_saude => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{instituicaoOndeSofreuViolencia}{postoDeSaude},
id_exploracao_trabalho_infantil => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{sofreOuSofreuAlgumTipoDeViolencia},
exploracao_trabalho_infantil_domestico => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{trabalhoInfantilDomestico},
exploracao_trabalho_infantil_catador => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{catador},
exploracao_trabalho_infantil_pedinte => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{pedinte},
exploracao_trabalho_infantil_malabarista => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{malabarista},
exploracao_trabalho_infantil_engraxate => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{engraxate},
exploracao_trabalho_infantil_flanelinha => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{flanelinha},
exploracao_trabalho_infantil_jornaleiro => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{jornaleiro},
exploracao_trabalho_infantil_ajudante_pedreiro => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{ajudanteDePedreiro},
exploracao_trabalho_infantil_comercio_drogas => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{comercioDeDrogas},
exploracao_trabalho_infantil_pesca => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{pesca},
exploracao_trabalho_carvoaria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoDaExploracaoDoTrabalhoInfantil}{tipoDeTrabalho}{carvoaria},
id_inscrito_peti => $data[$i]->{formProtecaoEspecial}{estaInscritoNoPeti}{sim},
id_vivencia_rua => $data[$i]->{formProtecaoEspecial}{vivenciaNaRua}{sim},
id_sofre_violencia_ambiente_comunitario =>$data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{sofreAlgumTipoDeViolenciaComunitaria},
id_sofreu_violencia_ambiente_comunitario => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{sofreuAlgumTipoDeViolenciaComunitaria},
id_sofreu_violencia_institucional => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{sofreuAlgumTipoDeViolenciaInstitucional},
contra_violencia_intrafamiliar_procurou_instituicao =>  $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaEmAlgumaInstituicao},
contra_violencia_intrafamiliar_resolveu_conta_propia => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{queTipoDeProvidenciaOuAtitudeFoiTomada}{resouveuASituacaoPorContaPropria},
contra_violencia_intrafamiliar_procurou_amigos => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaDeAmigosOuParentes},
contra_violencia_intrafamiliar_nao_tomou_atitude => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{queTipoDeProvidenciaOuAtitudeFoiTomada}{naoTomouNenhumaAtitudeOuProvidencia},
teve_atendimento_especializado_contra_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaTeveAtendimentoEspecializado},
esta_tendo_atend_especializado_contra_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaEstaTendoAtendimentoEspecializado},
nao_tem_gostaria_atend_especial_contra_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoPoremGostariaDeSerEncaminhadoParaAtendimentoEspecializado},
nao_quer_atend_especializado_contra_violencia_intrafamiliar => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoIntrafamiliar}{casoTenhaSofridoViolenciaEspecifique}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoTtemInteresseNoAtendimento},
contra_violencia_comunitaria_procurou_instituicao => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaEmAlgumaInstituicao},
contra_violencia_comunitaria_resolveu_conta_propria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{queTipoDeProvidenciaOuAtitudeFoiTomada}{resouveuASituacaoPorContaPropria},
contra_violencia_comunitaria_procurou_amigos => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaDeAmigosOuParentes},
contra_violencia_comunitaria_nao_tomou_atitude => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{queTipoDeProvidenciaOuAtitudeFoiTomada}{naoTomouNenhumaAtitudeOuProvidencia},
teve_atendimento_especializado_contra_violencia_comunitaria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaTeveAtendimentoEspecializado},
esta_tendo_atend_especializado_contra_violencia_comunitaria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaEstaTendoAtendimentoEspecializado},
nao_tem_gostaria_atend_especial_contra_violencia_comunitaria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoPoremGostariaDeSerEncaminhadoParaAtendimentoEspecializado},
nao_quer_atend_especializado_contra_violencia_comunitaria => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoComunitario}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoTtemInteresseNoAtendimento},
contra_violencia_institucional_procurou_instituicao =>  $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaEmAlgumaInstituicao},
contra_violencia_institucional_resolveu_conta_propia => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{queTipoDeProvidenciaOuAtitudeFoiTomada}{resouveuASituacaoPorContaPropria},
contra_violencia_institucional_procurou_amigos => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{queTipoDeProvidenciaOuAtitudeFoiTomada}{procurouAjudaDeAmigosOuParentes},
contra_violencia_institucional_nao_tomou_atitude => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{queTipoDeProvidenciaOuAtitudeFoiTomada}{naoTomouNenhumaAtitudeOuProvidencia},
teve_atendimento_especializado_contra_violencia_institucional => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaTeveAtendimentoEspecializado},
esta_tendo_atend_especializado_contra_violencia_institucional => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{teveOuEstaTendoAlgumTipoDeAtendimento}{simJaEstaTendoAtendimentoEspecializado},
nao_tem_gostaria_atend_especializado_contra_violencia_instituci => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoPoremGostariaDeSerEncaminhadoParaAtendimentoEspecializado},
nao_quer_atend_especializado_contra_violencia_institucional => $data[$i]->{formProtecaoEspecial}{violenciaNoAmbitoInstitucional}{teveOuEstaTendoAlgumTipoDeAtendimento}{naoTtemInteresseNoAtendimento},
                                )
                     );
                                                      }
            case 'formIndividualFamilia'              {}
            case 'formEvolucao'                       {}
            case 'formSaudeSubstanciaPsicoativa'      {
            push (@result , (
            id_usa_alcool => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{alcool},
            id_usa_cigarro => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cigarro},
            id_usa_maconha => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{maconha},
            id_usa_cocaina => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cocaina},
            id_usa_mesclado => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{mesclado},
            id_usa_crack => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{crack},
            id_usa_comprimidos => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{comprimidos},
            id_usa_cola => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{cola},
            id_usa_inalantes => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{fezUso}{inalantes},
            nunca_fez_acompanhamento_contra_drogas => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{nuncaFezAcompanhamento},
            fez_acompanhamento_contra_drogas_capsad => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFezAcompanhamento}{capsad},
            fez_acompanhamento_contra_drogas_capsi => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFezAcompanhamento}{capsi},
            fez_acompanhamento_contra_drogas_hospital_mental =>  $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFezAcompanhamento}{hospitalMental},
            faz_acompanhamento_contra_drogas_hospital_mental => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFazAcompanhamento}{hospitalMental},
            faz_acompanhamento_contra_drogas_capsad =>  $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFazAcompanhamento}{capsad},
            faz_acompanhamento_contra_drogas_capsi => $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{acompanhamentoEspecificoParausoDrogras}{ondeFazAcompanhamento}{capsi},
            id_foi_internado_comunidade_terapeutica_uso_droga =>  $data[$i]->{formSaudeSubstanciaPsicoativa}{saudeSubstanciaPsicoativa}{algumMembroDaFamiliaOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{jaInternadoEmAlgumaComunidadeTerapeutica},
            id_deseja_tratamento_uso_drogas => $data[$i]->{formSaudeSubstanciaPsicoativa}{parentescoOuSocioeducandoFazUsoDeSubstanciasPsicoativas}{desejaTratamento},
                                        )
                             );
                                                       }
            case 'formDocumentacaoFamiliar'           {}
            case 'formComposicaoFamiliar'             {}
        }
    }



 %hashes = (@result);

     $dbi->resultset('FAtendimento')->create({ %hashes });

}

sub normalizaTabelas{

my @tables = (
"DParticipacaoAtividadeComunitaria", "participacao_atividade_comunitaria", "id_participacao_atividade_comunitaria",
"DAutoAvaliacaoFrequenciaEscolar", "auto_avaliacao_frequencia_escolar", "id_auto_avaliacao_frequencia_escolar",
"DAutoAvaliacaoParticipacaoAtividadeEscolar", "auto_avaliacao_participacao_atividade_escolar", "id_auto_avaliacao_participacao_atividade_escolar",
"DAutoAvaliacaoParticipacaoFamiliaEscola",  "auto_avaliacao_participacao_familia_escola", "id_auto_avaliacao_participacao_familia_escola", 
"DAutoAvaliacaoRendimentoEscolar",  "auto_avaliacao_rendimento_escolar", "id_auto_avaliacao_rendimento_escolar", 
"DAvaliacaoAcessoMedicacao", "avaliacao_acesso_medicacao", "id_avaliacao_acesso_medicacao",
"DAvaliacaoCondicaoSaudeFamilia", "avaliacao_condicao_saude_familia", "id_avaliacao_condicao_saude_familia",
"DAvaliacaoServicoSaude", "avaliacao_servico_saude", "id_avaliacao_servico_saude",
"DCpf", "situacao", "id_cpf",
"DCriancasFamiliaTodasMatriculada", "criancas_familia_todas_matriculadas", "id_criancas_familia_todas_matriculadas",
"DCtp", "situacao", "id_ctps",
"DDesejaTratamentoUsoDroga", "deseja_tratamento_uso_drogas", "id_deseja_tratamento_uso_drogas",
"DEndereco", "endereco", "id_endereco",
"DEscolaMatriculadoProximoResidencia", "escola_matriculado_proximo_residencia", "id_escola_matriculado_proximo_residencia",
"DEscolaridade", "escolaridade", "id_escolaridade",
"DEstadoCivil", "estado_civil", "id_estado_civil",
"DEstaFrequentandoEscola", "esta_frequentando_escola", "id_esta_frequentando_escola",
"DEstaTrabalhando", "esta_trabalhando", "id_esta_trabalhando",
"DExploracaoTrabalhoInfantil", "exploracao_trabalho_infantil", "id_exploracao_trabalho_infantil",
"DFezCursoProfissionalizante", "fez_curso_profissionalizante", "id_fez_curso_profissionalizante",
"DFoiInternadoComunidadeTerapeuticaUsoDroga", "foi_internado_comunidade_terapeutica_uso_droga", "id_foi_internado_comunidade_terapeutica_uso_droga",
"DFrequentaGinecologistaRegularmente", "frequenta_ginecologista_regularmente", "id_frequenta_ginecologista_regularmente",
"DFrequentaUrologistaRegularmente",  "frequenta_urologista_regularmente", "id_frequenta_urologista_regularmente", 
"DIdade", "idade", "id_idade",
"DIdentidade", "situacao", "id_identidade",
"DInscritoPeti", "inscrito_peti", "id_inscrito_peti",
"DInteresseCursoProfissionalizante", "interesse_curso_profissionalizante", "id_interesse_curso_profissionalizante",
"DJaEstagiou", "ja_estagiou", "id_ja_estagiou",
"DJaTrabalhou", "ja_trabalhou", "id_ja_trabalhou",
"DNi",  "situacao", "id_nis", 
"DNocoesInformatica", "nocoes_informatica", "id_nocoes_informatica",
"DRegional", "regional", "id_regional",
"DParticipacaoGrupoSocial", "participacao_grupo_social", "id_participacao_grupo_social",
"DPossuiBanheiro",  "possui_banheiro", "id_possui_banheiro", 
"DRacaEtnia", "raca_etnia", "id_raca_etnia",
"DRecebeMedicamentoQuandoNecessario", "recebe_medicamento_quando_necessario", "id_recebe_medicamento_quando_necessario",
"DRegistroNascimento", "situacao", "id_registro_nascimento",
"DReservista", "situacao", "id_reservista",
"DSexo", "sexo", "id_sexo",
"DSituacaoMoradia",  "situacao_moradia", "id_situacao_moradia", 
"DSofreuViolenciaAmbienteComunitario",  "sofreu_violencia_ambiente_comunitario", "id_sofreu_violencia_ambiente_comunitario", 
"DSofreuViolenciaInstitucional", "sofreu_violencia_institucional", "id_sofreu_violencia_institucional",
"DSofreuViolenciaInstitucionalAbusoSexual", "sofreu_violencia_institucional_abuso_sexual", "id_sofreu_violencia_institucional_abuso_sexual",
"DSofreuViolenciaInstitucionalAgressaoFisica",  "sofreu_violencia_institucional_agressao_fisica", "id_sofreu_violencia_institucional_agressao_fisica", 
"DSofreuViolenciaInstitucionalAgressaoPsicologica", "sofreu_violencia_institucional_agressao_psicologica", "id_sofreu_violencia_institucional_agressao_psicologica",
"DSofreuViolenciaInstitucionalAmeacaMorte", "sofreu_violencia_institucional_ameaca_morte", "id_sofreu_violencia_institucional_ameaca_morte",
"DSofreuViolenciaInstitucionalDiscussaoVerbal", "sofreu_violencia_institucional_discussao_verbal", "id_sofreu_violencia_institucional_discussao_verbal",
"DSofreuViolenciaInstitucionalExploracaoSexual", "sofreu_violencia_institucional_exploracao_sexual", "id_sofreu_violencia_institucional_exploracao_sexual",
"DSofreuViolenciaIntrafamiliar", "sofreu_violencia_intrafamiliar", "id_sofreu_violencia_intrafamiliar",
"DSofreViolenciaAmbienteComunitario", "sofre_violencia_ambiente_comunitario", "id_sofre_violencia_ambiente_comunitario",
"DSofreViolenciaAmbitoComunitarioAbusoSexual", "sofre_violencia_ambito_comunitario_abuso_sexual", "id_sofre_violencia_ambito_comunitario_abuso_sexual",
"DSofreViolenciaAmbitoComunitarioAgressaoFisica", "sofre_violencia_ambito_comunitario_agressao_fisica", "id_sofre_violencia_ambito_comunitario_agressao_fisica",
"DSofreViolenciaAmbitoComunitarioAgressaoPsicologica", "sofre_violencia_ambito_comunitario_agressao_psicologica", "id_sofre_violencia_ambito_comunitario_agressao_psicologica",
"DSofreViolenciaAmbitoComunitarioAmeacaMorte",  "sofre_violencia_ambito_comunitario_ameaca_morte", "id_sofre_violencia_ambito_comunitario_ameaca_morte", 
"DSofreViolenciaAmbitoComunitarioDiscussaoVerbal", "sofre_violencia_ambito_comunitario_discussao_verbal", "id_sofre_violencia_ambito_comunitario_discussao_verbal",
"DSofreViolenciaAmbitoComunitarioExploracaoSexual", "sofre_violencia_ambito_comunitario_exploracao_sexual", "id_sofre_violencia_ambito_comunitario_exploracao_sexual",
"DSofreViolenciaInstitucional", "sofre_violencia_institucional", "id_sofre_violencia_institucional",
"DSofreViolenciaInstitucionalAbusoSexual", "sofre_violencia_institucional_abuso_sexual", "id_sofre_violencia_institucional_abuso_sexual",
"DSofreViolenciaInstitucionalAgressaoFisica", "sofre_violencia_institucional_agressao_fisica", "id_sofre_violencia_institucional_agressao_fisica",
"DSofreViolenciaInstitucionalAgressaoPsicologica",  "sofre_violencia_institucional_agressao_psicologica", "id_sofre_violencia_institucional_agressao_psicologica", 
"DSofreViolenciaInstitucionalAmeacaMorte",  "sofre_violencia_institucional_ameaca_morte", "id_sofre_violencia_institucional_ameaca_morte", 
"DSofreViolenciaInstitucionalDiscussaoVerbal", "sofre_violencia_institucional_discussao_verbal", "id_sofre_violencia_institucional_discussao_verbal",
"DSofreViolenciaInstitucionalExploracaoSexual", "sofre_violencia_institucional_exploracao_sexual", "id_sofre_violencia_institucional_exploracao_sexual",
"DSofreViolenciaIntrafamiliar", "sofre_violencia_intrafamiliar", "id_sofre_violencia_intrafamiliar",
"DSofreViolenciaIntrafamiliarAbusoSexual",  "sofre_violencia_intrafamiliar_abuso_sexual", "id_sofre_violencia_intrafamiliar_abuso_sexual", 
"DSofreViolenciaIntrafamiliarAgressaoFisica", "sofre_violencia_intrafamiliar_agressao_fisica", "id_sofre_violencia_intrafamiliar_agressao_fisica",
"DSofreViolenciaIntrafamiliarAgressaoPsicologica", "sofre_violencia_intrafamiliar_agressao_psicologica", "id_sofre_violencia_intrafamiliar_agressao_psicologica",
"DSofreViolenciaIntrafamiliarAmeacaMorte", "sofre_violencia_intrafamiliar_ameaca_morte", "id_sofre_violencia_intrafamiliar_ameaca_morte",
"DSofreViolenciaIntrafamiliarDiscussaoVerbal", "sofre_violencia_intrafamiliar_discussao_verbal", "id_sofre_violencia_intrafamiliar_discussao_verbal",
"DSofreViolenciaIntrafamiliarDomestica", "sofre_violencia_intrafamiliar_domestica", "id_sofre_violencia_intrafamiliar_domestica",
"DSofreViolenciaIntrafamiliarExploracaoSexual", "sofre_violencia_intrafamiliar_exploracao_sexual", "id_sofre_violencia_intrafamiliar_exploracao_sexual",
"DStatusVinculacaoCca", "status_vinculacao_cca", "id_status_vinculacao_cca",
"DTempoMoradia", "tempo_moradia", "id_tempo_moradia",
"DTipoEscolaMatriculado", "tipo_escola_matriculado", "id_tipo_escola_matriculado",
"DTipoIluminacao", "tipo_iluminacao", "id_tipo_iluminacao",
"DTituloEleitor",  "situacao", "id_titulo_eleitor", 
"DTurnoEstuda", "turno_estuda", "id_turno_estuda",
"DUsaAlcool", "usa_alcool", "id_usa_alcool",
"DUsaCigarro", "usa_cigarro", "id_usa_cigarro",
"DUsaCocaina", "usa_cocaina", "id_usa_cocaina",
"DUsaCola", "usa_cola", "id_usa_cola",
"DUsaComprimido", "usa_comprimidos", "id_usa_comprimidos",
"DUsaContraceptivo", "usa_contraceptivo", "id_usa_contraceptivo",
"DUsaCrack", "usa_crack", "id_usa_crack",
"DUsaInalante", "usa_inalantes", "id_usa_inalantes",
"DUsaMaconha", "usa_maconha", "id_usa_maconha",
"DUsaMesclado", "usa_mesclado", "id_usa_mesclado",
"DVinculoReligioso", "vinculo_religioso", "id_vinculo_religioso",
"DVivenciaRua", "vivencia_rua", "id_vivencia_rua",
"DSexualidade", "sexualidade", "id_sexualidade"
            );

  $dbi->resultset('DData')->find_or_create({id_data => 0});
  for (my $a=0; $a < scalar(@tables); $a+= 3){

    $dbi->resultset($tables[$a])->find_or_create({$tables[$a+1] => 'Não Informado', $tables[$a+2] => 0,});
        
  }
}

normalizaTabelas();
getVolumes();




