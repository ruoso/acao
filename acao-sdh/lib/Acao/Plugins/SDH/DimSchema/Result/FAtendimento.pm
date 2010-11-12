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
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sexualidade

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_data

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_idade

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_endereco

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_raca_etnia

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_estado_civil

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_registro_nascimento

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_identidade

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_cpf

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ctps

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_titulo_eleitor

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_reservista

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nis

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nocoes_informatica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_vinculo_religioso

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 situacao_moradia

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tempo_moradia

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tipo_iluminacao

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_status_vinculacao_cca

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_intrafamiliar

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_contraceptivo

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_participacao_grupo_social

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tipo_escola_matriculado

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_escolaridade

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_frequencia_escolar

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_rendimento_escolar

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_acesso_medicacao

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_servico_saude

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_condicao_saude_familia

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_esta_frequentando_escola

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_escola_matriculado_proximo_residencia

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_criancas_familia_todas_matriculadas

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_participacao_atividade_escolar

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_auto_avaliacao_participacao_familia_escola

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ja_estagiou

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_ja_trabalhou

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_esta_trabalhando

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_fez_curso_profissionalizante

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_interesse_curso_profissionalizante

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambiente_comunitario

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_ambiente_comunitario

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_alcool

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_cigarro

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_maconha

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_cocaina

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_mesclado

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_crack

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_comprimidos

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_cola

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_usa_inalantes

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_frequenta_ginecologista_regularmente

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_frequenta_urologista_regularmente

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_ameaca_morte

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_agressao_psicologica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_exploracao_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_abuso_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_agressao_fisica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_ambito_comunitario_discussao_verbal

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_ameaca_morte

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_agressao_psicologica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_exploracao_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_abuso_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_agressao_fisica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofreu_violencia_institucional_discussao_verbal

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_ameaca_morte

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_agressao_psicologica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_exploracao_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_abuso_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_agressao_fisica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_institucional_discussao_verbal

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_ameaca_morte

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_agressao_psicologica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_exploracao_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_abuso_sexual

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_agressao_fisica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_discussao_verbal

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_sofre_violencia_intrafamiliar_domestica

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_turno_estuda

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_possui_banheiro

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_exploracao_trabalho_infantil

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_vivencia_rua

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_inscrito_peti

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_deseja_tratamento_uso_drogas

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_recebe_medicamento_quando_necessario

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_foi_internado_comunidade_terapeutica_uso_droga

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_participacao_atividade_comunitaria

  data_type: 'integer'
  default_value: 0
  is_foreign_key: 1
  is_nullable: 0

=head2 id_regional

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

=head2 data_nascimento

  data_type: 'integer'
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

=head2 destino_lixo_enterramento

  data_type: 'integer'
  is_nullable: 0

=head2 destino_lixo_ceu_aberto

  data_type: 'integer'
  is_nullable: 0

=head2 origem_encaminhamento_associacoes

  data_type: 'integer'
  is_nullable: 0

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

=head2 esta_tendo_atend_especializado_contra_violencia_intrafamiliar

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atend_especial_contra_violencia_intrafamiliar

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_atend_especializado_contra_violencia_intrafamiliar

  data_type: 'integer'
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

=head2 esta_tendo_atend_especializado_contra_violencia_comunitaria

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atend_especial_contra_violencia_comunitaria

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_atend_especializado_contra_violencia_comunitaria

  data_type: 'integer'
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

=head2 esta_tendo_atend_especializado_contra_violencia_institucional

  data_type: 'integer'
  is_nullable: 0

=head2 nao_tem_gostaria_atend_especializado_contra_violencia_instituci

  data_type: 'integer'
  is_nullable: 0

=head2 nao_quer_atend_especializado_contra_violencia_institucional

  data_type: 'integer'
  is_nullable: 0

=head2 nunca_fez_acompanhamento_contra_drogas

  data_type: 'integer'
  is_nullable: 0

=head2 fez_acompanhamento_contra_drogas_capsad

  data_type: 'integer'
  is_nullable: 0

=head2 fez_acompanhamento_contra_drogas_capsi

  data_type: 'integer'
  is_nullable: 0

=head2 fez_acompanhamento_contra_drogas_hospital_mental

  data_type: 'integer'
  is_nullable: 0

=head2 faz_acompanhamento_contra_drogas_hospital_mental

  data_type: 'integer'
  is_nullable: 0

=head2 faz_acompanhamento_contra_drogas_capsad

  data_type: 'integer'
  is_nullable: 0

=head2 faz_acompanhamento_contra_drogas_capsi

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id_sexo",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sexualidade",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_data",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_idade",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_endereco",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_raca_etnia",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_estado_civil",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_registro_nascimento",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_identidade",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_cpf",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_ctps",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_titulo_eleitor",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_reservista",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_nis",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_nocoes_informatica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_vinculo_religioso",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "situacao_moradia",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_tempo_moradia",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_tipo_iluminacao",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_status_vinculacao_cca",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_intrafamiliar",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_contraceptivo",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_participacao_grupo_social",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_tipo_escola_matriculado",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_escolaridade",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_auto_avaliacao_frequencia_escolar",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_auto_avaliacao_rendimento_escolar",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_avaliacao_acesso_medicacao",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_avaliacao_servico_saude",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_avaliacao_condicao_saude_familia",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_esta_frequentando_escola",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_escola_matriculado_proximo_residencia",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_criancas_familia_todas_matriculadas",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_auto_avaliacao_participacao_atividade_escolar",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_auto_avaliacao_participacao_familia_escola",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_ja_estagiou",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_ja_trabalhou",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_esta_trabalhando",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_fez_curso_profissionalizante",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_interesse_curso_profissionalizante",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambiente_comunitario",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_ambiente_comunitario",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_alcool",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_cigarro",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_maconha",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_cocaina",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_mesclado",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_crack",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_comprimidos",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_cola",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_usa_inalantes",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_frequenta_ginecologista_regularmente",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_frequenta_urologista_regularmente",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_ameaca_morte",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_agressao_psicologica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_exploracao_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_abuso_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_agressao_fisica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_ambito_comunitario_discussao_verbal",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_ameaca_morte",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_agressao_psicologica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_exploracao_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_abuso_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_agressao_fisica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofreu_violencia_institucional_discussao_verbal",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_ameaca_morte",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_agressao_psicologica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_exploracao_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_abuso_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_agressao_fisica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_institucional_discussao_verbal",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_ameaca_morte",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_agressao_psicologica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_exploracao_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_abuso_sexual",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_agressao_fisica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_discussao_verbal",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_sofre_violencia_intrafamiliar_domestica",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_turno_estuda",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_possui_banheiro",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_exploracao_trabalho_infantil",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_vivencia_rua",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_inscrito_peti",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_deseja_tratamento_uso_drogas",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_recebe_medicamento_quando_necessario",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_foi_internado_comunidade_terapeutica_uso_droga",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_participacao_atividade_comunitaria",
  {
    data_type      => "integer",
    default_value  => 0,
    is_foreign_key => 1,
    is_nullable    => 0,
  },
  "id_regional",
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
  "sofre_violencia_instituicao_policial",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_guarda_municipal",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_escola",
  { data_type => "integer", is_nullable => 0 },
  "sofre_violencia_instituicao_posto_saude",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_policial",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_guarda_municipal",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_escola",
  { data_type => "integer", is_nullable => 0 },
  "sofreu_violencia_instituicao_posto_saude",
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
  "data_nascimento",
  { data_type => "integer", is_nullable => 0 },
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
  "destino_lixo_enterramento",
  { data_type => "integer", is_nullable => 0 },
  "destino_lixo_ceu_aberto",
  { data_type => "integer", is_nullable => 0 },
  "origem_encaminhamento_associacoes",
  { data_type => "integer", is_nullable => 0 },
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
  "esta_tendo_atend_especializado_contra_violencia_intrafamiliar",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atend_especial_contra_violencia_intrafamiliar",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_atend_especializado_contra_violencia_intrafamiliar",
  { data_type => "integer", is_nullable => 0 },
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
  "esta_tendo_atend_especializado_contra_violencia_comunitaria",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atend_especial_contra_violencia_comunitaria",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_atend_especializado_contra_violencia_comunitaria",
  { data_type => "integer", is_nullable => 0 },
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
  "esta_tendo_atend_especializado_contra_violencia_institucional",
  { data_type => "integer", is_nullable => 0 },
  "nao_tem_gostaria_atend_especializado_contra_violencia_instituci",
  { data_type => "integer", is_nullable => 0 },
  "nao_quer_atend_especializado_contra_violencia_institucional",
  { data_type => "integer", is_nullable => 0 },
  "nunca_fez_acompanhamento_contra_drogas",
  { data_type => "integer", is_nullable => 0 },
  "fez_acompanhamento_contra_drogas_capsad",
  { data_type => "integer", is_nullable => 0 },
  "fez_acompanhamento_contra_drogas_capsi",
  { data_type => "integer", is_nullable => 0 },
  "fez_acompanhamento_contra_drogas_hospital_mental",
  { data_type => "integer", is_nullable => 0 },
  "faz_acompanhamento_contra_drogas_hospital_mental",
  { data_type => "integer", is_nullable => 0 },
  "faz_acompanhamento_contra_drogas_capsad",
  { data_type => "integer", is_nullable => 0 },
  "faz_acompanhamento_contra_drogas_capsi",
  { data_type => "integer", is_nullable => 0 },
);

=head1 RELATIONS

=head2 id_participacao_atividade_comunitaria

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DParticipacaoAtividadeComunitaria>

=cut

__PACKAGE__->belongs_to(
  "id_participacao_atividade_comunitaria",
  "Acao::Plugins::SDH::DimSchema::Result::DParticipacaoAtividadeComunitaria",
  {
    id_participacao_atividade_comunitaria => "id_participacao_atividade_comunitaria",
  },
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

=head2 id_usa_comprimido

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaComprimido>

=cut

__PACKAGE__->belongs_to(
  "id_usa_comprimido",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaComprimido",
  { id_usa_comprimidos => "id_usa_comprimidos" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambito_comunitario_agressao_psicologica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAgressaoPsicologica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_agressao_psicologica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAgressaoPsicologica",
  {
    id_sofre_violencia_ambito_comunitario_agressao_psicologica => "id_sofre_violencia_ambito_comunitario_agressao_psicologica",
  },
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

=head2 id_sofre_violencia_institucional_agressao_psicologica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAgressaoPsicologica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_agressao_psicologica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAgressaoPsicologica",
  {
    id_sofre_violencia_institucional_agressao_psicologica => "id_sofre_violencia_institucional_agressao_psicologica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_intrafamiliar_ameaca_morte

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAmeacaMorte>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_ameaca_morte",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAmeacaMorte",
  {
    id_sofre_violencia_intrafamiliar_ameaca_morte => "id_sofre_violencia_intrafamiliar_ameaca_morte",
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

=head2 id_sofre_violencia_intrafamiliar_agressao_psicologica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAgressaoPsicologica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_agressao_psicologica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAgressaoPsicologica",
  {
    id_sofre_violencia_intrafamiliar_agressao_psicologica => "id_sofre_violencia_intrafamiliar_agressao_psicologica",
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

=head2 id_usa_cola

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaCola>

=cut

__PACKAGE__->belongs_to(
  "id_usa_cola",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaCola",
  { id_usa_cola => "id_usa_cola" },
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

=head2 id_sofre_violencia_intrafamiliar_discussao_verbal

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarDiscussaoVerbal>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_discussao_verbal",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarDiscussaoVerbal",
  {
    id_sofre_violencia_intrafamiliar_discussao_verbal => "id_sofre_violencia_intrafamiliar_discussao_verbal",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambito_comunitario_ameaca_morte

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAmeacaMorte>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_ameaca_morte",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAmeacaMorte",
  {
    id_sofre_violencia_ambito_comunitario_ameaca_morte => "id_sofre_violencia_ambito_comunitario_ameaca_morte",
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

=head2 id_usa_contraceptivo

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaContraceptivo>

=cut

__PACKAGE__->belongs_to(
  "id_usa_contraceptivo",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaContraceptivo",
  { id_usa_contraceptivo => "id_usa_contraceptivo" },
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

=head2 id_vivencia_rua

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DVivenciaRua>

=cut

__PACKAGE__->belongs_to(
  "id_vivencia_rua",
  "Acao::Plugins::SDH::DimSchema::Result::DVivenciaRua",
  { id_vivencia_rua => "id_vivencia_rua" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_regional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DRegional>

=cut

__PACKAGE__->belongs_to(
  "id_regional",
  "Acao::Plugins::SDH::DimSchema::Result::DRegional",
  { id_regional => "id_regional" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_frequenta_ginecologista_regularmente

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFrequentaGinecologistaRegularmente>

=cut

__PACKAGE__->belongs_to(
  "id_frequenta_ginecologista_regularmente",
  "Acao::Plugins::SDH::DimSchema::Result::DFrequentaGinecologistaRegularmente",
  {
    id_frequenta_ginecologista_regularmente => "id_frequenta_ginecologista_regularmente",
  },
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

=head2 id_sofreu_violencia_institucional_ameaca_morte

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAmeacaMorte>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_ameaca_morte",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAmeacaMorte",
  {
    id_sofreu_violencia_institucional_ameaca_morte => "id_sofreu_violencia_institucional_ameaca_morte",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_intrafamiliar_agressao_fisica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAgressaoFisica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_agressao_fisica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAgressaoFisica",
  {
    id_sofre_violencia_intrafamiliar_agressao_fisica => "id_sofre_violencia_intrafamiliar_agressao_fisica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_recebe_medicamento_quando_necessario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DRecebeMedicamentoQuandoNecessario>

=cut

__PACKAGE__->belongs_to(
  "id_recebe_medicamento_quando_necessario",
  "Acao::Plugins::SDH::DimSchema::Result::DRecebeMedicamentoQuandoNecessario",
  {
    id_recebe_medicamento_quando_necessario => "id_recebe_medicamento_quando_necessario",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambito_comunitario_exploracao_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioExploracaoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_exploracao_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioExploracaoSexual",
  {
    id_sofre_violencia_ambito_comunitario_exploracao_sexual => "id_sofre_violencia_ambito_comunitario_exploracao_sexual",
  },
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

=head2 id_sofre_violencia_ambito_comunitario_abuso_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAbusoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_abuso_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAbusoSexual",
  {
    id_sofre_violencia_ambito_comunitario_abuso_sexual => "id_sofre_violencia_ambito_comunitario_abuso_sexual",
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

=head2 id_usa_inalante

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaInalante>

=cut

__PACKAGE__->belongs_to(
  "id_usa_inalante",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaInalante",
  { id_usa_inalantes => "id_usa_inalantes" },
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

=head2 id_sofre_violencia_institucional_exploracao_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalExploracaoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_exploracao_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalExploracaoSexual",
  {
    id_sofre_violencia_institucional_exploracao_sexual => "id_sofre_violencia_institucional_exploracao_sexual",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_foi_internado_comunidade_terapeutica_uso_droga

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFoiInternadoComunidadeTerapeuticaUsoDroga>

=cut

__PACKAGE__->belongs_to(
  "id_foi_internado_comunidade_terapeutica_uso_droga",
  "Acao::Plugins::SDH::DimSchema::Result::DFoiInternadoComunidadeTerapeuticaUsoDroga",
  {
    id_foi_internado_comunidade_terapeutica_uso_droga => "id_foi_internado_comunidade_terapeutica_uso_droga",
  },
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

=head2 id_sofre_violencia_institucional_agressao_fisica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAgressaoFisica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_agressao_fisica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAgressaoFisica",
  {
    id_sofre_violencia_institucional_agressao_fisica => "id_sofre_violencia_institucional_agressao_fisica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_usa_maconha

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaMaconha>

=cut

__PACKAGE__->belongs_to(
  "id_usa_maconha",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaMaconha",
  { id_usa_maconha => "id_usa_maconha" },
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

=head2 id_sofre_violencia_institucional_abuso_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAbusoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_abuso_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAbusoSexual",
  {
    id_sofre_violencia_institucional_abuso_sexual => "id_sofre_violencia_institucional_abuso_sexual",
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

=head2 id_sofreu_violencia_institucional_discussao_verbal

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalDiscussaoVerbal>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_discussao_verbal",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalDiscussaoVerbal",
  {
    id_sofreu_violencia_institucional_discussao_verbal => "id_sofreu_violencia_institucional_discussao_verbal",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

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

=head2 id_sofreu_violencia_institucional_abuso_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAbusoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_abuso_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAbusoSexual",
  {
    id_sofreu_violencia_institucional_abuso_sexual => "id_sofreu_violencia_institucional_abuso_sexual",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_institucional_discussao_verbal

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalDiscussaoVerbal>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_discussao_verbal",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalDiscussaoVerbal",
  {
    id_sofre_violencia_institucional_discussao_verbal => "id_sofre_violencia_institucional_discussao_verbal",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_avaliacao_acesso_medicacao

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoAcessoMedicacao>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_acesso_medicacao",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoAcessoMedicacao",
  {
    id_avaliacao_acesso_medicacao => "id_avaliacao_acesso_medicacao",
  },
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

=head2 id_sofre_violencia_intrafamiliar_domestica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarDomestica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_domestica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarDomestica",
  {
    id_sofre_violencia_intrafamiliar_domestica => "id_sofre_violencia_intrafamiliar_domestica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_usa_alcool

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaAlcool>

=cut

__PACKAGE__->belongs_to(
  "id_usa_alcool",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaAlcool",
  { id_usa_alcool => "id_usa_alcool" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_intrafamiliar_exploracao_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarExploracaoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_exploracao_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarExploracaoSexual",
  {
    id_sofre_violencia_intrafamiliar_exploracao_sexual => "id_sofre_violencia_intrafamiliar_exploracao_sexual",
  },
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

=head2 id_exploracao_trabalho_infantil

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DExploracaoTrabalhoInfantil>

=cut

__PACKAGE__->belongs_to(
  "id_exploracao_trabalho_infantil",
  "Acao::Plugins::SDH::DimSchema::Result::DExploracaoTrabalhoInfantil",
  {
    id_exploracao_trabalho_infantil => "id_exploracao_trabalho_infantil",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambito_comunitario_discussao_verbal

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioDiscussaoVerbal>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_discussao_verbal",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioDiscussaoVerbal",
  {
    id_sofre_violencia_ambito_comunitario_discussao_verbal => "id_sofre_violencia_ambito_comunitario_discussao_verbal",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_ambito_comunitario_agressao_fisica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAgressaoFisica>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_ambito_comunitario_agressao_fisica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaAmbitoComunitarioAgressaoFisica",
  {
    id_sofre_violencia_ambito_comunitario_agressao_fisica => "id_sofre_violencia_ambito_comunitario_agressao_fisica",
  },
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

=head2 id_turno_estuda

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTurnoEstuda>

=cut

__PACKAGE__->belongs_to(
  "id_turno_estuda",
  "Acao::Plugins::SDH::DimSchema::Result::DTurnoEstuda",
  { id_turno_estuda => "id_turno_estuda" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_usa_mesclado

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaMesclado>

=cut

__PACKAGE__->belongs_to(
  "id_usa_mesclado",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaMesclado",
  { id_usa_mesclado => "id_usa_mesclado" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_usa_cocaina

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaCocaina>

=cut

__PACKAGE__->belongs_to(
  "id_usa_cocaina",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaCocaina",
  { id_usa_cocaina => "id_usa_cocaina" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofreu_violencia_institucional_agressao_fisica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAgressaoFisica>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_agressao_fisica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAgressaoFisica",
  {
    id_sofreu_violencia_institucional_agressao_fisica => "id_sofreu_violencia_institucional_agressao_fisica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_inscrito_peti

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DInscritoPeti>

=cut

__PACKAGE__->belongs_to(
  "id_inscrito_peti",
  "Acao::Plugins::SDH::DimSchema::Result::DInscritoPeti",
  { id_inscrito_peti => "id_inscrito_peti" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofre_violencia_institucional_ameaca_morte

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAmeacaMorte>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_institucional_ameaca_morte",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaInstitucionalAmeacaMorte",
  {
    id_sofre_violencia_institucional_ameaca_morte => "id_sofre_violencia_institucional_ameaca_morte",
  },
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

=head2 id_frequenta_urologista_regularmente

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DFrequentaUrologistaRegularmente>

=cut

__PACKAGE__->belongs_to(
  "id_frequenta_urologista_regularmente",
  "Acao::Plugins::SDH::DimSchema::Result::DFrequentaUrologistaRegularmente",
  {
    id_frequenta_urologista_regularmente => "id_frequenta_urologista_regularmente",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_sofreu_violencia_institucional_exploracao_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalExploracaoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_exploracao_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalExploracaoSexual",
  {
    id_sofreu_violencia_institucional_exploracao_sexual => "id_sofreu_violencia_institucional_exploracao_sexual",
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

=head2 id_sofre_violencia_intrafamiliar_abuso_sexual

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAbusoSexual>

=cut

__PACKAGE__->belongs_to(
  "id_sofre_violencia_intrafamiliar_abuso_sexual",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreViolenciaIntrafamiliarAbusoSexual",
  {
    id_sofre_violencia_intrafamiliar_abuso_sexual => "id_sofre_violencia_intrafamiliar_abuso_sexual",
  },
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

=head2 id_sofreu_violencia_institucional_agressao_psicologica

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAgressaoPsicologica>

=cut

__PACKAGE__->belongs_to(
  "id_sofreu_violencia_institucional_agressao_psicologica",
  "Acao::Plugins::SDH::DimSchema::Result::DSofreuViolenciaInstitucionalAgressaoPsicologica",
  {
    id_sofreu_violencia_institucional_agressao_psicologica => "id_sofreu_violencia_institucional_agressao_psicologica",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_usa_crack

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaCrack>

=cut

__PACKAGE__->belongs_to(
  "id_usa_crack",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaCrack",
  { id_usa_crack => "id_usa_crack" },
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

=head2 id_usa_cigarro

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DUsaCigarro>

=cut

__PACKAGE__->belongs_to(
  "id_usa_cigarro",
  "Acao::Plugins::SDH::DimSchema::Result::DUsaCigarro",
  { id_usa_cigarro => "id_usa_cigarro" },
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

=head2 id_deseja_tratamento_uso_droga

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DDesejaTratamentoUsoDroga>

=cut

__PACKAGE__->belongs_to(
  "id_deseja_tratamento_uso_droga",
  "Acao::Plugins::SDH::DimSchema::Result::DDesejaTratamentoUsoDroga",
  {
    id_deseja_tratamento_uso_drogas => "id_deseja_tratamento_uso_drogas",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-11-12 15:49:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:sZ+A6RG181s37aSIwJF4kA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
