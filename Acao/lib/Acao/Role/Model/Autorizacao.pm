package Acao::Role::Model::Autorizacao;

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
use Data::Dumper;

parameter xmlcompile => (
    isa      => 'XML::Compile::Schema',
    required => 1,
);

parameter namespace => (
    isa      => 'Str',
    required => 1,
);

role {
    my $p          = shift;
    my $xmlcompile = $p->xmlcompile;
    my $ns         = $p->namespace;
    my $reader =
      $xmlcompile->compile( READER => pack_type( $ns, 'autorizacoes' ) );
    my $writer = $xmlcompile->compile(
        WRITER                => pack_type( $ns, 'autorizacoes' ),
        use_default_namespace => 1
    );

    method new_autorizacao => sub {
        my ( $self, $initial_principals ) = @_;
        my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
        if ($initial_principals) {
            return $writer->(
                $doc,
                {
                    autorizacao => $self->build_autorizacao_AoH(
                        $initial_principals,
                        [qw(alterar criar listar visualizar transferir)]
                    )
                }
            )->toString;
        }
        else {
            return $writer->( $doc, { autorizacao => [] } )->toString;
        }

    };

    method add_autorizacoes => sub {
        my ( $self, $xml_autorizacoes, $AoH_novas_autorizacoes ) = @_;
        my $hash = $reader->($xml_autorizacoes);
        push @{ $hash->{autorizacao} }, @$AoH_novas_autorizacoes;
        my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
        return $writer->( $doc, $hash )->toString;
    };

    method remove_autorizacoes => sub {
        my ( $self, $xml_autorizacoes, @positions ) = @_;
        my $hash = $reader->($xml_autorizacoes);
        splice @{ $hash->{autorizacao} }, $_, 1, () for reverse sort @positions;
        my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
        return $writer->( $doc, $hash )->toString;
    };

    method build_autorizacao_AoH => sub {
        my ( $self, $principal, $role ) = @_;
        my @cart_p     = sort( (@$principal) x @$role );
        my @cart_r     = (@$role) x @$principal;
        my @permissoes = pairwise { { principal => $a, role => $b } } @cart_p,
          @cart_r;
        return \@permissoes;
    };

    method desserialize_autorizacoes => sub {
        my ( $self, $xml_autorizacoes ) = @_;
        return $reader->($xml_autorizacoes);
    };

    method serialize_autorizacoes => sub {
        my ( $self, $autorizacoes_h ) = @_;
        my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
        return $writer->( $doc, $autorizacoes_h )->toString;
    };

=item autorizacoes_do_volume()

Este método retona um XML das Autorizações do Volume

=cut

    method autorizacoes_do_volume => sub {
        my ( $self, $id_volume ) = @_;

        my $query =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
          . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
          . 'for $x in collection("volume")/ns:volume[ns:collection = "'
          . $id_volume . '"] '
          . 'return <autorizacoes xmlns="'
          . $ns
          . '">{$x/ns:autorizacoes/*}</autorizacoes>';
        $self->sedna->begin;
        $self->sedna->execute($query);
        my $xml = $self->sedna->get_item();
        $self->sedna->commit;
        return $xml;
    };

=item _checa_autorizacao_volume()

Este método retorna/checa as autorização de um Volume de acordo.
com a ação passada como parametro.


=cut

    method _checa_autorizacao_volume => sub {
        my ( $self, $id_volume, $acao ) = @_;
        my $grupos = join ' or ',
          map { '@principal = "' . $_ . '"' } @{ $self->user->memberof };

        my $query =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
          . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
          . 'for $x in collection("volume")/ns:volume[ns:collection = "'
          . $id_volume . '"] '
          . 'where $x/ns:autorizacoes/author:autorizacao[('
          . $grupos
          . ') and @role="'
          . $acao . '"] '
          . 'return $x/ns:autorizacoes';
        $self->sedna->begin;
        $self->sedna->execute($query);
        my $xml = $self->sedna->get_item();


        $self->sedna->commit;
        return $xml;
    };
=item _checa_autorizacao_dossie()

Este método retorna/checa as autorização de Dossie de acordo com a ação
passada como parametro.
Também verifica se o volume a qual o Dossie pertence permite realizar
a ação desejada, como: 'transferir' e 'criar'.


=cut

    method _checa_autorizacao_dossie => sub {
        my ( $self, $id_volume, $acao, $controle ) = @_;
        my $grupos = join ' or ',
          map { '@principal = "' . $_ . '"' } @{ $self->user->memberof };
        my $check = '(' . $grupos . ') and @role="' . $acao . '"';
        my $herdar =
            '(author:autorizacao[('
          . $check
          . ')] or (@herdar=1 and (collection("volume")/vol:volume[vol:collection="'
          . $id_volume
          . '"]/vol:autorizacoes/author:autorizacao['
          . $check . '])))';

        my $query =
    'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";'
          . 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
          . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
          . 'for $x in collection("'
          . $id_volume
          . '")/ns:dossie[ns:controle = "'
          . $controle . '"] '
          . 'where $x/ns:autorizacoes['
          . $herdar . '] '
          . 'return 1';

        $self->sedna->begin;
        $self->sedna->execute($query);
        my $ret = $self->sedna->get_item();

        $self->sedna->commit;

        return $ret;
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
