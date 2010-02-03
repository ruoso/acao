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

    $self->sedna->execute( 'for $x in subsequence(collection("leitura-'
        . $leitura->id_leitura
        . '")/registroDigitacao/documento[controle="'
        . $controle
        . '"],1,2) return data($x/estadoControle)' );
    my $estadoControle = $self->sedna->get_item;

    if ( $estadoControle ne "Fechado" ) {

        #Aprova a digitacao selecionada

        $self->sedna->execute(
            'UPDATE replace $a in
                  collection("leitura-'
              . $leitura->id_leitura
              . '")/registroDigitacao/documento/estado[../controle="'
              . $controle . '"]
                  with (
                      if ($a[../id="' . $id_doc . '"]) then (
                        <estado>Aprovado</estado>
                      ) else (
                        <estado>Rejeitado</estado>
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

    $self->sedna->execute( 'for $x in subsequence(collection("leitura-'
        . $leitura->id_leitura
        . '")/registroDigitacao/documento[controle="'
        . $controle
        . '"],1,2) return data($x/estadoControle)' );
    my $estadoControle = $self->sedna->get_item;

    if ( $estadoControle ne "Fechado" ) {

        #Rejeita a digitacao selecionada

        $self->sedna->execute(
            'UPDATE replace $a in
                  collection("leitura-'
              . $leitura->id_leitura
              . '")/registroDigitacao/documento/estado[../id="'
              . $id_doc . '"]
                  with (
                        <estado>Rejeitado</estado>
                  )'
        );
     } else {
	die 'estadocontrole-fechado';
     }
};

txn_method 'fecharDocumento' => authorized 'revisor' => sub {
    my ( $self, $leitura, $controle ) = @_;

    $self->sedna->execute(
        'for $x in collection("leitura-'.$leitura->id_leitura.'")//registroDigitacao/documento[controle="'.$controle.'"] 
            where $x/estado = "Digitado" 
            return count($x)'
    );
    my $qtdDigitados = $self->sedna->get_item;
    
    if ($qtdDigitados >= 1) {
            die 'digitacoes-naoRevisadas';
    } else {
	    $self->sedna->execute(
		'UPDATE replace $a in
		                    collection("leitura-'
		  . $leitura->id_leitura
		  . '")/registroDigitacao/documento/estadoControle[../controle="'
		  . $controle . '"]
		                    with (
		                        <estadoControle>Fechado</estadoControle>
		                    )'
	    );
    }

};

txn_method 'obter_campo_controle' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute(
            'for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/registroDigitacao/documento[id = "'
          . $id_doc . '"] 
                            return data($x/controle)'
    );
    $xml = $self->sedna->get_item;
    return $xml;
};

txn_method 'visualizar' => authorized 'revisor' => sub {
    my ( $self, $leitura, $id_doc ) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->execute( 'for $x in collection("leitura-'
          . $leitura->id_leitura
          . '")/registroDigitacao/documento[id = "'
          . $id_doc
          . '"] return $x/conteudo/*' );
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

