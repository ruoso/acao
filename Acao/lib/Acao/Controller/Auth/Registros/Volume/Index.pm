package Acao::Controller::Auth::Registros::Volume::Index;

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
use namespace::autoclean;
BEGIN { extends 'Catalyst::Controller'; }
use Data::Dumper;
use List::MoreUtils 'pairwise';




=head1 NAME

Acao::Controller::Auth::Registros::Volume::Dossie - Controlador
que implementa as ações de digitação de uma leitura específica.

=head1 ACTIONS

=over

=item base

Carrega para o stash os dados do dossiê.

=cut

sub base : Chained('/auth/registros/volume/base') : PathPart('index') : CaptureArgs(0) {
    my ($self) = @_;
}

sub formIndexes : Chained('base') : PathPart('') : Args(0) {
    my ($self, $c) = @_;
}

sub findIndexes : Chained('base') : PathPart('findIndexes') : Args(0) {
    my ($self, $c) = @_;
    my @keys = ($c->req->param);
    my %hashIndexes;
    foreach (@keys) {
        unless ($_ eq 'buscar') {
            $hashIndexes{$_} = $c->req->param($_);
        }
    }
    my $entries = $c->model('Volume')->buscar_no_indice(\%hashIndexes);
    warn Dumper($entries);

    $c->stash->{entries} = $entries;
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
