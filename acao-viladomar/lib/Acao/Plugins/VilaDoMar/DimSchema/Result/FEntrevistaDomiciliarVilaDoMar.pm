package Acao::Plugins::VilaDoMar::DimSchema::Result::FEntrevistaDomiciliarVilaDoMar;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';


=head1 NAME

Acao::Plugins::VilaDoMar::DimSchema::Result::FEntrevistaDomiciliarVilaDoMar

=cut

__PACKAGE__->table("f_entrevista_domiciliar_vila_do_mar");

=head1 ACCESSORS

=head2 situacao_morador_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipologia_uso_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_fundiaria_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_moradia_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tempo_moradia_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 endereco_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipologia_construcao_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_cobertura_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_piso_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 revestimento_parede_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_fornecedor_abastecimento_agua_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_abastecimento_agua_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_esgoto_sanitario_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_rede_esgoto_sanitario_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_ligacao_eletrica_imovel_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_pavimentacao_id

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_servico_telefonico_id

  data_type: 'integer'
  is_nullable: 1

=head2 renda_familiar_id

  data_type: 'numeric'
  is_nullable: 1

=head2 valor_imovel

  data_type: 'numeric'
  is_nullable: 1

=head2 rede_agua

  data_type: 'integer'
  is_nullable: 1

=head2 rede_coleta_esgoto

  data_type: 'integer'
  is_nullable: 1

=head2 situacao_risco_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_quintal_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_banheiro_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_cozinha_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_quarto_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_sala_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 quantidade_integrantes

  data_type: 'integer'
  is_nullable: 1

=head2 area_preservacao_imovel

  data_type: 'integer'
  is_nullable: 1

=head2 data_id

  data_type: 'date'
  is_nullable: 1

=head2 visita1

  data_type: 'date'
  is_nullable: 1

=head2 visita2

  data_type: 'date'
  is_nullable: 1

=head2 visita3

  data_type: 'date'
  is_nullable: 1

=head2 destino_lixo_sistema_coleta

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_conteiner

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_terreno_baldio

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_curso_dagua

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_passeio

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_logradouro

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_enterrado

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_queimado

  data_type: 'integer'
  is_nullable: 1

=head2 destino_lixo_outro

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_drenagem_galeria_subterranea

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_drenagem_sarjeta

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_drenagem_curso_dagua_canalizado

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_drenagem_outro

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_drenagem_curso_dagua_nao_canalizado

  data_type: 'integer'
  is_nullable: 1

=head2 necessita_reparos_hidrosanitarias

  data_type: 'integer'
  is_nullable: 1

=head2 necessidade_reparos_pinturas

  data_type: 'integer'
  is_nullable: 1

=head2 necessidade_reparos_coberta_telhado

  data_type: 'integer'
  is_nullable: 1

=head2 necessidade_reparos_outro

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_alagamento

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_inundacao

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_deslizamento

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_linha_alta_tensao

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_outro

  data_type: 'integer'
  is_nullable: 1

=head2 tipo_risco_via_ferrea

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_quadra_loteada

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_leito_rua

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_praca

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_area_verde

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_terreno_eqp_comunitario

  data_type: 'integer'
  is_nullable: 1

=head2 localizacao_outro

  data_type: 'integer'
  is_nullable: 1

=head2 cod_pmf

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "situacao_morador_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipologia_uso_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "situacao_fundiaria_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_moradia_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tempo_moradia_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "endereco_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipologia_construcao_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_cobertura_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_piso_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "revestimento_parede_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_fornecedor_abastecimento_agua_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_abastecimento_agua_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_esgoto_sanitario_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_rede_esgoto_sanitario_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_ligacao_eletrica_imovel_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_pavimentacao_id",
  { data_type => "integer", is_nullable => 1 },
  "tipo_servico_telefonico_id",
  { data_type => "integer", is_nullable => 1 },
  "renda_familiar_id",
  { data_type => "numeric", is_nullable => 1 },
  "valor_imovel",
  { data_type => "numeric", is_nullable => 1 },
  "rede_agua",
  { data_type => "integer", is_nullable => 1 },
  "rede_coleta_esgoto",
  { data_type => "integer", is_nullable => 1 },
  "situacao_risco_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_quintal_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_banheiro_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_cozinha_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_quarto_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_sala_imovel",
  { data_type => "integer", is_nullable => 1 },
  "quantidade_integrantes",
  { data_type => "integer", is_nullable => 1 },
  "area_preservacao_imovel",
  { data_type => "integer", is_nullable => 1 },
  "data_id",
  { data_type => "date", is_nullable => 1 },
  "visita1",
  { data_type => "date", is_nullable => 1 },
  "visita2",
  { data_type => "date", is_nullable => 1 },
  "visita3",
  { data_type => "date", is_nullable => 1 },
  "destino_lixo_sistema_coleta",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_conteiner",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_terreno_baldio",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_curso_dagua",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_passeio",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_logradouro",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_enterrado",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_queimado",
  { data_type => "integer", is_nullable => 1 },
  "destino_lixo_outro",
  { data_type => "integer", is_nullable => 1 },
  "tipo_drenagem_galeria_subterranea",
  { data_type => "integer", is_nullable => 1 },
  "tipo_drenagem_sarjeta",
  { data_type => "integer", is_nullable => 1 },
  "tipo_drenagem_curso_dagua_canalizado",
  { data_type => "integer", is_nullable => 1 },
  "tipo_drenagem_outro",
  { data_type => "integer", is_nullable => 1 },
  "tipo_drenagem_curso_dagua_nao_canalizado",
  { data_type => "integer", is_nullable => 1 },
  "necessita_reparos_hidrosanitarias",
  { data_type => "integer", is_nullable => 1 },
  "necessidade_reparos_pinturas",
  { data_type => "integer", is_nullable => 1 },
  "necessidade_reparos_coberta_telhado",
  { data_type => "integer", is_nullable => 1 },
  "necessidade_reparos_outro",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_alagamento",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_inundacao",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_deslizamento",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_linha_alta_tensao",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_outro",
  { data_type => "integer", is_nullable => 1 },
  "tipo_risco_via_ferrea",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_quadra_loteada",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_leito_rua",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_praca",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_area_verde",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_terreno_eqp_comunitario",
  { data_type => "integer", is_nullable => 1 },
  "localizacao_outro",
  { data_type => "integer", is_nullable => 1 },
  "cod_pmf",
  { data_type => "integer", is_nullable => 1 },
  "qtd_familias",
  { data_type => "integer", is_nullable => 0, default_value => 1 },
  "controle",
  { data_type => "integer", is_nullable => 1 },
  "nome",
  { data_type => "varchar", is_nullable => 1 },
);


# Created by DBIx::Class::Schema::Loader v0.06001 @ 2010-06-02 10:22:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CppFsK+fTS1pLn2RfA+hsg


# You can replace this text with custom content, and it will be preserved on regeneration
1;
