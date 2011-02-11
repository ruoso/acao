package Acao::Model;

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
with 'Catalyst::Component::InstancePerContext';
has 'user'  => ( is => 'rw' );
has 'dbic'  => ( is => 'rw' );
has 'sedna' => ( is => 'rw' );

=head1 NAME

Acao::Model - Superclasse para os modelos de regra de negócio.

=head1 DESCRIPTION

Essa classe define o comportamento de que ao acessar um modelo de
negócios, será levado como informação para a classe modelo qual o
usuário autenticado, além de levar uma referência para o dbic e para o
sedna.

=cut

sub build_per_context_instance {
    my ( $self, $c ) = @_;
    $self->new(
        user  => $c->user,
        dbic  => $c->model('DB')->schema,
        sedna => $c->model('Sedna')
    );
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
