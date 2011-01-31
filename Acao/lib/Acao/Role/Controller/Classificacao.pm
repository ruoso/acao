package Acao::Role::Controller::Classificacao;

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
    my $p     = shift;
    my $model = $p->modelcomponent;

    method '_processa_classificacao' => sub {
        my ( $self, $c ) = @_;

        $c->stash->{class_basedn}   = $c->req->param('class_basedn');
        # remove classificacoes
        my (@pos) =
          grep { s/^remover_classificacao_// } keys %{ $c->req->params };
        if ( $c->req->param('opcao_class') eq 'Remover' ) {
            if (@pos) {
                $c->stash->{classificacoes} =
                  $c->model($model)
                  ->remove_classificacoes( $c->req->param('classificacoes'),
                    @pos );
            }
            else {
                $c->stash->{classificacoes} = $c->req->param('classificacoes');
            }
            return 1;
        }

        #	Navega nas assuntos do LDAP
        if ( $c->req->param('opcao_class') eq 'Navegar' ) {
            $c->stash->{class_basedn}   = $c->req->param('assuntos');
            $c->stash->{classificacoes} = $c->req->param('classificacoes');
            return 1;
        }

        #	Adiciona os assuntos do LDAP
        if ( $c->req->param('opcao_class') eq 'Adicionar' ) {

            my @classificacoes = $c->req->param('assuntos');
            $c->stash->{classificacoes} =
              $c->model($model)
              ->add_classificacoes( $c->req->param('classificacoes'),
                \@classificacoes );
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
