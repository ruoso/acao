package Acao::Plugins::VilaDoMar::DimSchema::Result::FEntrevistaIndividualVilaDoMar;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::FEntrevistaIndividualVilaDoMar

=cut

__PACKAGE__->table("f_entrevista_individual_vila_do_mar");

=head1 ACCESSORS

=head2 unidade_medica_procurada_id

  data_type: 'integer'
  is_nullable: 1

=head2 causas_obitos_id

  data_type: 'integer'
  is_nullable: 1

=head2 data_id

  data_type: 'date'
  is_nullable: 1

=head2 motivo_de_para_de_estudar_id

  data_type: 'integer'
  is_nullable: 1

=head2 status_atual_id

  data_type: 'integer'
  is_nullable: 1

=head2 fez_prenatal_id

  data_type: 'integer'
  is_nullable: 1

=head2 grau_escolaridade_id

  data_type: 'integer'
  is_nullable: 1

=head2 obito_infantil_ultimo_ano_id

  data_type: 'integer'
  is_nullable: 1

=head2 qtd_gravidou_id

  data_type: 'integer'
  is_nullable: 1

=head2 sexo_id

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_conjugal_id

  data_type: 'integer'
  is_nullable: 1

=head2 tempo_procurando_trabalho_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_de_escola_id

  data_type: 'integer'
  is_nullable: 1

=head2 informante_id

  data_type: 'integer'
  is_nullable: 1

=head2 cursando_atualmente

  data_type: 'integer'
  is_nullable: 1

=head2 deseja_estudar

  data_type: 'integer'
  is_nullable: 1

=head2 fez_prevencao

  data_type: 'integer'
  is_nullable: 1

=head2 possui_deficiencia_fisica

  data_type: 'integer'
  is_nullable: 1

=head2 possui_deficiencia_mental

  data_type: 'integer'
  is_nullable: 1

=head2 possui_deficiencia_visual

  data_type: 'integer'
  is_nullable: 1

=head2 possui_deficiencia_auditiva

  data_type: 'integer'
  is_nullable: 1

=head2 esta_em_tratamento

  data_type: 'integer'
  is_nullable: 1

=head2 documentos_rg

  data_type: 'integer'
  is_nullable: 1

=head2 documentos_cpf

  data_type: 'integer'
  is_nullable: 1

=head2 documentos_titulo_eleitor

  data_type: 'integer'
  is_nullable: 1

=head2 documentos_nis

  data_type: 'integer'
  is_nullable: 1

=head2 documentos_nao_possui_documento

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_futebol

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_sair_com_amigos

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_assistir_tv

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_escutar_musica

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_festas

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_participar_organizacao

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_frequentar_bares

  data_type: 'integer'
  is_nullable: 1

=head2 opcoes_de_lazer_pracas

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_camisinha

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_diu

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_tabela

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_pilula

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_remedio_caseiro

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_nao

  data_type: 'integer'
  is_nullable: 1

=head2 tratamento_contraceptivo_laqueadura

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_respiratoria

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_dengue

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_pele

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_virose

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_verminose

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_usodrogas

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_alcoolismo

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_diarreia

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_nao_tem

  data_type: 'integer'
  is_nullable: 1

=head2 historico_doencas_nao_sei

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_pcl

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_doenca_de_chagas

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_hanseniase

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_malaria

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_maustratos

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_eplepsia

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_dst

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_transtorno_psicologico

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_tuberculose

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_diabetes

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_tabagismo

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_hiv

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_hipertencao

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_nao_tem

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_onibus

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_trem

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_a_pe

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_bicicleta

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_carro_moto

  data_type: 'integer'
  is_nullable: 1

=head2 meio_transporte_trabalho_nao_se_aplica

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_por_conta_idade

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_nivel_educacional_exigido

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_falta_capacitacao

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_falta_experiencia

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_lugar_de_residencia

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_nao_ha_trabalho

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_outras_causastrabalhistas

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_outras_causas_pessoais

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_nao_ha_trabalho_sua_especialidade

  data_type: 'integer'
  is_nullable: 1

=head2 porque_nao_econtra_trabalho_problemas_de_saude

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_nao_se_aplica

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_familiares

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_igreja

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_ong

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_bolsa_familia

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_bpc_idoso

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_bpc_pne

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_pro_jovem

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_familia_cidada

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_jovem_ambientalista

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_salario

  data_type: 'integer'
  is_nullable: 1

=head2 origem_renda_visinhoscomunidade

  data_type: 'integer'
  is_nullable: 1

=head2 renda_mensal

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "unidade_medica_procurada_id",
  { data_type => "integer", is_nullable => 1 },
  "causas_obitos_id",
  { data_type => "integer", is_nullable => 1 },
  "data_id",
  { data_type => "date", is_nullable => 1 },
  "motivo_de_para_de_estudar_id",
  { data_type => "integer", is_nullable => 1 },
  "status_atual_id",
  { data_type => "integer", is_nullable => 1 },
  "fez_prenatal_id",
  { data_type => "integer", is_nullable => 1 },
  "grau_escolaridade_id",
  { data_type => "integer", is_nullable => 1 },
  "obito_infantil_ultimo_ano_id",
  { data_type => "integer", is_nullable => 1 },
  "qtd_gravidou_id",
  { data_type => "integer", is_nullable => 1 },
  "sexo_id",
  { data_type => "integer", is_nullable => 1 },
  "situacao_conjugal_id",
  { data_type => "integer", is_nullable => 1 },
  "tempo_procurando_trabalho_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_de_escola_id",
  { data_type => "integer", is_nullable => 1 },
  "informante_id",
  { data_type => "integer", is_nullable => 1 },
  "cursando_atualmente",
  { data_type => "integer", is_nullable => 1 },
  "deseja_estudar",
  { data_type => "integer", is_nullable => 1 },
  "fez_prevencao",
  { data_type => "integer", is_nullable => 1 },
  "possui_deficiencia_fisica",
  { data_type => "integer", is_nullable => 1 },
  "possui_deficiencia_mental",
  { data_type => "integer", is_nullable => 1 },
  "possui_deficiencia_visual",
  { data_type => "integer", is_nullable => 1 },
  "possui_deficiencia_auditiva",
  { data_type => "integer", is_nullable => 1 },
  "esta_em_tratamento",
  { data_type => "integer", is_nullable => 1 },
  "documentos_rg",
  { data_type => "integer", is_nullable => 1 },
  "documentos_cpf",
  { data_type => "integer", is_nullable => 1 },
  "documentos_titulo_eleitor",
  { data_type => "integer", is_nullable => 1 },
  "documentos_nis",
  { data_type => "integer", is_nullable => 1 },
  "documentos_nao_possui_documento",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_futebol",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_sair_com_amigos",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_assistir_tv",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_escutar_musica",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_festas",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_participar_organizacao",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_frequentar_bares",
  { data_type => "integer", is_nullable => 1 },
  "opcoes_de_lazer_pracas",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_camisinha",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_diu",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_tabela",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_pilula",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_remedio_caseiro",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_nao",
  { data_type => "integer", is_nullable => 1 },
  "tratamento_contraceptivo_laqueadura",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_respiratoria",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_dengue",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_pele",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_virose",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_verminose",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_usodrogas",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_alcoolismo",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_diarreia",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_nao_tem",
  { data_type => "integer", is_nullable => 1 },
  "historico_doencas_nao_sei",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_pcl",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_doenca_de_chagas",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_hanseniase",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_malaria",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_maustratos",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_eplepsia",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_dst",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_transtorno_psicologico",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_tuberculose",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_diabetes",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_tabagismo",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_hiv",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_hipertencao",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_nao_tem",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_onibus",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_trem",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_a_pe",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_bicicleta",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_carro_moto",
  { data_type => "integer", is_nullable => 1 },
  "meio_transporte_trabalho_nao_se_aplica",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_por_conta_idade",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_nivel_educacional_exigido",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_falta_capacitacao",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_falta_experiencia",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_lugar_de_residencia",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_nao_ha_trabalho",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_outras_causastrabalhistas",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_outras_causas_pessoais",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_nao_ha_trabalho_sua_especialidade",
  { data_type => "integer", is_nullable => 1 },
  "porque_nao_econtra_trabalho_problemas_de_saude",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_nao_se_aplica",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_familiares",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_igreja",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_ong",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_bolsa_familia",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_bpc_idoso",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_bpc_pne",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_pro_jovem",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_familia_cidada",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_jovem_ambientalista",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_salario",
  { data_type => "integer", is_nullable => 1 },
  "origem_renda_visinhoscomunidade",
  { data_type => "integer", is_nullable => 1 },
  "renda_mensal",
  { data_type => "integer", is_nullable => 1 },
  "endereco_imovel_id",
  { data_type => "integer", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:50:02
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9lq7P15w0KqDvID6++Dk5g


# You can replace this text with custom content, and it will be preserved on regeneration
1;
