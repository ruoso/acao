package Acao::Plugins::SDH::DimSchema::Result::FAtendimento;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::SDH::DimSchema::Result::FAtendimento

=cut

__PACKAGE__->table("f_atendimento");

=head1 ACCESSORS

=head2 id_sexo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sexualidade

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_data

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_idade

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_endereco

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_raca_etnia

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_estado_civil

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 deficiencia_sensorial_surdo

  data_type: 'integer'
  is_nullable: 0

=head2 deficiencia_sensorial_cego

  data_type: 'integer'
  is_nullable: 0

=head2 deficiencia_fisico_motor

  data_type: 'integer'
  is_nullable: 0

=head2 deficiencia_mobilidade_reduzida

  data_type: 'integer'
  is_nullable: 0

=head2 deficiencia_intelectual

  data_type: 'integer'
  is_nullable: 0

=head2 id_registro_nascimento

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_identidade

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_cpf

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ctps

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_titulo_eleitor

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_reservista

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nis

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nocoes_informatica

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 habilidade_desenho

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_artesanato

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_grafite

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_costura

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_musica

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_literatura

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_teatro

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_culinaria

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_danca

  data_type: 'integer'
  is_nullable: 0

=head2 habilidade_pintura

  data_type: 'integer'
  is_nullable: 0

=head2 id_vinculo_religioso

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 situacao_moradia

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tempo_moradia

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 possui_banheiro

  data_type: 'integer'
  is_nullable: 0

=head2 id_tipo_iluminacao

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nucleo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_status_vinculacao_cca

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 violencia_intrafamiliar_discussao_verbal

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_agressao_fisica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_domestica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_abuso_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_exploracao_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_agressao_psicologica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_intrafamiliar_ameaca_morte

  data_type: 'integer'
  is_nullable: 0

=head2 id_sofre_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 sofre_violencia_instituicao_policial

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_instituicao_guarda_municipal

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_instituicao_escola

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_instituicao_posto_saude

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_discussao_verbal

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_agressao_fisica

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_abuso_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_exploracao_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_agressao_psicologica

  data_type: 'integer'
  is_nullable: 0

=head2 sofre_violencia_institucional_ameassa_morte

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_instituicao_policial

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_instituicao_guarda_municipal

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_instituicao_escola

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_instituicao_posto_saude

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_discussao_verbal

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_agressao_fisica

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_abuso_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_exploracao_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_agressao_psicologica

  data_type: 'integer'
  is_nullable: 0

=head2 sofreu_violencia_institucional_ameassa_morte

  data_type: 'integer'
  is_nullable: 0

=head2 id_frequencia_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_frequencia_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 violencia_ambito_comunitario_discussao_verbal

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_ambito_comunitario_agressao_fisica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_ambito_comunitario_abuso_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_ambito_comunitario_exploracao_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_ambito_comunitario_agressao_psicologica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_ambito_comunitario_ameaca_morte

  data_type: 'integer'
  is_nullable: 0

=head2 id_frequencia_violencia_ambito_comunitario

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 exploracao_qualquer_tipo_trabalho_infantil

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_domestico

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_catador

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_pedinte

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_malabarista

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_engraxate

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_flanelinha

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_jornaleiro

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_ajudante_pedreiro

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_comercio_drogas

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_infantil_pesca

  data_type: 'integer'
  is_nullable: 0

=head2 exploracao_trabalho_carvoaria

  data_type: 'integer'
  is_nullable: 0

=head2 inscrito_peti

  data_type: 'integer'
  is_nullable: 0

=head2 vivencia_rua

  data_type: 'integer'
  is_nullable: 0

=head2 id_uso_drogas

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_acompanhamento_uso_drogas

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 internado_comunidade_teraupeutica_uso_drogas

  data_type: 'integer'
  is_nullable: 0

=head2 deseja_tratamento_uso_drogas

  data_type: 'integer'
  is_nullable: 0

=head2 usa_metodo_contraceptivo

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_preservativo_masculino

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_preservativo_feminino

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_pilula_anticoncepcional

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_diu

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_tabela

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_temperatura_basal

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_metodo_biliing

  data_type: 'integer'
  is_nullable: 0

=head2 usa_contraceptivo_coito_interrompido

  data_type: 'integer'
  is_nullable: 0

=head2 id_contraceptivo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 frequenta_genecologista

  data_type: 'integer'
  is_nullable: 0

=head2 frequenta_urologista

  data_type: 'integer'
  is_nullable: 0

=head2 id_participacao_grupo_social

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 participacao_grupo_religioso

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_movimento_estudantil

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_associacao_bairro

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_movimento_politico

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_musical

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_esportivo

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_teatro

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_danca

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_defesa_meio_ambiente

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_cooperativa

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_ong

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupos_produtivos

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_movimento_cultural

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_organizacoes_lgbtt

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_movimento_mulheres

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_movimento_negro

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupo_rpg

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_grupos_rivais

  data_type: 'integer'
  is_nullable: 0

=head2 participacao_atividade_comunitaria

  data_type: 'integer'
  is_nullable: 0

=head2 id_tipo_escola_matriculado

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_escolaridade

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_frequencia_escolar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_rendimento_escolar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_acesso_medicacao

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_servico_saude

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_condicao_saude_familia

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 data_nascimento

  data_type: 'integer'
  is_nullable: 0

=head2 id_possui_banheiro

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 tipo_construcao_moradia_taipa_nao_resvestida

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_madeira

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_taipa_revestida

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_material_aproveitado

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_tijolo_alvenaria

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_abastecimento_agua_rede_publica

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_abastecimento_agua_poco_profundo

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_abastecimento_agua_cacimba

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_abastecimento_agua_carro_pipa

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_abastecimento_agua_rio_lagoa

  data_type: 'integer'
  is_nullable: 0

=head2 tratamento_agua_filtracao

  data_type: 'integer'
  is_nullable: 0

=head2 tratamento_agua_fervura

  data_type: 'integer'
  is_nullable: 0

=head2 tratamento_agua_cloracao

  data_type: 'integer'
  is_nullable: 0

=head2 tratamento_agua_sem_tratamento

  data_type: 'integer'
  is_nullable: 0

=head2 escoamento_sanitario_rede_publica

  data_type: 'integer'
  is_nullable: 0

=head2 escoamento_sanitario_fossa_rudimentar

  data_type: 'integer'
  is_nullable: 0

=head2 escoamento_sanitario_fossa_septica

  data_type: 'integer'
  is_nullable: 0

=head2 escoamento_sanitario_ceu_aberto

  data_type: 'integer'
  is_nullable: 0

=head2 destino_lixo_coleta

  data_type: 'integer'
  is_nullable: 0

=head2 destino_lixo_queima

  data_type: 'integer'
  is_nullable: 0

=head2 destino_lixo_queima_enterramento

  data_type: 'integer'
  is_nullable: 0

=head2 destino_lixo_ceu_aberto

  data_type: 'integer'
  is_nullable: 0

=head2 id_esta_frequentando_escola

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_escola_matriculado_proximo_residencia

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_criancas_familia_todas_matriculadas

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_participacao_atividade_escolar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_participacao_familia_escola

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ja_estagiou

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ja_trabalhou

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_esta_trabalhando

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_fez_curso_profissionalizante

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_interesse_curso_profissionalizante

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 origem_encaminhamento_associacoes

  data_type: 'text'
  is_nullable: 0
  original: {data_type => "varchar"}

=head2 origem_encaminhamento_conselho_tutelar

  data_type: 'integer'
  is_nullable: 0

=head2 origem_encaminhamento_demanda_espontanea

  data_type: 'integer'
  is_nullable: 0

=head2 origem_encaminhamento_judiciario

  data_type: 'integer'
  is_nullable: 0

=head2 origem_encaminhamento_programas_projetos_funci

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_adolescente_cidadao

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_aquarela

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_bromelia

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_casa_meninas

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_casa_meninos

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_cozinha_experimental

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_crescer_arte_cidadania

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_ddca

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_erradicacao_trabalho_infantil

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_estilo_solitario

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_ponte_encontro

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_se_garanta_liberdade_assitida

  data_type: 'integer'
  is_nullable: 0

=head2 vinculacao_cca_se_garanta_prestacao_servico_comunidade

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_intrafamiliar_procurou_instituicao

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_intrafamiliar_resolveu_conta_propia

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_intrafamiliar_procurou_amigos

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_intrafamiliar_nao_tomou_atitude

  data_type: 'integer'
  is_nullable: 0

=head2 teve_atendimento_especializado_contra_violencia_intrafamiliar

  data_type: 'integer'
  is_nullable: 0

=head2 esta_tendo_atendimento_especializado_contra_violencia_intrafami

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atendimento_especializado_contra_violencia_int

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_interesse_atendimento_especializado_contra_violencia_i

  data_type: 'integer'
  is_nullable: 0

=head2 id_sofre_violencia_ambiente_comunitario

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_ambiente_comunitario

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 contra_violencia_comunitaria_procurou_instituicao

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_comunitaria_resolveu_conta_propria

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_comunitaria_procurou_amigos

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_comunitaria_nao_tomou_atitude

  data_type: 'integer'
  is_nullable: 0

=head2 teve_atendimento_especializado_contra_violencia_comunitaria

  data_type: 'integer'
  is_nullable: 0

=head2 esta_tendo_atendimento_especializado_contra_violencia_comunitar

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atendimento_especializado_contra_violencia_com

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_atendimento_especializado_contra_violencia_comunitaria

  data_type: 'integer'
  is_nullable: 0

=head2 id_sofreu_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 contra_violencia_institucional_procurou_instituicao

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_institucional_resolveu_conta_propia

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_institucional_procurou_amigos

  data_type: 'integer'
  is_nullable: 0

=head2 contra_violencia_institucional_nao_tomou_atitude

  data_type: 'integer'
  is_nullable: 0

=head2 teve_atendimento_especializado_contra_violencia_institucional

  data_type: 'integer'
  is_nullable: 0

=head2 esta_tendo_atendimento_especializado_contra_violencia_instituci

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atendimento_especializado_contra_violencia_ins

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_atendimento_especializado_contra_violencia_institucion

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_sexo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_sexualidade",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_data",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_idade",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_endereco",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_raca_etnia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_estado_civil",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "deficiencia_sensorial_surdo",
  { data_type => "integer", is_nullable => 0 },
  "deficiencia_sensorial_cego",
  { data_type => "integer", is_nullable => 0 },
  "deficiencia_fisico_motor",
  { data_type => "integer", is_nullable => 0 },
  "deficiencia_mobilidade_reduzida",
  { data_type => "integer", is_nullable => 0 },
  "deficiencia_intelectual",
  { data_type => "integer", is_nullable => 0 },
  "id_registro_nascimento",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_identidade",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_cpf",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_ctps",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_titulo_eleitor",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_reservista",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_nis",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_nocoes_informatica",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "habilidade_desenho",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_artesanato",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_grafite",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_costura",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_musica",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_literatura",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_teatro",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_culinaria",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_danca",
  { data_type => "integer", is_nullable => 0 },
  "habilidade_pintura",
  { data_type => "integer", is_nullable => 0 },
  "id_vinculo_religioso",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "situacao_moradia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_tempo_moradia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "possui_banheiro",
  { data_type => "integer", is_nullable => 0 },
  "id_tipo_iluminacao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_nucleo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_status_vinculacao_cca",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_sofre_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_sofreu_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "violencia_intrafamiliar_discussao_verbal",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_agressao_fisica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_domestica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_abuso_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_exploracao_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_agressao_psicologica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_intrafamiliar_ameaca_morte",
  { data_type => "integer", is_nullable => 0 },
  "id_sofre_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "sofre_violencia_instituicao_policial",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_guarda_municipal",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_escola",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_posto_saude",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_discussao_verbal",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_agressao_fisica",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_abuso_sexual",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_exploracao_sexual",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_agressao_psicologica",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_institucional_ameassa_morte",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_policial",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_guarda_municipal",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_escola",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_posto_saude",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_discussao_verbal",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_agressao_fisica",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_abuso_sexual",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_exploracao_sexual",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_agressao_psicologica",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_institucional_ameassa_morte",
  { data_type => "integer", is_nullable => 0 },
  "id_frequencia_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_frequencia_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "violencia_ambito_comunitario_discussao_verbal",
  { data_type => "integer", is_nullable => 0 },
  "violencia_ambito_comunitario_agressao_fisica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_ambito_comunitario_abuso_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_ambito_comunitario_exploracao_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_ambito_comunitario_agressao_psicologica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_ambito_comunitario_ameaca_morte",
  { data_type => "integer", is_nullable => 0 },
  "id_frequencia_violencia_ambito_comunitario",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "exploracao_qualquer_tipo_trabalho_infantil",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_domestico",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_catador",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_pedinte",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_malabarista",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_engraxate",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_flanelinha",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_jornaleiro",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_ajudante_pedreiro",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_comercio_drogas",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_infantil_pesca",
  { data_type => "integer", is_nullable => 0 },
  "exploracao_trabalho_carvoaria",
  { data_type => "integer", is_nullable => 0 },
  "inscrito_peti",
  { data_type => "integer", is_nullable => 0 },
  "vivencia_rua",
  { data_type => "integer", is_nullable => 0 },
  "id_uso_drogas",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_acompanhamento_uso_drogas",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "internado_comunidade_teraupeutica_uso_drogas",
  { data_type => "integer", is_nullable => 0 },
  "deseja_tratamento_uso_drogas",
  { data_type => "integer", is_nullable => 0 },
  "usa_metodo_contraceptivo",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_preservativo_masculino",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_preservativo_feminino",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_pilula_anticoncepcional",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_diu",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_tabela",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_temperatura_basal",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_metodo_biliing",
  { data_type => "integer", is_nullable => 0 },
  "usa_contraceptivo_coito_interrompido",
  { data_type => "integer", is_nullable => 0 },
  "id_contraceptivo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "frequenta_genecologista",
  { data_type => "integer", is_nullable => 0 },
  "frequenta_urologista",
  { data_type => "integer", is_nullable => 0 },
  "id_participacao_grupo_social",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "participacao_grupo_religioso",
  { data_type => "integer", is_nullable => 0 },
  "participacao_movimento_estudantil",
  { data_type => "integer", is_nullable => 0 },
  "participacao_associacao_bairro",
  { data_type => "integer", is_nullable => 0 },
  "participacao_movimento_politico",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_musical",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_esportivo",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_teatro",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_danca",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_defesa_meio_ambiente",
  { data_type => "integer", is_nullable => 0 },
  "participacao_cooperativa",
  { data_type => "integer", is_nullable => 0 },
  "participacao_ong",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupos_produtivos",
  { data_type => "integer", is_nullable => 0 },
  "participacao_movimento_cultural",
  { data_type => "integer", is_nullable => 0 },
  "participacao_organizacoes_lgbtt",
  { data_type => "integer", is_nullable => 0 },
  "participacao_movimento_mulheres",
  { data_type => "integer", is_nullable => 0 },
  "participacao_movimento_negro",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupo_rpg",
  { data_type => "integer", is_nullable => 0 },
  "participacao_grupos_rivais",
  { data_type => "integer", is_nullable => 0 },
  "participacao_atividade_comunitaria",
  { data_type => "integer", is_nullable => 0 },
  "id_tipo_escola_matriculado",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_escolaridade",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_auto_avaliacao_frequencia_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_auto_avaliacao_rendimento_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_acesso_medicacao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_servico_saude",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_condicao_saude_familia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "data_nascimento",
  { data_type => "integer", is_nullable => 0 },
  "id_possui_banheiro",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tipo_construcao_moradia_taipa_nao_resvestida",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_madeira",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_taipa_revestida",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_material_aproveitado",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_tijolo_alvenaria",
  { data_type => "integer", is_nullable => 0 },
  "tipo_abastecimento_agua_rede_publica",
  { data_type => "integer", is_nullable => 0 },
  "tipo_abastecimento_agua_poco_profundo",
  { data_type => "integer", is_nullable => 0 },
  "tipo_abastecimento_agua_cacimba",
  { data_type => "integer", is_nullable => 0 },
  "tipo_abastecimento_agua_carro_pipa",
  { data_type => "integer", is_nullable => 0 },
  "tipo_abastecimento_agua_rio_lagoa",
  { data_type => "integer", is_nullable => 0 },
  "tratamento_agua_filtracao",
  { data_type => "integer", is_nullable => 0 },
  "tratamento_agua_fervura",
  { data_type => "integer", is_nullable => 0 },
  "tratamento_agua_cloracao",
  { data_type => "integer", is_nullable => 0 },
  "tratamento_agua_sem_tratamento",
  { data_type => "integer", is_nullable => 0 },
  "escoamento_sanitario_rede_publica",
  { data_type => "integer", is_nullable => 0 },
  "escoamento_sanitario_fossa_rudimentar",
  { data_type => "integer", is_nullable => 0 },
  "escoamento_sanitario_fossa_septica",
  { data_type => "integer", is_nullable => 0 },
  "escoamento_sanitario_ceu_aberto",
  { data_type => "integer", is_nullable => 0 },
  "destino_lixo_coleta",
  { data_type => "integer", is_nullable => 0 },
  "destino_lixo_queima",
  { data_type => "integer", is_nullable => 0 },
  "destino_lixo_queima_enterramento",
  { data_type => "integer", is_nullable => 0 },
  "destino_lixo_ceu_aberto",
  { data_type => "integer", is_nullable => 0 },
  "id_esta_frequentando_escola",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_escola_matriculado_proximo_residencia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_criancas_familia_todas_matriculadas",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_auto_avaliacao_participacao_atividade_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_auto_avaliacao_participacao_familia_escola",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_ja_estagiou",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_ja_trabalhou",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_esta_trabalhando",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_fez_curso_profissionalizante",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_interesse_curso_profissionalizante",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "origem_encaminhamento_associacoes",
  {
    data_type   => "text",
    is_nullable => 0,
    original    => { data_type => "varchar" },
  },
  "origem_encaminhamento_conselho_tutelar",
  { data_type => "integer", is_nullable => 0 },
  "origem_encaminhamento_demanda_espontanea",
  { data_type => "integer", is_nullable => 0 },
  "origem_encaminhamento_judiciario",
  { data_type => "integer", is_nullable => 0 },
  "origem_encaminhamento_programas_projetos_funci",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_adolescente_cidadao",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_aquarela",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_bromelia",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_casa_meninas",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_casa_meninos",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_cozinha_experimental",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_crescer_arte_cidadania",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_ddca",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_erradicacao_trabalho_infantil",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_estilo_solitario",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_ponte_encontro",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_se_garanta_liberdade_assitida",
  { data_type => "integer", is_nullable => 0 },
  "vinculacao_cca_se_garanta_prestacao_servico_comunidade",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_intrafamiliar_procurou_instituicao",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_intrafamiliar_resolveu_conta_propia",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_intrafamiliar_procurou_amigos",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_intrafamiliar_nao_tomou_atitude",
  { data_type => "integer", is_nullable => 0 },
  "teve_atendimento_especializado_contra_violencia_intrafamiliar",
  { data_type => "integer", is_nullable => 0 },
  "esta_tendo_atendimento_especializado_contra_violencia_intrafami",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atendimento_especializado_contra_violencia_int",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_interesse_atendimento_especializado_contra_violencia_i",
  { data_type => "integer", is_nullable => 0 },
  "id_sofre_violencia_ambiente_comunitario",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_sofreu_violencia_ambiente_comunitario",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "contra_violencia_comunitaria_procurou_instituicao",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_comunitaria_resolveu_conta_propria",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_comunitaria_procurou_amigos",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_comunitaria_nao_tomou_atitude",
  { data_type => "integer", is_nullable => 0 },
  "teve_atendimento_especializado_contra_violencia_comunitaria",
  { data_type => "integer", is_nullable => 0 },
  "esta_tendo_atendimento_especializado_contra_violencia_comunitar",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atendimento_especializado_contra_violencia_com",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_atendimento_especializado_contra_violencia_comunitaria",
  { data_type => "integer", is_nullable => 0 },
  "id_sofreu_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "contra_violencia_institucional_procurou_instituicao",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_institucional_resolveu_conta_propia",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_institucional_procurou_amigos",
  { data_type => "integer", is_nullable => 0 },
  "contra_violencia_institucional_nao_tomou_atitude",
  { data_type => "integer", is_nullable => 0 },
  "teve_atendimento_especializado_contra_violencia_institucional",
  { data_type => "integer", is_nullable => 0 },
  "esta_tendo_atendimento_especializado_contra_violencia_instituci",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atendimento_especializado_contra_violencia_ins",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_atendimento_especializado_contra_violencia_institucion",
  { data_type => "integer", is_nullable => 0 },
);

=head1 RELATIONS

=head2 id_sofreu_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaIntrafamiliar",
  {
    id_sofreu_violencia_intrafamiliar => "id_sofreu_violencia_intrafamiliar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_frequencia_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_frequencia_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaIntrafamiliar",
  {
    id_frequencia_violencia_intrafamiliar => "id_frequencia_violencia_intrafamiliar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_estado_civil

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEstadoCivil>

=cut

__PACKAGE__->belongs_to(
  "id_estado_civil",
  "Acao::Plugins::SDH::DimSchema::Result::DEstadoCivil",
  { id_estado_civil => "id_estado_civil" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_cpf

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DCpf>

=cut

__PACKAGE__->belongs_to(
  "id_cpf",
  "Acao::Plugins::SDH::DimSchema::Result::DCpf",
  { id_cpf => "id_cpf" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_nucleo

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DNucleo>

=cut

__PACKAGE__->belongs_to(
  "id_nucleo",
  "Acao::Plugins::SDH::DimSchema::Result::DNucleo",
  { id_nucleo => "id_nucleo" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sexualidade

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSexualidade>

=cut

__PACKAGE__->belongs_to(
  "id_sexualidade",
  "Acao::Plugins::SDH::DimSchema::Result::DSexualidade",
  { id_sexualidade => "id_sexualidade" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_raca_etnia

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DRacaEtnia>

=cut

__PACKAGE__->belongs_to(
  "id_raca_etnia",
  "Acao::Plugins::SDH::DimSchema::Result::DRacaEtnia",
  { id_raca_etnia => "id_raca_etnia" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambiente_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbienteComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambiente_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbienteComunitario",
  {
    id_sofre_violencia_ambiente_comunitario => "id_sofre_violencia_ambiente_comunitario",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_titulo_eleitor

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTituloEleitor>

=cut

__PACKAGE__->belongs_to(
  "id_titulo_eleitor",
  "Acao::Plugins::SDH::DimSchema::Result::DTituloEleitor",
  { id_titulo_eleitor => "id_titulo_eleitor" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_tipo_escola_matriculado

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTipoEscolaMatriculado>

=cut

__PACKAGE__->belongs_to(
  "id_tipo_escola_matriculado",
  "Acao::Plugins::SDH::DimSchema::Result::DTipoEscolaMatriculado",
  { id_tipo_escola_matriculado => "id_tipo_escola_matriculado" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_interesse_curso_profissionalizante

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DInteresseCursoProfissionalizante>

=cut

__PACKAGE__->belongs_to(
  "id_interesse_curso_profissionalizante",
  "Acao::Plugins::SDH::DimSchema::Result::DInteresseCursoProfissionalizante",
  {
    id_interesse_curso_profissionalizante => "id_interesse_curso_profissionalizante",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 situacao_moradia

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSituacaoMoradia>

=cut

__PACKAGE__->belongs_to(
  "situacao_moradia",
  "Acao::Plugins::SDH::DimSchema::Result::DSituacaoMoradia",
  { id_situacao_moradia => "situacao_moradia" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_reservista

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DReservista>

=cut

__PACKAGE__->belongs_to(
  "id_reservista",
  "Acao::Plugins::SDH::DimSchema::Result::DReservista",
  { id_reservista => "id_reservista" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_frequencia_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_frequencia_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaInstitucional",
  {
    id_frequencia_violencia_institucional => "id_frequencia_violencia_institucional",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofreu_violencia_ambiente_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaAmbienteComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_ambiente_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaAmbienteComunitario",
  {
    id_sofreu_violencia_ambiente_comunitario => "id_sofreu_violencia_ambiente_comunitario",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_auto_avaliacao_participacao_familia_escola

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoParticipacaoFamiliaEscola>

=cut

__PACKAGE__->belongs_to(
  "id_auto_avaliacao_participacao_familia_escola",
  "Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoParticipacaoFamiliaEscola",
  {
    id_auto_avaliacao_participacao_familia_escola => "id_auto_avaliacao_participacao_familia_escola",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_acesso_medicacao

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAcessoMedicacao>

=cut

__PACKAGE__->belongs_to(
  "id_acesso_medicacao",
  "Acao::Plugins::SDH::DimSchema::Result::DAcessoMedicacao",
  { id_acesso_medicacao => "id_acesso_medicacao" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sexo

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSexo>

=cut

__PACKAGE__->belongs_to(
  "id_sexo",
  "Acao::Plugins::SDH::DimSchema::Result::DSexo",
  { id_sexo => "id_sexo" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_endereco

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEndereco>

=cut

__PACKAGE__->belongs_to(
  "id_endereco",
  "Acao::Plugins::SDH::DimSchema::Result::DEndereco",
  { id_endereco => "id_endereco" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_auto_avaliacao_frequencia_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoFrequenciaEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_auto_avaliacao_frequencia_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoFrequenciaEscolar",
  {
    id_auto_avaliacao_frequencia_escolar => "id_auto_avaliacao_frequencia_escolar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_ni

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DNi>

=cut

__PACKAGE__->belongs_to(
  "id_ni",
  "Acao::Plugins::SDH::DimSchema::Result::DNi",
  { id_nis => "id_nis" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_esta_trabalhando

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEstaTrabalhando>

=cut

__PACKAGE__->belongs_to(
  "id_esta_trabalhando",
  "Acao::Plugins::SDH::DimSchema::Result::DEstaTrabalhando",
  { id_esta_trabalhando => "id_esta_trabalhando" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_vinculo_religioso

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DVinculoReligioso>

=cut

__PACKAGE__->belongs_to(
  "id_vinculo_religioso",
  "Acao::Plugins::SDH::DimSchema::Result::DVinculoReligioso",
  { id_vinculo_religioso => "id_vinculo_religioso" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_fez_curso_profissionalizante

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFezCursoProfissionalizante>

=cut

__PACKAGE__->belongs_to(
  "id_fez_curso_profissionalizante",
  "Acao::Plugins::SDH::DimSchema::Result::DFezCursoProfissionalizante",
  {
    id_fez_curso_profissionalizante => "id_fez_curso_profissionalizante",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_identidade

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DIdentidade>

=cut

__PACKAGE__->belongs_to(
  "id_identidade",
  "Acao::Plugins::SDH::DimSchema::Result::DIdentidade",
  { id_identidade => "id_identidade" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_idade

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DIdade>

=cut

__PACKAGE__->belongs_to(
  "id_idade",
  "Acao::Plugins::SDH::DimSchema::Result::DIdade",
  { id_idade => "id_idade" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucional",
  {
    id_sofre_violencia_institucional => "id_sofre_violencia_institucional",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_nocoes_informatica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DNocoesInformatica>

=cut

__PACKAGE__->belongs_to(
  "id_nocoes_informatica",
  "Acao::Plugins::SDH::DimSchema::Result::DNocoesInformatica",
  { id_nocoes_informatica => "id_nocoes_informatica" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_criancas_familia_todas_matriculada

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DCriancasFamiliaTodasMatriculada>

=cut

__PACKAGE__->belongs_to(
  "id_criancas_familia_todas_matriculada",
  "Acao::Plugins::SDH::DimSchema::Result::DCriancasFamiliaTodasMatriculada",
  {
    id_criancas_familia_todas_matriculadas => "id_criancas_familia_todas_matriculadas",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_contraceptivo

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DContraceptivo>

=cut

__PACKAGE__->belongs_to(
  "id_contraceptivo",
  "Acao::Plugins::SDH::DimSchema::Result::DContraceptivo",
  { id_contraceptivo => "id_contraceptivo" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_esta_frequentando_escola

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEstaFrequentandoEscola>

=cut

__PACKAGE__->belongs_to(
  "id_esta_frequentando_escola",
  "Acao::Plugins::SDH::DimSchema::Result::DEstaFrequentandoEscola",
  { id_esta_frequentando_escola => "id_esta_frequentando_escola" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_auto_avaliacao_rendimento_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoRendimentoEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_auto_avaliacao_rendimento_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoRendimentoEscolar",
  {
    id_auto_avaliacao_rendimento_escolar => "id_auto_avaliacao_rendimento_escolar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_ctp

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DCtp>

=cut

__PACKAGE__->belongs_to(
  "id_ctp",
  "Acao::Plugins::SDH::DimSchema::Result::DCtp",
  { id_ctps => "id_ctps" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_auto_avaliacao_participacao_atividade_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoParticipacaoAtividadeEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_auto_avaliacao_participacao_atividade_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAutoAvaliacaoParticipacaoAtividadeEscolar",
  {
    id_auto_avaliacao_participacao_atividade_escolar => "id_auto_avaliacao_participacao_atividade_escolar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_uso_droga

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsoDroga>

=cut

__PACKAGE__->belongs_to(
  "id_uso_droga",
  "Acao::Plugins::SDH::DimSchema::Result::DUsoDroga",
  { id_uso_drogas => "id_uso_drogas" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_participacao_grupo_social

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DParticipacaoGrupoSocial>

=cut

__PACKAGE__->belongs_to(
  "id_participacao_grupo_social",
  "Acao::Plugins::SDH::DimSchema::Result::DParticipacaoGrupoSocial",
  { id_participacao_grupo_social => "id_participacao_grupo_social" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_avaliacao_servico_saude

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoServicoSaude>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_servico_saude",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoServicoSaude",
  { id_avaliacao_servico_saude => "id_avaliacao_servico_saude" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_acompanhamento_uso_droga

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAcompanhamentoUsoDroga>

=cut

__PACKAGE__->belongs_to(
  "id_acompanhamento_uso_droga",
  "Acao::Plugins::SDH::DimSchema::Result::DAcompanhamentoUsoDroga",
  { id_acompanhamento_uso_drogas => "id_acompanhamento_uso_drogas" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_tempo_moradia

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTempoMoradia>

=cut

__PACKAGE__->belongs_to(
  "id_tempo_moradia",
  "Acao::Plugins::SDH::DimSchema::Result::DTempoMoradia",
  { id_tempo_moradia => "id_tempo_moradia" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_avaliacao_condicao_saude_familia

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoCondicaoSaudeFamilia>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_condicao_saude_familia",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoCondicaoSaudeFamilia",
  {
    id_avaliacao_condicao_saude_familia => "id_avaliacao_condicao_saude_familia",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_possui_banheiro

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DPossuiBanheiro>

=cut

__PACKAGE__->belongs_to(
  "id_possui_banheiro",
  "Acao::Plugins::SDH::DimSchema::Result::DPossuiBanheiro",
  { id_possui_banheiro => "id_possui_banheiro" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_ja_estagiou

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DJaEstagiou>

=cut

__PACKAGE__->belongs_to(
  "id_ja_estagiou",
  "Acao::Plugins::SDH::DimSchema::Result::DJaEstagiou",
  { id_ja_estagiou => "id_ja_estagiou" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_frequencia_violencia_ambito_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaAmbitoComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_frequencia_violencia_ambito_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DFrequenciaViolenciaAmbitoComunitario",
  {
    id_frequencia_violencia_ambito_comunitario => "id_frequencia_violencia_ambito_comunitario",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_tipo_iluminacao

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTipoIluminacao>

=cut

__PACKAGE__->belongs_to(
  "id_tipo_iluminacao",
  "Acao::Plugins::SDH::DimSchema::Result::DTipoIluminacao",
  { id_tipo_iluminacao => "id_tipo_iluminacao" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_data

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DData>

=cut

__PACKAGE__->belongs_to(
  "id_data",
  "Acao::Plugins::SDH::DimSchema::Result::DData",
  { id_data => "id_data" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_escola_matriculado_proximo_residencia

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEscolaMatriculadoProximoResidencia>

=cut

__PACKAGE__->belongs_to(
  "id_escola_matriculado_proximo_residencia",
  "Acao::Plugins::SDH::DimSchema::Result::DEscolaMatriculadoProximoResidencia",
  {
    id_escola_matriculado_proximo_residencia => "id_escola_matriculado_proximo_residencia",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliar",
  {
    id_sofre_violencia_intrafamiliar => "id_sofre_violencia_intrafamiliar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_registro_nascimento

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DRegistroNascimento>

=cut

__PACKAGE__->belongs_to(
  "id_registro_nascimento",
  "Acao::Plugins::SDH::DimSchema::Result::DRegistroNascimento",
  { id_registro_nascimento => "id_registro_nascimento" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_status_vinculacao_cca

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DStatusVinculacaoCca>

=cut

__PACKAGE__->belongs_to(
  "id_status_vinculacao_cca",
  "Acao::Plugins::SDH::DimSchema::Result::DStatusVinculacaoCca",
  { id_status_vinculacao_cca => "id_status_vinculacao_cca" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofreu_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucional",
  {
    id_sofreu_violencia_institucional => "id_sofreu_violencia_institucional",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_ja_trabalhou

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DJaTrabalhou>

=cut

__PACKAGE__->belongs_to(
  "id_ja_trabalhou",
  "Acao::Plugins::SDH::DimSchema::Result::DJaTrabalhou",
  { id_ja_trabalhou => "id_ja_trabalhou" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_escolaridade

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEscolaridade>

=cut

__PACKAGE__->belongs_to(
  "id_escolaridade",
  "Acao::Plugins::SDH::DimSchema::Result::DEscolaridade",
  { id_escolaridade => "id_escolaridade" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-21 11:36:06
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8Y+S7bUh90hbEDnVe+5fGw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
