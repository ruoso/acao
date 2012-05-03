package Acao::Schema::Result::DefinicaoConsolidacao;

# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,

use strict;
use warnings;

use base 'DBIx::Class';

=head1 NAME

Acao::Schema::Result::DefinicaoConsolidacao - Resultsource da tabela
definicao_consolidacao

=head1 DESCRIPTION

Esta entidade descreve como será realizada um determinado processo de
consolidação. É a partir dessa definição que são estabelecidas todas
as regras de como obter os dados, como validá-los e como transformálos
para considerar o processo de digitação finalizado.

=cut

__PACKAGE__->load_components( "InflateColumn::DateTime", "Core" );
__PACKAGE__->table("definicao_consolidacao");
__PACKAGE__->add_columns(
    "id_definicao_consolidacao",
    {
        data_type         => "integer",
        default_value     => undef,
        is_nullable       => 0,
        is_auto_increment => 1,
        size              => undef,
        is_auto_increment => 1,
    },
    "id_projeto",
    {
        data_type     => "integer",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "xml_schema",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "nome",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "status",
    {
        data_type     => "varchar",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "data_ini",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
    "data_fim",
    {
        data_type     => "timestamp with time zone",
        default_value => undef,
        is_nullable   => 1,
        size          => undef,
    },
);
__PACKAGE__->set_primary_key("id_definicao_consolidacao");
__PACKAGE__->has_many(
    "entrada_consolidacao",
    "Acao::Schema::Result::EntradaConsolidacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_coleta_dados",
    "Acao::Schema::Result::EtapaColetaDados",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_transformacao",
    "Acao::Schema::Result::EtapaTransformacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "etapa_validacao",
    "Acao::Schema::Result::EtapaValidacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "consolidacao",
    "Acao::Schema::Result::Consolidacao",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);
__PACKAGE__->has_many(
    "consolidador",
    "Acao::Schema::Result::Consolidador",
    { "foreign.id_definicao_consolidacao" => "self.id_definicao_consolidacao" },
);

__PACKAGE__->belongs_to(
    "projeto",
    "Acao::Schema::Result::Projeto",
    { id_projeto => "id_projeto" },
);

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
