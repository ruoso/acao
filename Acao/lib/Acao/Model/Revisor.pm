package Acao::Model::Revisor;
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

my $revisor = Acao->config->{roles}{revisor};

=head1 NAME

Acao::Model::Revisor - Lógica de negócios para o papel de revisor

=head1 DESCRIPTION

Este é o controlador que implementa as regras de negócios específicas
para o papel de revisor.

=head1 METHODS

=over

=item listar_leituras()

Este método retorna as leituras que o usuário atual tem acesso como
revisor.

=cut

txn_method 'listar_leituras' => authorized $revisor => sub {
    my $self = shift;

    return $self->dbic->resultset('Leitura')->search(
        { 'revisores.dn' => $self->user->get('entrydn') },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'revisores',
        }
    );
};

=item obter_leitura($id_leitura)

Este método retorna a objeto da entidade leitura, ao mesmo tempo que
valida a permissão de acesso do usuário autenticado a essa leitura
específica.

=cut

txn_method 'obter_leitura' => authorized $revisor => sub {
    my ( $self, $id_leitura ) = @_;

    return $self->dbic->resultset('Leitura')->find(
        {
            'revisores.dn'  => $self->user->get('entrydn'),
            'me.id_leitura' => $id_leitura,
        },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'revisores',
        }
    );
};

=item aprovar($leitura, $id_doc, $controle)

Este método irá aprovar, dentro do grupo indicado por $controle, o
documento de id $id_doc. Esta ação irá resultar na rejeição automática
de todos os outros documentos desse grupo, de forma que nunca exista
mais de um documento aprovado em um grupo.

=cut

txn_method 'aprovar' => authorized $revisor => sub {
    my ( $self, $leitura, $id_doc, $controle ) = @_;
    $id_doc =~ s/\"\\//gs;

    #Recupera o estadoControle do documento

    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in subsequence(collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:controle="'
          . $controle
          . '"],1,2) return data($x/cd:estadoControle)'
    );
    my $estadoControle = $self->sedna->get_item;

    if ( $estadoControle ne "Fechado" ) {

        #Aprova a digitacao selecionada

        $self->sedna->execute('declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
                        	     UPDATE replace $a in collection("leitura-'. $leitura->id_leitura. '")
                                        /cd:registroDigitacao/cd:documento/cd:estado[../cd:controle="'. $controle . '"]
                                    with ( if ($a[../cd:id="' . $id_doc . '"]) then ( <cd:estado>Aprovado</cd:estado> )
                                             else ( <cd:estado>Rejeitado</cd:estado> ) )'
                             );
    }
    else {
        die 'estadocontrole-fechado';

    }

};

=item rejeitar($leitura, $id_doc, $controle)

Este método implementa o processo de rejeitar o documento $id_doc. Ao
contrário do método aprovar, ele não irá alterar os outros documentos,
uma vez que é possível que todos os documentos de um grupo sejam
rejeitados.

=cut

txn_method 'rejeitar' => authorized $revisor => sub {
    my ( $self, $leitura, $id_doc, $controle ) = @_;
    $id_doc =~ s/\"\\//gs;

    #Recupera o estadoControle do documento

    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in subsequence(collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:controle="'
          . $controle
          . '"],1,2) return data($x/cd:estadoControle)'
    );
    my $estadoControle = $self->sedna->get_item;

    if ( $estadoControle ne "Fechado" ) {

        #Rejeita a digitacao selecionada

        $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
	     UPDATE replace $a in
                  collection("leitura-'
              . $leitura->id_leitura
              . '")/cd:registroDigitacao/cd:documento/cd:estado[../cd:id="'
              . $id_doc . '"]
                  with (
                        <cd:estado>Rejeitado</cd:estado>
                  )'
        );
    }
    else {
        die 'estadocontrole-fechado';
    }
};

=item fecharDocumento($leitura, $controle)

Este método irá fechar os documentos com o código $controle, de forma
que não será mais possível inserir novas digitações ou alterar os
estados de aprovação e rejeição.

=cut

txn_method 'fecharDocumento' => authorized $revisor => sub {
    my ( $self, $leitura, $controle ) = @_;

    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
          for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:controle="'
          . $controle . '"] 
            where $x/cd:estado = "Digitado" 
            return count($x)'
    );
    my $qtdDigitados = $self->sedna->get_item;
    if (!$@){
        if ( $qtdDigitados >= 1 ) {
            die 'digitacoes-naoRevisadas';
        }
        else {
            $self->sedna->execute(
    'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
		     UPDATE replace $a in
		                        collection("leitura-'
                  . $leitura->id_leitura
                  . '")/cd:registroDigitacao/cd:documento/cd:estadoControle[../cd:controle="'
                  . $controle . '"]
		                        with (
		                            <cd:estadoControle>Fechado</cd:estadoControle>
		                        )'
            );
        }
    }
};

=item obter_campo_controle($id_leitura, $id_doc)

Retorna o valor do campo controle para um determinado documento.

=cut

txn_method 'obter_campo_controle' => authorized $revisor => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
	     for $x in collection("leitura-'. $leitura->id_leitura. '")/cd:registroDigitacao/
            cd:documento[cd:id = "'. $id_doc . '"] return data($x/cd:controle)'
    );
    $xml = $self->sedna->get_item;
    return $xml;
};

=item visualizar($leitura, $id_doc)

Retorna o conteúdo do documento com id $id_doc para visualização.

=cut

txn_method 'visualizar' => authorized $revisor => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute(
'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:id = "'
          . $id_doc
          . '"] return $x/cd:conteudo/*'
    );
    $xml = $self->sedna->get_item;
    return $xml;
};

=item obter_xsd_leitura($leitura)

Retorna o documento XSD para a leitura informada.

=cut

txn_method 'obter_xsd_leitura' => authorized $revisor => sub {
    my ( $self, $leitura ) = @_;
    return $self->sedna->get_document( $leitura->instrumento->xml_schema );
};

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
