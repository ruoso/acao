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

=head2 ja_estagiou

  data_type: 'integer'
  is_nullable: 0

=head2 ja_trabalhou_formalmente

  data_type: 'integer'
  is_nullable: 0

=head2 ja_trabalhou_informalmente

  data_type: 'integer'
  is_nullable: 0

=head2 esta_trabalhando_formalmente

  data_type: 'integer'
  is_nullable: 0

=head2 esta_trabalhando_informalmente

  data_type: 'integer'
  is_nullable: 0

=head2 id_nocoes_informatica

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 fez_curso_profissionalizante

  data_type: 'integer'
  is_nullable: 0

=head2 tem_interesse_curso_profissionalizante

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

=head2 id_tipo_abastecimento_agua

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tratamento_agua

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_tipo_iluminacao

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_escoamento_sanitario

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_destino_lixo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_origem_encaminhamento

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_vinculacao_cca

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_nucleo

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_status_vinculacao

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_violencia_intrafamiliar

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

=head2 id_providencia_contra_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 violencia_instituicao_policial

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_instituicao_guarda_municipal

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_instituicao_escola

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_instituicao_posto_saude

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_discussao_verbal

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_agressao_fisica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_abuso_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_exploracao_sexual

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_agressao_psicologica

  data_type: 'integer'
  is_nullable: 0

=head2 violencia_institucional_ameassa_morte

  data_type: 'integer'
  is_nullable: 0

=head2 id_providencia_contra_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_atendimento_contra_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_frequencia_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_frequencia_violencia_institucional

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_violencia_ambiente_comunitario

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

=head2 id_providencia_contra_violencia_ambito_comunitario

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

=head2 exploracao_trabalho_infantil_comercio_drogras

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

=head2 frequentando_escola

  data_type: 'integer'
  is_nullable: 0

=head2 escola_matriculado_proximo_residencia

  data_type: 'integer'
  is_nullable: 0

=head2 id_escolaridade

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_frequencia_escolar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_preparacao_atividades_escolares

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_rendimento_escolar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_avaliacao_familia_vida_escolar

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

=head2 id_atendimento_contra_violencia_intrafamiliar

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 id_atendimento_contra_violencia_comunitario

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

=head2 tipo_construcao_moradia_madeira

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_material_aproveitado

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_taipa_nao_resvestida

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_taipa_revestida

  data_type: 'integer'
  is_nullable: 0

=head2 tipo_construcao_moradia_tijolo_alvenaria

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
  "ja_estagiou",
  { data_type => "integer", is_nullable => 0 },
  "ja_trabalhou_formalmente",
  { data_type => "integer", is_nullable => 0 },
  "ja_trabalhou_informalmente",
  { data_type => "integer", is_nullable => 0 },
  "esta_trabalhando_formalmente",
  { data_type => "integer", is_nullable => 0 },
  "esta_trabalhando_informalmente",
  { data_type => "integer", is_nullable => 0 },
  "id_nocoes_informatica",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "fez_curso_profissionalizante",
  { data_type => "integer", is_nullable => 0 },
  "tem_interesse_curso_profissionalizante",
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
  "id_vinculo_religioso",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "situacao_moradia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_tempo_moradia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "possui_banheiro",
  { data_type => "integer", is_nullable => 0 },
  "id_tipo_abastecimento_agua",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_tratamento_agua",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_tipo_iluminacao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_escoamento_sanitario",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_destino_lixo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_origem_encaminhamento",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_vinculacao_cca",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_nucleo",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_status_vinculacao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_violencia_intrafamiliar",
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
  "id_providencia_contra_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "violencia_instituicao_policial",
  { data_type => "integer", is_nullable => 0 },
  "violencia_instituicao_guarda_municipal",
  { data_type => "integer", is_nullable => 0 },
  "violencia_instituicao_escola",
  { data_type => "integer", is_nullable => 0 },
  "violencia_instituicao_posto_saude",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_discussao_verbal",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_agressao_fisica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_abuso_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_exploracao_sexual",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_agressao_psicologica",
  { data_type => "integer", is_nullable => 0 },
  "violencia_institucional_ameassa_morte",
  { data_type => "integer", is_nullable => 0 },
  "id_providencia_contra_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_atendimento_contra_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_frequencia_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_frequencia_violencia_institucional",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_violencia_ambiente_comunitario",
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
  "id_providencia_contra_violencia_ambito_comunitario",
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
  "exploracao_trabalho_infantil_comercio_drogras",
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
  "frequentando_escola",
  { data_type => "integer", is_nullable => 0 },
  "escola_matriculado_proximo_residencia",
  { data_type => "integer", is_nullable => 0 },
  "id_escolaridade",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_frequencia_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_preparacao_atividades_escolares",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_rendimento_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_familia_vida_escolar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_acesso_medicacao",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_servico_saude",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_avaliacao_condicao_saude_familia",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_atendimento_contra_violencia_intrafamiliar",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "id_atendimento_contra_violencia_comunitario",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "data_nascimento",
  { data_type => "integer", is_nullable => 0 },
  "id_possui_banheiro",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "tipo_construcao_moradia_madeira",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_material_aproveitado",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_taipa_nao_resvestida",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_taipa_revestida",
  { data_type => "integer", is_nullable => 0 },
  "tipo_construcao_moradia_tijolo_alvenaria",
  { data_type => "integer", is_nullable => 0 },
);

=head1 RELATIONS

=head2 id_atendimento_contra_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_atendimento_contra_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaInstitucional",
  {
    id_atendimento_contra_violencia_institucional => "id_atendimento_contra_violencia_institucional",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_avaliacao_familia_vida_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoFamiliaVidaEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_familia_vida_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoFamiliaVidaEscolar",
  {
    id_avaliacao_familia_vida_escolar => "id_avaliacao_familia_vida_escolar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_providencia_contra_violencia_ambito_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaAmbitoComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_providencia_contra_violencia_ambito_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaAmbitoComunitario",
  {
    id_providencia_contra_violencia_ambito_comunitario => "id_providencia_contra_violencia_ambito_comunitario",
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

=head2 id_tipo_abastecimento_agua

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTipoAbastecimentoAgua>

=cut

__PACKAGE__->belongs_to(
  "id_tipo_abastecimento_agua",
  "Acao::Plugins::SDH::DimSchema::Result::DTipoAbastecimentoAgua",
  { id_tipo_abastecimento_agua => "id_tipo_abastecimento_agua" },
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

=head2 id_escoamento_sanitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DEscoamentoSanitario>

=cut

__PACKAGE__->belongs_to(
  "id_escoamento_sanitario",
  "Acao::Plugins::SDH::DimSchema::Result::DEscoamentoSanitario",
  { id_escoamento_sanitario => "id_escoamento_sanitario" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_violencia_ambiente_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DViolenciaAmbienteComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_violencia_ambiente_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DViolenciaAmbienteComunitario",
  {
    id_violencia_ambiente_comunitario => "id_violencia_ambiente_comunitario",
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

=head2 id_origem_encaminhamento

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DOrigemEncaminhamento>

=cut

__PACKAGE__->belongs_to(
  "id_origem_encaminhamento",
  "Acao::Plugins::SDH::DimSchema::Result::DOrigemEncaminhamento",
  { id_origem_encaminhamento => "id_origem_encaminhamento" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_tratamento_agua

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DTratamentoAgua>

=cut

__PACKAGE__->belongs_to(
  "id_tratamento_agua",
  "Acao::Plugins::SDH::DimSchema::Result::DTratamentoAgua",
  { id_tratamento_agua => "id_tratamento_agua" },
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

=head2 id_vinculacao_cca

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DVinculacaoCca>

=cut

__PACKAGE__->belongs_to(
  "id_vinculacao_cca",
  "Acao::Plugins::SDH::DimSchema::Result::DVinculacaoCca",
  { id_vinculacao_cca => "id_vinculacao_cca" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_providencia_contra_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_providencia_contra_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaIntrafamiliar",
  {
    id_providencia_contra_violencia_intrafamiliar => "id_providencia_contra_violencia_intrafamiliar",
  },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_providencia_contra_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_providencia_contra_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DProvidenciaContraViolenciaInstitucional",
  {
    id_providencia_contra_violencia_institucional => "id_providencia_contra_violencia_institucional",
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

=head2 id_avaliacao_frequencia_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoFrequenciaEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_frequencia_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoFrequenciaEscolar",
  {
    id_avaliacao_frequencia_escolar => "id_avaliacao_frequencia_escolar",
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

=head2 id_destino_lixo

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DDestinoLixo>

=cut

__PACKAGE__->belongs_to(
  "id_destino_lixo",
  "Acao::Plugins::SDH::DimSchema::Result::DDestinoLixo",
  { id_destino_lixo => "id_destino_lixo" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 id_violencia_institucional

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DViolenciaInstitucional>

=cut

__PACKAGE__->belongs_to(
  "id_violencia_institucional",
  "Acao::Plugins::SDH::DimSchema::Result::DViolenciaInstitucional",
  { id_violencia_institucional => "id_violencia_institucional" },
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

=head2 id_avaliacao_rendimento_escolar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoRendimentoEscolar>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_rendimento_escolar",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoRendimentoEscolar",
  {
    id_avaliacao_rendimento_escolar => "id_avaliacao_rendimento_escolar",
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

=head2 id_atendimento_contra_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_atendimento_contra_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaIntrafamiliar",
  {
    id_atendimento_contra_violencia_intrafamiliar => "id_atendimento_contra_violencia_intrafamiliar",
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

=head2 id_avaliacao_preparacao_atividades_escolare

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoPreparacaoAtividadesEscolare>

=cut

__PACKAGE__->belongs_to(
  "id_avaliacao_preparacao_atividades_escolare",
  "Acao::Plugins::SDH::DimSchema::Result::DAvaliacaoPreparacaoAtividadesEscolare",
  {
    id_avaliacao_preparacao_atividades_escolares => "id_avaliacao_preparacao_atividades_escolares",
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

=head2 id_atendimento_contra_violencia_comunitario

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaComunitario>

=cut

__PACKAGE__->belongs_to(
  "id_atendimento_contra_violencia_comunitario",
  "Acao::Plugins::SDH::DimSchema::Result::DAtendimentoContraViolenciaComunitario",
  {
    id_atendimento_contra_violencia_comunitario => "id_atendimento_contra_violencia_comunitario",
  },
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

=head2 id_violencia_intrafamiliar

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DViolenciaIntrafamiliar>

=cut

__PACKAGE__->belongs_to(
  "id_violencia_intrafamiliar",
  "Acao::Plugins::SDH::DimSchema::Result::DViolenciaIntrafamiliar",
  { id_violencia_intrafamiliar => "id_violencia_intrafamiliar" },
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

=head2 id_status_vinculacao

Type: belongs_to

Related object: L<Acao::Plugins::SDH::DimSchema::Result::DStatusVinculacao>

=cut

__PACKAGE__->belongs_to(
  "id_status_vinculacao",
  "Acao::Plugins::SDH::DimSchema::Result::DStatusVinculacao",
  { id_status_vinculacao => "id_status_vinculacao" },
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


# Created by DBIx::Class::Schema::Loader v0.07002 @ 2010-10-14 15:32:31
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:G/AeRIxrBKbvHZq6rvcaHA


# You can replace this text with custom content, and it will be preserved on regeneration
1;
