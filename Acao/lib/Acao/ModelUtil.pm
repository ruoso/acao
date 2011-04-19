package Acao::ModelUtil;

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
use base 'Exporter';

=head1 NAME

Acao::ModelUtil - Implementa lógica auxiliar para as classes modelo

=head1 DESCRIPTION

Esta classe implementa rotinas auxiliares que são utilizadas pelas
classes modelo, de forma a implementar lógicas de controle comuns a
todas elas.

=head1 ROUTINES

As rotinas implementadas aqui são exportadas, de forma que podem ser
utilizadas pelas classes de maneira conveniente.

=cut

use Data::Dumper;
our @EXPORT = qw(txn_method authorized);

=over

=item txn_method $name, $code

Esta rotina instala um símbolo $name no pacote apontando para a rotina
$code, mas também encapsula esse método em uma chamada para o método
txn_do do DBIx::Class::Schema, que irá colocar esse código dentro de
um BEGIN e COMMIT, fazendo ROLLBACK no caso de exceção. Adicionalmente
ele inicia e termina uma transação no Sedna.

=cut

sub txn_method {
    my ( $name, $code ) = @_;
    my $method_name = caller() . '::' . $name;
    no strict 'refs';
    *{$method_name} = sub {
        my $ret;
        my $committed = 0;
        eval {
            $_[0]->sedna->begin;
            $ret = $_[0]->dbic->txn_do( $code, @_ );
            $_[0]->sedna->commit;
            $committed = 1;
        };
        if ($@) {
            my $erro_original = $@;
            eval { $_[0]->sedna->rollback unless $committed; };
            die $erro_original;
        }
        $ret;
    };
}

=item authorized $role, $code

Esta função irá encapsular o $code em uma outra função que irá
verificar se o usuário autenticado tem a $role informada, jogando uma
exceção caso não tenha.

=back

=cut

sub authorized {
    my ( $role, $code ) = @_;
    return sub {
        if ( grep { $_ eq $role } @{ $_[0]->user->memberof } ) {
            $code->(@_);
        }
        else {
            die 'access-denied!';
        }
      }
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;

