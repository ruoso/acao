package Acao::Model::Sedna;

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
use utf8;

use base 'Catalyst::Model::Sedna';

=head1 NAME

Acao::Model::Sedna - Subclasse de Catalyst::Model::Sedna

=head1 DESCRIPTION

Esta classe implementa algumas funcionalidades específicas no acesso
ao Sedna.

=head1 METHODS

=over

=item new($app, $attr)

Especializado para definir o atributo AUTOCOMMIT para OFF.

=cut


sub new {
    my $self = shift;
    $self = $self->SUPER::new(@_);
    $self->conn->setConnectionAttr(
        AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );
    return $self;
}

=item get_document($id)

Retorna o conteúdo de um documento pelo seu $id.

=cut

sub get_document {
    my ( $self, $doc ) = @_;
    $self->execute( 'for $x in doc("' . $doc . '") return $x' );
    my $data = $self->get_item;
    return $data;
}

=item get_collection($id)

Retorna o conteúdo de uma collection pelo seu $id.

=cut

sub get_collection {
    my ( $self, $doc ) = @_;
    $self->execute( 'for $x in collection("' . $doc . '") return $x' );
    my $data = $self->get_item;
    return $data;
}

=item store_document($xml, $doc_id, $collection)

Salva o documento $xml utilizando o id $doc_id na collection de nome
$collection. Essa collection deve ser criada previamente.

=cut

sub store_document {
    my ( $self, $xml, $doc_id, $collection ) = @_;
    $self->conn->loadData( $xml, $doc_id, $collection );
    $self->conn->endLoadData();
}

sub execute {
	my $self = shift;

	my $ret;
	eval {
		$ret = $self->SUPER::execute(@_);
	};

	if ($@) {
		my $config = Acao->config->{'Model::Sedna'};
		$self->{conn} =  Sedna->connect(
				$config->{url},
				$config->{db_name},
				$config->{login},
				$config->{password}
		);

		$self->{conn}->setConnectionAttr(%{$config->{attr}}) if exists $config->{attr} && ref $config->{attr} eq 'HASH';

		$ret = $self->SUPER::execute(@_);
	}
	return $ret;
}

sub begin {
	my $self = shift;

	my $ret;
	eval {
		$ret = $self->SUPER::begin(@_);
	};

	if ($@) {
		my $config = Acao->config->{'Model::Sedna'};
		$self->{conn} =  Sedna->connect(
				$config->{url},
				$config->{db_name},
				$config->{login},
				$config->{password}
		);

		$self->{conn}->setConnectionAttr(%{$config->{attr}}) if exists $config->{attr} && ref $config->{attr} eq 'HASH';

		$ret = $self->SUPER::begin(@_);
	}
	return $ret;
}

=back

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
