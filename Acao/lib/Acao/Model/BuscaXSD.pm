package Acao::Model::BuscaXSD;
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

use base 'Catalyst::Model';
use XML::LibXML;
use Acao::Util::AnnotatedSimpleType;
use strict;
use warnings;
use 5.10.0;

sub get_simpletype_annotations {
    my ($self, $xsd) = @_;
    utf8::upgrade($xsd);
    my $schemadoc = XML::LibXML->load_xml(string => $xsd);
    my $schemabaseel = $schemadoc->getDocumentElement;
    my $targetns = $schemabaseel->getAttribute('targetNamespace');
    my ($stack, $stelements) = ([], []);
    Acao::Util::AnnotatedSimpleType::traverse_schema($schemabaseel,$targetns,$schemabaseel,$stack,$stelements);
    return $stelements;
}

sub get_target_namespace {
    my ($self, $xsd) = @_;
    utf8::upgrade($xsd);
    my $schemadoc = XML::LibXML->load_xml(string => $xsd);
    my $schemabaseel = $schemadoc->getDocumentElement;
    return $schemabaseel->getAttribute('targetNamespace');
}

sub produce_xpath {
    my ($self, $nsprefix, $path_form) = @_;
    return
        join '/',
        map { $nsprefix.':'.$_ }
        grep { $_ }
        map { s/[^0-9a-zA-Z\_\-]//gs; $_ }
        split /\//, $path_form;
}

sub produce_expr {
    my ($self, $nsprefix, $path_form, $oper, $valor)= @_;
    my $operador;
    given ($oper) {
        when ('igual') {
            $operador = 'eq';
        }
        when ('diferente') {
            $operador = 'ne';
        }
        when ('maior') {
            $operador = 'gt';
        }
        when ('menor') {
            $operador = 'lt';
        }
        default {
            die 'submissao-invalida';
        }
    }
    return join ' ', $self->produce_xpath($nsprefix, $path_form), $operador, $self->quote_valor($valor);
}

sub quote_valor {
    my ($self, $valor) = @_;
    $valor =~ s/\\/\\\\/gs;
    $valor =~ s/\"/\\\"/gs;
    $valor =~ s/\'/\\\'/gs;
    return q(").$valor.q(");
}

1;
