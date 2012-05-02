package Acao::Role::Controller::Localizacao;

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
use MooseX::Role::Parameterized;
use List::MoreUtils qw(pairwise);
use XML::Compile::Util;
use XML::LibXML;

parameter modelcomponent => (
    isa      => 'Str',
    required => 1,
);

role {

    method '_processa_localizacao' => sub {
        my ( $self, $c ) = @_;

        #	Navega nas assuntos do LDAP
        if ( $c->req->param('opcao_local') eq 'Navegar' ) {
            $c->stash->{local_basedn} = $c->req->param('localizacao');
            $c->stash->{localizacao}  = $c->req->param('localizacao');
            return 1;
        }
        return 0;
    };
};

=head1 NAME

Acao::Model::Autorizacao - Implementa as regras de negócio de Autorizações para Volumes, Dossies e Documentos

=head1 DESCRIPTION

Essa classe implementa as regras de negócio de Autorizações para Volumes, Dossies e Documentos.

=head1 METHODS

=over


=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
