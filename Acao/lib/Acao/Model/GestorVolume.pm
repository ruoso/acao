package Acao::Model::GestorVolume;
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
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;
use XML::LibXML;
use XML::Compile::Schema;
use XML::Compile::Util;
use DateTime;
use Encode;

use constant DIGITACAO_NS =>
  'http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd';

my $controle =
  XML::Compile::Schema->new( Acao->path_to('schemas/controledigitacao.xsd') );
my $controle_w = $controle->compile(
    WRITER                => pack_type( DIGITACAO_NS, 'registroDigitacao' ),
    use_default_namespace => 1
);

=head1 NAME

Acao::Model::GestorVolume - Implementa as regras de negócio do papel gestor_volumes

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de gestor_volumes.

=head1 METHODS

=over

=item listar_volumes()

Retorna as leituras as quais o usuário autenticado tem acesso.

=cut

txn_method 'listar_volumes' => authorized 'gestor_volumes' => sub {
    my $self = shift;

    # sera dentro de uma transacao, e so pode ser usado por digitadores
    return $self->dbic->resultset('Volume')->search(
        { 'gestor_volumes.dn' => $self->user->id },
        {
	 join => 'gestor_volumes',
        }
    );
};

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
