use Sedna;
use XML::Compile::Schema;
use XML::Compile::Util qw(pack_type);
use DBIx::Class::Schema;
use File::Spec::Functions;
use FindBin qw($Bin);
use lib catfile($Bin, '..', 'lib');
use DateTime::Format::XSD;


use aliased 'Acao::Plugins::VilaDoMar::DimSchema';

#define as constantes para os caminhos dos schemas, utilizando variável de ambiente
use constant HOME_SCHEMAS => $ENV{HOME_SCHEMAS} || catfile($Bin, '..', 'schemas');
use constant SCHEMA_CONSOLIDADO => catfile(HOME_SCHEMAS, 'viladomar-consolidado.xsd');
use constant SCHEMA_CADERNOA => catfile(HOME_SCHEMAS, 'viladomar-cadernoa.xsd');
use constant SCHEMA_CADERNOB => catfile(HOME_SCHEMAS, 'viladomar-cadernob.xsd');

#define uma constante com o namespace do xml schema viladomar-consolidado.xsd
use constant VILADOMAR_CONSOLIDADO_NS => 'http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd';

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');
my $dbi = DimSchema->connect("dbi:Pg:dbname=acaodw;host=127.0.0.1;port=5432",'acao','blableblibloblu');

sub extract {
    #recebe o id das collections consolidacao-saida a ser compilada e convertida em hash 
    #para persistencia dos dados no data warehouse
    my ($id_cosolidacao_saida) = @_;
    
    #consulta xquery para retornar as collections consolidacao-saida com os dados 
    #da familia e de seus integrantes
    my $xq = 'declare namespace rec = "http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd";
              declare namespace fam = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
              for $x in collection("consolidacao-saida-'.$id_cosolidacao_saida.'")/
                                    rec:registroConsolidacao/rec:documento/rec:conteudo/fam:familia return $x';

    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);

    #atribui os itens retornados da consulta acima na variavel $xsd sob a forma de XML String
    my $xml_string = $sedna->getItem();

    #cria uma nova compilacao do o XML Schema especificado
    my $schema = XML::Compile::Schema->new(SCHEMA_CONSOLIDADO);
    
    #define a importação dos demais documentos XML Schema utilizados dentro do XML Schema compilado acima
    $schema->importDefinitions(SCHEMA_CADERNOA);
    $schema->importDefinitions(SCHEMA_CADERNOB);
    #transforma o XML em um Hash
    my $read = $schema->compile(READER => pack_type(VILADOMAR_CONSOLIDADO_NS , 'familia'));
 
    while ($sedna->next){
        my $data = $read->($xml_string);
        transform($data);
    }

    $sedna->commit;
}

sub transform {    
    my ($data) = @_;
    #=============================CadernoA
    transform_caracteristicasImovel($data->{formCadernoA}{caracteristicasImovel});
    transform_infraestrutura($data->{formCadernoA}{infraestrutura});
    transform_enderecoImovel($data->{formCadernoA}{enderecoImovel});
    transform_resumoMembros($data->{resumoMembros});

    #=============================CadernoB
    foreach my $cadb (@{$data->{formCadernoB}}) {
        transform_saude($cadb->{saude});
        transform_saudeMulher($cadb->{saudeMulher});
        transform_educacao($cadb->{educacao});
        transform_composicaoFamiliar($cadb->{composicaoFamiliar});
        transform_trabalho($cadb->{trabalho});
        transform_rendaMensal($cadb->{renda});
    }

    load($data);
}

#=============================CadernoA
sub transform_caracteristicasImovel {
    my $data = shift;
    $data->{areaPreservacao} = $data->{areaPreservacao} eq 'Sim' ? 1 : 0;
    $data->{casaEmSituacaRisco} = $data->{casaEmSituacaRisco} eq 'Sim' ? 1 : 0;
    $data->{revestimentoParede} = $dbi->resultset('DRevestimentoParedeImovel')->
                                                          find_or_create({ revestimento_parede_imovel => $data->{revestimentoParede} })->id;
    $data->{situacaoFundiaria} = $dbi->resultset('DSituacaoFundiariaImovel')->
                                                          find_or_create({ situacao_fundiaria_imovel => $data->{situacaoFundiaria} })->id;
    $data->{TempoMoradia} = $dbi->resultset('DTempoMoradiaImovel')->
                                                          find_or_create({ tempo_moradia_imovel => $data->{TempoMoradia} })->id;
    $data->{tipoCobertura} = $dbi->resultset('DTipoCoberturaImovel')->
                                                          find_or_create({ tipo_cobertura_imovel => $data->{tipoCobertura} })->id;
    $data->{tipoMoradia} = $dbi->resultset('DTipoMoradiaImovel')->
                                                          find_or_create({ tipo_moradia_imovel => $data->{tipoMoradia} })->id;
    $data->{tipoPiso} = $dbi->resultset('DTipoPisoImovel')->
                                                          find_or_create({ tipo_piso_imovel => $data->{tipoPiso} })->id;
    $data->{tipologiaConstrucao} = $dbi->resultset('DTipologiaConstrucaoImovel')->
                                                          find_or_create({ tipologia_construcao_imovel => $data->{tipologiaConstrucao} })->id;
    $data->{tipologiaUso} = $dbi->resultset('DTipologiaUsoImovel')->
                                                          find_or_create({ tipologia_uso_imovel => $data->{tipologiaUso} })->id;
}

sub transform_infraestrutura {
    my $data = shift;
    $data->{redeDeAgua} = $data->{redeDeAgua} eq 'Sim' ? 1 : 0;
    $data->{redeColetaEsgoto} = $data->{redeColetaEsgoto} eq 'Sim' ? 1 : 0;
    $data->{abastecimentoAguaPublicoPrivado} = $dbi->resultset('DTipoFornecedorAbastecimentoAguaImovel')->
                                                 find_or_create({  tipo_fornecedor_abastecimento_agua_imovel => $data->{abastecimentoAguaPublicoPrivado} })->id;
    $data->{abastecimentoAgua}{tipoAbastecimentoAgua} = $dbi->resultset('DTipoAbastecimentoAguaImovel')->
                                                 find_or_create({ tipo_abastecimento_agua_imovel => $data->{abastecimentoAgua}{tipoAbastecimentoAgua} })->id;
    $data->{esgotamentoSanitario} = $dbi->resultset('DTipoRedeEsgotamentoSanitarioImovel')->
                                                 find_or_create({ tipo_rede_esgotamento_sanitario_imovel => $data->{esgotamentoSanitario} })->id;
    $data->{esgotamentoSanitario2}{tipo} = $dbi->resultset('DTipoEsgotamentoSanitarioImovel')->
                                                 find_or_create({ tipo_esgotamento_sanitario_imovel => $data->{esgotamentoSanitario2}{tipo} })->id;
    $data->{tipoLigacaoRedeEletrica} = $dbi->resultset('DTipoLigacaoRedeEletricaImovel')->
                                                        find_or_create({ tipo_ligacao_rede_eletrica_imovel => $data->{tipoLigacaoRedeEletrica} })->id;
    $data->{tipoPavimentacao} = $dbi->resultset('DTipoPavimentacao')->
                                                        find_or_create({ tipo_pavimentacao => $data->{tipoPavimentacao} })->id;
    $data->{tipoServicoTelefonicoPredominante} = $dbi->resultset('DTipoServicoTelefonico')->
                                                        find_or_create({ tipo_servico_telefonico => $data->{tipoServicoTelefonicoPredominante} })->id;
}

sub transform_enderecoImovel {
    my $data = shift;
    $data->{informante} = $dbi->resultset('DSituacaoMoradorImovel')->find_or_create({ situacao_morador_imovel => $data->{informante} })->id;
    $data->{logradouro} = $dbi->resultset('DEnderecoImovel')->find_or_create({ logradouro => $data->{logradouro},
                                                                               numero => $data->{numero},
                                                                               complemento => $data->{complemento},
                                                                               bairro => $data->{bairro},
                                                                               telefone => $data->{telefone},
                                                                             })->id;
    for my $campo (qw(visita1 visita2 visita3)) {
        my $dt = DateTime::Format::XSD->parse_datetime( $data->{$campo} );
        $data->{$campo} = $dbi->resultset('DData')->find_or_create({ data => $data->{$campo},
                                                                      dia => $dt->day,
                                                                      mes => $dt->month,
                                                                      ano => $dt->year,
                                                                      bimestre => int(($dt->month-1)/2)+1,
                                                                      trimestre => int(($dt->month-1)/3)+1,
                                                                      semestre => $dt->month < 6 ? 1 : 2,
                                                                      dia_semana => $dt->day_of_week,
                                                                    })->data;
    }

}

sub transform_resumoMembros {
     my ($data) = @_;
     $data->{rendaFamiliar} = $dbi->resultset('DRenda')->find_or_create({ renda => $data->{rendaFamiliar} })->id;
}

#=============================CadernoB
sub transform_saude {
    my ($data) = @_;
    $data->{deficienciaVisual} = $data->{deficienciaVisual} eq 'Sim' ? 1 : 0;
    $data->{deficienciaMental} = $data->{deficienciaMental} eq 'Sim' ? 1 : 0;
    $data->{deficienciaAuditiva} = $data->{deficienciaAuditiva} eq 'Sim' ? 1 : 0;
    $data->{emtratamento} = $data->{emtratamento} eq 'Sim' ? 1 : 0;
    $data->{deficienciaFisica} = $data->{deficienciaFisica} eq 'Sim' ? 1 : 0;
    $data->{unidadeMedicaProcurada} = $dbi->resultset('DUnidadeMedicaProcurada')
                                     ->find_or_create({unidade_medica_procurada => $data->{unidadeMedicaProcurada}})->id;
}

sub transform_saudeMulher {
    my ($data) = @_;
    $data->{fezPrevencao} = $data->{fezPrevencao} eq 'Sim' ? 1 : 0;
    $data->{causasObito} = $dbi->resultset('DCausasObito')
                                    ->find_or_create({causas_obitos => $data->{causasObitos}})->id;
    $data->{fezPrenatal} = $dbi->resultset('DFezPrenatal')
                                    ->find_or_create({fez_prenatal => $data->{fezPrenatal}})->id;
    $data->{obitoInfantilUltimoAno} = $dbi->resultset('DObitoInfantilUltimoAno')
                                    ->find_or_create({obito_infantil_ultimo_ano => $data->{obitoInfantilUltimoAno}})->id;
    $data->{qtdGravidou} = $dbi->resultset('DQtdGravidou')
                                    ->find_or_create({qtd_gravidou => $data->{qtdGravidou}})->id;
}

sub transform_educacao {
    my ($data) = @_;
    $data->{desejaEstudar} = $data->{desejaEstudar} eq 'Sim' ? 1 : 0;

    $data->{cursandoAtualmente} = $data->{cursandoAtualmente} eq 'Sim' ? 1 : 0;

    $data->{grauEscolaridade} = $dbi->resultset('DGrauEscolaridade')
                                        ->find_or_create({grau_escolaridade => $data->{grauEscolaridade}})->id;
    $data->{motivoDeParaDeEstudar} = $dbi->resultset('DMotivoDeParaDeEstudar')
                                        ->find_or_create({motivo_de_para_de_estudar => $data->{motivoDepararDeEstudarOutro}})->id;
    $data->{tipoDeEscola} = $dbi->resultset('DTipoDeEscola')
                                        ->find_or_create({tipodeescola => $data->{tipoDeEscola}})->id;


}

sub transform_composicaoFamiliar {
    my ($data) = @_;
    $data->{sexo} = $dbi->resultset('DSexo')->find_or_create({sexo => $data->{sexo}})->id;
    $data->{informante} = $dbi->resultset('DInformante')
                                ->find_or_create({informante => $data->{informante}})->id;
    $data->{situacaoConjugal} = $dbi->resultset('DSituacaoConjugal')
                                ->find_or_create({situacao_conjugal => $data->{situacaoConjugal}})->id;
}

sub transform_trabalho {
    my ($data) = @_;
    $data->{statusAtual} = $dbi->resultset('DStatusAtual')
                                ->find_or_create({status_atual => $data->{statusAtual}})->id;
    $data->{tempoprocurandotrabalho} = $dbi->resultset('DTempoProcurandoTrabalho')
                                ->find_or_create({tempoprocurandotrabalho => $data->{tempoprocurandotrabalho}})->id;
}

sub transform_rendaMensal {
     my ($data) = @_;
     $data->{rendaMensal} = $dbi->resultset('DRenda')->find_or_create({ renda => $data->{rendaMensal} })->id;
}

sub load{
    my ($data) = @_;
    
    $dbi->resultset('FEntrevistaDomiciliarVilaDoMar')
        ->create( { 
              data_id => $data->{formCadernoA}{identificacao}{data},
              situacao_morador_imovel_id => $data->{formCadernoA}{enderecoImovel}{informante},
              tipologia_uso_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{tipologiaUso},
              situacao_fundiaria_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{situacaoFundiaria},
              tipo_moradia_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{tipoMoradia},
              tempo_moradia_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{TempoMoradia},
              endereco_imovel_id => $data->{formCadernoA}{enderecoImovel}{logradouro},
              tipologia_construcao_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{tipologiaConstrucao},
              tipo_cobertura_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{tipoCobertura},
              tipo_piso_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{tipoPiso},
              tipo_fornecedor_abastecimento_agua_imovel_id => $data->{formCadernoA}{infraestrutura}{abastecimentoAguaPublicoPrivado},
              tipo_abastecimento_agua_imovel_id => $data->{formCadernoA}{infraestrutura}{abastecimentoAgua}{tipoAbastecimentoAgua},
              tipo_rede_esgoto_sanitario_imovel_id  => $data->{formCadernoA}{infraestrutura}{esgotamentoSanitario},
              tipo_esgoto_sanitario_imovel_id => $data->{formCadernoA}{infraestrutura}{esgotamentoSanitario2}{tipo},
              tipo_ligacao_eletrica_imovel_id => $data->{formCadernoA}{infraestrutura}{tipoLigacaoRedeEletrica},
              revestimento_parede_imovel_id => $data->{formCadernoA}{caracteristicasImovel}{revestimentoParede},
              tipo_pavimentacao_id => $data->{formCadernoA}{infraestrutura}{tipoPavimentacao},
              quantidade_integrantes => $data->{resumoMembros}{qtdMembros},
              renda_familiar_id => $data->{resumoMembros}{rendaFamiliar},
              rede_agua => $data->{formCadernoA}{infraestrutura}{redeDeAgua},
              rede_coleta_esgoto => $data->{formCadernoA}{infraestrutura}{redeColetaEsgoto},
              tipo_servico_telefonico_id => $data->{formCadernoA}{infraestrutura}{tipoServicoTelefonicoPredominante},
              valor_imovel => $data->{formCadernoA}{caracteristicasImovel}{valor},
              situacao_risco_imovel => $data->{formCadernoA}{caracteristicasImovel}{casaEmSituacaRisco},
              quantidade_banheiro_imovel => $data->{formCadernoA}{caracteristicasImovel}{compartimentosMoradia}{qtdBanheiros},
              quantidade_quintal_imovel => $data->{formCadernoA}{caracteristicasImovel}{compartimentosMoradia}{qtdQuintais},
              quantidade_cozinha_imovel => $data->{formCadernoA}{caracteristicasImovel}{compartimentosMoradia}{qtdCozinhas},
              quantidade_quarto_imovel => $data->{formCadernoA}{caracteristicasImovel}{compartimentosMoradia}{qtdQuartos},
              quantidade_sala_imovel => $data->{formCadernoA}{caracteristicasImovel}{compartimentosMoradia}{qtdSalas},
              area_preservacao_imovel => $data->{formCadernoA}{caracteristicasImovel}{areaPreservacao},
              visita1 => $data->{formCadernoA}{enderecoImovel}{visita1},
              visita2 => $data->{formCadernoA}{enderecoImovel}{visita2},
              visita3 => $data->{formCadernoA}{enderecoImovel}{visita3},
              destino_lixo_sistema_coleta => $data->{formCadernoA}{infraestrutura}{destinoLixo}{sistemaColeta},
              destino_lixo_conteiner => $data->{formCadernoA}{infraestrutura}{destinoLixo}{conteiner},
              destino_lixo_terreno_baldio => $data->{formCadernoA}{infraestrutura}{destinoLixo}{terrenoBaldio},
              destino_lixo_curso_dagua => $data->{formCadernoA}{infraestrutura}{destinoLixo}{cursoDagua},
              destino_lixo_passeio => $data->{formCadernoA}{infraestrutura}{destinoLixo}{passeio},
              destino_lixo_logradouro => $data->{formCadernoA}{infraestrutura}{destinoLixo}{logradouro},
              destino_lixo_enterrado => $data->{formCadernoA}{infraestrutura}{destinoLixo}{enterrado},
              destino_lixo_queimado => $data->{formCadernoA}{infraestrutura}{destinoLixo}{queimado},
              destino_lixo_outro => $data->{formCadernoA}{infraestrutura}{destinoLixo}{outro},
              tipo_drenagem_galeria_subterranea => $data->{formCadernoA}{infraestrutura}{tipoDrenagem}{galeriaSubterranea},
              tipo_drenagem_sarjeta => $data->{formCadernoA}{infraestrutura}{tipoDrenagem}{sarjeta},
              tipo_drenagem_curso_dagua_canalizado => $data->{formCadernoA}{infraestrutura}{tipoDrenagem}{cursoDaguaCanalizado},
              tipo_drenagem_curso_dagua_nao_canalizado => $data->{formCadernoA}{infraestrutura}{tipoDrenagem}{cursoDaguaNaoCanalizado},
              tipo_drenagem_outro => $data->{formCadernoA}{infraestrutura}{tipoDrenagem}{outro},
              necessita_reparos_hidrosanitarias => $data->{formCadernoA}{necessitaReparos}{instalacoesHidrosanitarias},
              necessidade_reparos_pinturas => $data->{formCadernoA}{necessitaReparos}{pintura},
              necessidade_reparos_coberta_telhado => $data->{formCadernoA}{necessitaReparos}{cobertaTelhado},
              necessidade_reparos_outro => $data->{formCadernoA}{necessitaReparos}{outro},
              tipo_risco_alagamento => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{alagamento},
              tipo_risco_inundacao => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{inundacao},
              tipo_risco_deslizamento => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{deslizamento},
              tipo_risco_linha_alta_tensao => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{linhaAltaTensao},
              tipo_risco_via_ferrea => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{viaFerrea},
              tipo_risco_outro => $data->{formCadernoA}{caracteristicasImovel}{tipoRisco}{outro},
              localizacao_quadra_loteada => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{quadraloteada},
              localizacao_leito_rua => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{leitoDeRua},
              localizacao_praca => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{praca},
              localizacao_area_verde => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{areaVerde},
              localizacao_terreno_eqp_comunitario => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{terroParaEquipamentoComunitario},
              localizacao_outro => $data->{formCadernoA}{caracteristicasImovel}{localizacao}{localizacaoOutro},
              cod_pmf => $data->{formCadernoA}{identificacao}{codigoPMFNaoTem}
             } );

    foreach my $cadb (@{$data->{formCadernoB}}) {
        $dbi->resultset('FEntrevistaIndividualVilaDoMar')
            ->create({
                unidade_medica_procurada_id => $cadb->{saude}{unidadeMedicaProcurada},
                causas_obitos_id => $cadb->{saudeMulher}{causasObito},
                data_id => $cadb->{composicaoFamiliar}{data},
                motivo_de_para_de_estudar_id => $cadb->{educacao}{motivoDeParaDeEstudar},
                status_atual_id => $cadb->{trabalho}{statusAtual},
                fez_prenatal_id => $cadb->{saudeMulher}{fezPrenatal},
                grau_escolaridade_id => $cadb->{educacao}{grauEscolaridade},
                obito_infantil_ultimo_ano_id => $cadb->{saudeMulher}{obitoInfantilUltimoAno},
                qtd_gravidou_id => $cadb->{saudeMulher}{qtdGravidou},
                sexo_id => $cadb->{composicaoFamiliar}{sexo},
                situacao_conjugal_id => $cadb->{composicaoFamiliar}{situacaoConjugal},
                tempo_procurando_trabalho_id => $cadb->{trabalho}{tempoprocurandotrabalho},
                tipo_de_escola_id => $cadb->{educacao}{tipoDeEscola},
                informante_id => $cadb->{composicaoFamiliar}{informante},
                cursando_atualmente => $cadb->{educacao}{cursandoAtualmente},
                deseja_estudar => $cadb->{educacao}{desejaEstudar},
                fez_prevencao => $cadb->{saudeMulher}{fezPrevencao},
                possui_deficiencia_fisica => $cadb->{saude}{deficienciaFisica},
                possui_deficiencia_mental => $cadb->{saude}{deficienciaMental},
                possui_deficiencia_visual => $cadb->{saude}{deficienciaVisual},
                possui_deficiencia_auditiva => $cadb->{saude}{deficienciaAuditiva},
                esta_em_tratamento => $cadb->{saude}{emtratamento},
                documentos_rg => $cadb->{composicaoFamiliar}{documentos}{rg},
                documentos_cpf => $cadb->{composicaoFamiliar}{documentos}{cpf},
                documentos_titulo_eleitor => $cadb->{composicaoFamiliar}{documentos}{tituloDeEleitor},
                documentos_nis => $cadb->{composicaoFamiliar}{documentos}{nis},
                documentos_nao_possui_documento => $cadb->{composicaoFamiliar}{documentos}{naotem},
                opcoes_de_lazer_futebol => $cadb->{educacao}{opcoesDeLazer}{futebolOutrosEsportes},
                opcoes_de_lazer_sair_com_amigos => $cadb->{educacao}{opcoesDeLazer}{sairComVizinhos},
                opcoes_de_lazer_assistir_tv => $cadb->{educacao}{opcoesDeLazer}{assistirTV},
                opcoes_de_lazer_escutar_musica => $cadb->{educacao}{opcoesDeLazer}{escultarMusica},
                opcoes_de_lazer_festas => $cadb->{educacao}{opcoesDeLazer}{festas},
                opcoes_de_lazer_participar_organizacao => $cadb->{educacao}{opcoesDeLazer}{participarDeAlumaOrganizacao},
                opcoes_de_lazer_frequentar_bares => $cadb->{educacao}{opcoesDeLazer}{frequentarBares},
                opcoes_de_lazer_pracas => $cadb->{educacao}{opcoesDeLazer}{vaiaPracas},            
                tratamento_contraceptivo_camisinha => $cadb->{saudeMulher}{tratamentoContraceptivo}{pilula},
                tratamento_contraceptivo_diu => $cadb->{saudeMulher}{tratamentoContraceptivo}{diu},
                tratamento_contraceptivo_tabela => $cadb->{saudeMulher}{tratamentoContraceptivo}{tabela},
                tratamento_contraceptivo_pilula => $cadb->{saudeMulher}{tratamentoContraceptivo}{pilula},
                tratamento_contraceptivo_remedio_caseiro => $cadb->{saudeMulher}{tratamentoContraceptivo}{remedioCaseiro},
                tratamento_contraceptivo_nao => $cadb->{saudeMulher}{tratamentoContraceptivo}{nao},
                tratamento_contraceptivo_laqueadura => $cadb->{saudeMulher}{tratamentoContraceptivo}{laqueadura},
                historico_doencas_respiratoria => $cadb->{saude}{historicoDoencas}{doencasRespiratoria},
                historico_doencas_dengue => $cadb->{saude}{historicoDoencas}{dengue},
                historico_doencas_pele => $cadb->{saude}{historicoDoencas}{doencaPele},
                historico_doencas_virose => $cadb->{saude}{historicoDoencas}{virose},
                historico_doencas_verminose => $cadb->{saude}{historicoDoencas}{verminose},
                historico_doencas_usodrogas => $cadb->{saude}{historicoDoencas}{drogas},
                historico_doencas_alcoolismo => $cadb->{saude}{historicoDoencas}{alcoolismo},
                historico_doencas_nao_sei => $cadb->{saude}{historicoDoencas}{naosei},
                historico_doencas_diarreia => $cadb->{saude}{historicoDoencas}{diarreia},
                historico_doencas_nao_tem => $cadb->{saude}{historicoDoencas}{doencasnaotem},
                situacao_risco_pcl => $cadb->{saude}{situacaoRisco}{pcl},
                situacao_risco_doenca_de_chagas => $cadb->{saude}{situacaoRisco}{doencasChagas},
                situacao_risco_hanseniase => $cadb->{saude}{situacaoRisco}{hanseniase},
                situacao_risco_malaria => $cadb->{saude}{situacaoRisco}{malaria},
                situacao_risco_maustratos => $cadb->{saude}{situacaoRisco}{maustratosviolencia},
                situacao_risco_eplepsia => $cadb->{saude}{situacaoRisco}{epilepsia},
                situacao_risco_dst => $cadb->{saude}{situacaoRisco}{dst},
                situacao_risco_transtorno_psicologico => $cadb->{saude}{situacaoRisco}{transtornopisicologico},
                situacao_risco_tuberculose => $cadb->{saude}{situacaoRisco}{tuberculose},
                situacao_risco_diabetes => $cadb->{saude}{situacaoRisco}{diabetes},
                situacao_risco_tabagismo => $cadb->{saude}{situacaoRisco}{tabagismo},
                situacao_risco_hiv => $cadb->{saude}{situacaoRisco}{hivAids},
                situacao_risco_hipertencao => $cadb->{saude}{situacaoRisco}{hipertencao},
                situacao_risco_nao_tem => $cadb->{saude}{situacaoRisco}{fragilidadesnaotem},
                meio_transporte_trabalho_onibus => $cadb->{trabalho}{meioTransporteTrabalho}{onibus},
                meio_transporte_trabalho_trem => $cadb->{trabalho}{meioTransporteTrabalho}{trem},
                meio_transporte_trabalho_a_pe => $cadb->{trabalho}{meioTransporteTrabalho}{ape},
                meio_transporte_trabalho_bicicleta => $cadb->{trabalho}{meioTransporteTrabalho}{bicicleta},
                meio_transporte_trabalho_carro_moto => $cadb->{trabalho}{meioTransporteTrabalho}{carro},
                meio_transporte_trabalho_nao_se_aplica => $cadb->{trabalho}{meioTransporteTrabalho}{naoSeAplica},
                porque_nao_econtra_trabalho_por_conta_idade => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{idade},
                porque_nao_econtra_trabalho_nivel_educacional_exigido => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{nivelEscolaridade},
                porque_nao_econtra_trabalho_falta_capacitacao => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{faltaCapacitacao},
                porque_nao_econtra_trabalho_falta_experiencia => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{faltaExperiencia},
                porque_nao_econtra_trabalho_lugar_de_residencia => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{lugarResidencia},
                porque_nao_econtra_trabalho_nao_ha_trabalho => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{naoHaTrabalho},
                porque_nao_econtra_trabalho_outras_causastrabalhistas => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{outrasCausasTrabalhista},
                porque_nao_econtra_trabalho_outras_causas_pessoais => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{outrasCausasPessoais},
                porque_nao_econtra_trabalho_nao_ha_trabalho_sua_especialidade => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{naoHaTrabalhoEspecialidade},
                porque_nao_econtra_trabalho_problemas_de_saude => $cadb->{trabalho}{porqueNaoEcontraTrabalho}{problemasDeSaude},
                origem_renda_nao_se_aplica => $cadb->{renda}{origemRenda}{naoAplica},
                origem_renda_familiares => $cadb->{renda}{origemRenda}{familiares},
                origem_renda_igreja => $cadb->{renda}{origemRenda}{igreja},
                origem_renda_ong => $cadb->{renda}{origemRenda}{ongs},
                origem_renda_bolsa_familia => $cadb->{renda}{origemRenda}{bolsaFamilia},
                origem_renda_bpc_idoso => $cadb->{renda}{origemRenda}{bpcIdoso},
                origem_renda_bpc_pne => $cadb->{renda}{origemRenda}{bpcPne},
                origem_renda_pro_jovem => $cadb->{renda}{origemRenda}{projovem},
                origem_renda_familia_cidada => $cadb->{renda}{origemRenda}{familiaCidada},
                origem_renda_jovem_ambientalista => $cadb->{renda}{origemRenda}{jovemAmbientalista},
                origem_renda_salario => $cadb->{renda}{origemRenda}{salario},
                origem_renda_visinhoscomunidade => $cadb->{renda}{origemRenda}{vizinhoComunidade},
                renda_mensal => $cadb->{renda}{rendaMensal},
                endereco_id => $data->{formCadernoA}{enderecoImovel}{logradouro}
        })
    }
}

extract('19');
