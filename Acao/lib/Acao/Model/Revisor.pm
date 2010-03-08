package Acao::Model::Revisor;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;

txn_method 'listar_leituras' => authorized 'revisor' => sub {
    my $self = shift;

    return $self->dbic->resultset('Leitura')->search(
        { 'revisores.dn' => $self->user->id },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'revisores',
        }
    );
};

txn_method 'obter_leitura' => authorized 'revisor' => sub {
    my ( $self, $id_leitura ) = @_;

    return $self->dbic->resultset('Leitura')->find(
        {
            'revisores.dn'  => $self->user->id,
            'me.id_leitura' => $id_leitura,
        },
        {
            prefetch => { 'instrumento' => 'projeto' },
            join     => 'revisores',
        }
    );
};

txn_method 'aprovar' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc, $controle ) = @_;
    $id_doc =~ s/\"\\//gs;

    #Recupera o estadoControle do documento

    $self->sedna->execute( 'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in subsequence(collection("leitura-'
        . $leitura->id_leitura
        . '")/cd:registroDigitacao/cd:documento[cd:controle="'
        . $controle
        . '"],1,2) return data($x/cd:estadoControle)' );
    my $estadoControle = $self->sedna->get_item;

    if ( $estadoControle ne "Fechado" ) {

        #Aprova a digitacao selecionada

        $self->sedna->execute(
            'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
	     UPDATE replace $a in
                  collection("leitura-'
              . $leitura->id_leitura
              . '")/cd:registroDigitacao/cd:documento/cd:estado[../cd:controle="'
              . $controle . '"]
                  with (
                      if ($a[../cd:id="' . $id_doc . '"]) then (
                        <cd:estado>Aprovado</cd:estado>
                      ) else (
                        <cd:estado>Rejeitado</cd:estado>
                      )
                  )'
        );
    } else {
	die 'estadocontrole-fechado';

    }

};

txn_method 'rejeitar' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc, $controle ) = @_;
    $id_doc =~ s/\"\\//gs;

    #Recupera o estadoControle do documento

    $self->sedna->execute( 'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in subsequence(collection("leitura-'
        . $leitura->id_leitura
        . '")/cd:registroDigitacao/cd:documento[cd:controle="'
        . $controle
        . '"],1,2) return data($x/cd:estadoControle)' );
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
     } else {
	die 'estadocontrole-fechado';
     }
};

txn_method 'fecharDocumento' => authorized 'revisor' => sub {
    my ( $self, $leitura, $controle ) = @_;

    $self->sedna->execute(
        'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
          for $x in collection("leitura-'.$leitura->id_leitura.'")/cd:registroDigitacao/cd:documento[cd:controle="'.$controle.'"] 
            where $x/cd:estado = "Digitado" 
            return count($x)'
    );
    my $qtdDigitados = $self->sedna->get_item;
    
    if ($qtdDigitados >= 1) {
            die 'digitacoes-naoRevisadas';
    } else {
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

};

txn_method 'obter_campo_controle' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute(
            'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
	     for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:id = "'
          . $id_doc . '"] 
                            return data($x/cd:controle)'
    );
    $xml = $self->sedna->get_item;
    return $xml;
};

txn_method 'visualizar' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute( 'declare namespace cd = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
			    for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/cd:registroDigitacao/cd:documento[cd:id = "'
          . $id_doc
          . '"] return $x/cd:conteudo/*' );
    $xml = $self->sedna->get_item;
    return $xml;
};

txn_method 'diferencas' => authorized 'revisor' => sub {
    my ( $self, $leitura, $controle ) = @_;

};

txn_method 'obter_xsd_leitura' => authorized 'revisor' => sub {
    my ( $self, $leitura ) = @_;
    return $self->sedna->get_document( $leitura->instrumento->xml_schema );
};

