package Acao::Role::Model::Indices;

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
use Moose::Role;
use Encode;
use XML::Compile::Schema;
use XML::Compile::Util;
use Data::Dumper;

use constant IDX_NS => 'http://schemas.fortaleza.ce.gov.br/acao/indexhint.xsd';
my $controle =
  XML::Compile::Schema->new( Acao->path_to('schemas/indexhint.xsd') );
my $controle_w = $controle->compile(
    WRITER                => pack_type( IDX_NS, 'index' ),
    use_default_namespace => 1
);
my $controle_r = $controle->compile( READER => pack_type( IDX_NS, 'index' ) );



=head1 NAME

Acao::Model::Indices - Classe modelo para os indices

=head1 DESCRIPTION

Essa classe implementa as ações de acesso ao banco de dados dos índices.

=head1 METHODS

=over

=item insert_indices()

Este método realiza a inserção dos índices no banco de dados da indexação,
associados ao documento que está sendo incluído no sedna

=cut

sub insert_indices {
    my ( $self, $id_volume, $controle, $id_documento, $xsd, $xml ) = @_;

    #Obtém o nome do volume ao qual pertecem o prontuário e o documento
    my $nm_volume = $self->get_nm_volume($id_volume);

    #Obtém o nome do prontuário ao qual pertence o documento
    my $nm_prontuario = $self->get_nm_prontuario( $id_volume, $controle );
    my ( $idx_data, $label ) = $self->get_xsd_info($xsd);

    #Constrói o resumo do índice inserido
    my $resumo = "$nm_volume - $nm_prontuario - $label";
    my $indices =
      $self->extract_xml_keys( $xsd, $idx_data, $id_volume, $controle,
        $id_documento );
    my $autorizacoes_vol = $self->extract_autorizacoes_volume($id_volume);
    my ( $autorizacoes_dos, $herda_dos ) =
      $self->extract_autorizacoes_dossie( $id_volume, $controle );
    my $v = $self->dbic->resultset('Volume')->find_or_create(
        {
            id_volume         => $id_volume,
            nome              => $nm_volume,
            permissao_volumes => $autorizacoes_vol
        }
    );
    my $dossie = $v->dossies->find_or_create(
        {
            id_dossie         => $controle,
            nome              => $nm_prontuario,
            permissao_dossies => $autorizacoes_dos,
            herda_permissoes  => $herda_dos
        }
    );
    my $doc = $dossie->entries->find_or_create(
        {
            documento        => $id_documento,
            resumo           => $resumo,
            gin_indexes      => $indices,
            herda_permissoes => 1
        }
    );
}

=item drop_indices()

Este método realiza a remoção dos índices reladionados a um documento no
banco de dados de indexação

=cut

sub drop_indices {
    my ( $self, $id_volume, $controle, $id_documento ) = @_;
    my $entry = $self->dbic->resultset('Entry')->find(
        {
            volume    => $id_volume,
            dossie    => $controle,
            documento => $id_documento,
        }
    );
    $entry->gin_indexes->delete();
    $entry->permissoes->delete();
    $entry->delete();
}

=item update_autorizacoes_vol()

Altera as autorizações do volume no banco de indexação

=cut

sub update_autorizacoes_vol {
    my ($self, $id_volume, $autorizacoes) = @_;

    my $auth_list = [ map { { dn => $_->{principal} }} grep { $_->{role} eq 'listar'} @{$autorizacoes->{'autorizacao'}} ];

    $self->dbic->resultset('PermissaoVolume')->search({
        id_volume => $id_volume
    })->delete();
    my $volprs = $self->dbic->resultset('Volume')->find({
        id_volume => $id_volume
    })->permissao_volumes;
    $volprs->create($_) for @$auth_list;
}

=item update_autorizacoes_dos()

Altera as autorizações dos dossiês no banco de indexação

=cut

sub update_autorizacoes_dos {
    my ($self, $id_volume, $controle, $autorizacoes) = @_;

    my $auth_list = [ map { { dn => $_->{principal} }} grep { $_->{role} eq 'listar'} @{$autorizacoes->{'autorizacao'}} ];
    
    $self->dbic->resultset('PermissaoDossie')->search({
        id_volume => $id_volume,
        id_dossie => $controle
    })->delete();
    my $dosprs = $self->dbic->resultset('Dossie')->find({
        id_volume => $id_volume,
        id_dossie => $controle
    })->permissao_dossies;

    $dosprs->create($_) for @$auth_list;
}

=item get_xsd_info()

Obtém as informações sobre os índices o tipo do documento que foi inserido

=cut

sub get_xsd_info {
    my ( $self, $ns ) = @_;

    my $xq = 'declare namespace xs="http://www.w3.org/2001/XMLSchema";
              declare namespace xhtml="http://www.w3.org/1999/xhtml";
              declare namespace idx="http://schemas.fortaleza.ce.gov.br/acao/indexhint.xsd"; 
              for $x in collection("acao-schemas")/xs:schema[@targetNamespace="'
      . $ns . '"] 
              return ( $x/xs:element[1]/xs:annotation/xs:appinfo/xhtml:label/text(),
                       $x/xs:element[1]/xs:annotation/xs:appinfo/idx:index )';
    $self->sedna->execute($xq);
    my $label = $self->sedna->get_item;
    $label =~ s/^\s+|\s+$//gs;
    my $idx = $self->sedna->get_item;

    if ($idx) {
        my $octets = encode( 'utf8', $idx );
        my $idx_data = $controle_r->($octets);
        return $idx_data, $label;
    }
    else {
        return {}, $label;
    }
}

=item extract_xml_keys()

Prepara todos os índices e seus valores a serem inseridos no banco
retornando-os em um array para serem inseridos.

=cut

sub extract_xml_keys {
    my $self = shift;
    my ( $ns, $idx_data, $id_volume, $controle, $id_documento ) = @_;

    my $xqueryret = join ', ',
      map { '"' . $_->{key} . '"', $self->normalize_xpath( 'x', $_->{xpath} ) }
      @{ $idx_data->{hint} };

    my $xquery =
'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                  declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                  declare namespace x="' . $ns . '";
                  for $x in collection("'
      . $id_volume
      . '")/ns:dossie[ns:controle="'
      . $controle . '"]
                       /ns:doc/dc:documento[dc:id="'
      . $id_documento
      . '"]/dc:documento/dc:conteudo
                  return (' . $xqueryret . ')';

    my @xmldata;
    $self->sedna->execute($xquery);
    while ( my $key = $self->sedna->get_item ) {
        my $val = $self->sedna->get_item;
        $key =~ s/^\s+|\s+$//gs;
        $val =~ s/^\s+|\s+$//gs;
        next unless $val;
        push @xmldata, { key => $key, value => $val };
    }

    return \@xmldata;
}

=item extract_autorizacoes_volume()

Extrai os valores do parâmetro principal das tags de autorizacao
do volume relacionado com os índices em inclusão

=cut

sub extract_autorizacoes_volume {
    my $self = shift;
    my ($id_volume) = @_;
    my $xquery =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                  declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";
                  for $x in collection("volume")/ns:volume[ns:collection = "'
      . $id_volume . '"] 
                      return $x/ns:autorizacoes/author:autorizacao[@role="listar"]/@principal/string()';
    my %dns;
    $self->sedna->execute($xquery);
    while ( my $autorizacao = $self->sedna->get_item ) {
        $autorizacao =~ s/^\s+|\s+$//gs;
        $dns{$autorizacao} = 1;
    }
    return [ map { { dn => $_ } } keys %dns ];
}

=item extract_autorizacoes_dossie()

Extrai os valores do parâmetro principal das tags de autorizacao
do dossie relacionado com os índices em inclusão

=cut

sub extract_autorizacoes_dossie {
    my $self = shift;
    my ( $id_volume, $controle ) = @_;
    my $xquery =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                  declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";
                  for $x in collection("'
      . $id_volume
      . '")/ns:dossie[ns:controle = "'
      . $controle . '"] 
                        return ( if ($x/ns:autorizacoes/@herdar/string())
                                 then ($x/ns:autorizacoes/@herdar/string())
                                 else ("0"),
                                 $x/ns:autorizacoes/author:autorizacao[@role="listar"]/@principal/string() )';
    my %dns;
    $self->sedna->execute($xquery);
    my $herda = $self->sedna->get_item;

    while ( my $autorizacao = $self->sedna->get_item ) {
        $autorizacao =~ s/^\s+|\s+$//gs;
        $dns{$autorizacao} = 1;
    }
    return [ map { { dn => $_ } } keys %dns ], $herda;
}

=item normalize_xpath()

Normaliza o xpath associado a cada índice, para que os mesmos possam
ser utilizados corretamente nas buscas pelos valores associados a estes
índices.

=cut

sub normalize_xpath {
    my ( $self, $prefix, $xpath ) = @_;
    my $with_prefix = join '/', map { $prefix . ':' . $_ } split /\//, $xpath;
    return 'concat("",$x/' . $with_prefix . '/text())';
}

=item get_nm_volume()

Obtém o nome do volume especificado pelo id enviado por parâmetro

=cut

sub get_nm_volume {
    my $self = shift;
    my ($id_volume) = @_;
    my $xquery =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
                  for $x in collection("volume")/ns:volume[ns:collection="'
      . $id_volume
      . '"]/ns:nome 
                  return $x/text()';
    $self->sedna->execute($xquery);
    my $nm_volume = $self->sedna->get_item;
    return $nm_volume;
}

=item get_nm_prontuario()

Obtém o nome do prontuário especificado pelo id do volume e id do prontuário 
enviados por parâmetro

=cut

sub get_nm_prontuario {
    my $self = shift;
    my ( $id_volume, $id_prontuario ) = @_;
    my $xquery =
'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; 
                  for $x in collection("' . $id_volume . '")
                  /ns:dossie[ns:controle="' . $id_prontuario . '"]/ns:nome 
                  return $x/text()';
    $self->sedna->execute($xquery);
    my $nm_prontuario = $self->sedna->get_item;
    return $nm_prontuario;
}

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
