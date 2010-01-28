package Acao::Model::Revisor;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;

txn_method 'listar_leituras' => authorized 'revisor' => sub {
	my $self = shift;
	
	return $self->dbic->resultset('Leitura')->search({
		'revisores.dn' => $self->user->id
	},
	{
		prefetch => {'instrumento' => 'projeto'},
		join => 'revisores',
	});
};

txn_method 'obter_leitura' => authorized 'revisor' => sub {
    my ($self, $id_leitura) = @_;
    
    return $self->dbic->resultset('Leitura')->find(
    {
        'revisores.dn' => $self->user->id,
        'me.id_leitura' => $id_leitura,
    },
    {
        prefetch => {'instrumento' => 'projeto'},
        join => 'revisores',
    });
};

txn_method 'aprovar' => authorized 'revisor' => sub {
    my ($self, $leitura, $id_doc) = @_;
    $id_doc =~ s/\"\\//gs;
    $self->sedna->begin;
    $self->sedna->execute('UPDATE replace $a in
              collection("leitura-'.$leitura->id_leitura.'")/registroDigitacao/documento/estado[../id="'.$id_doc.'"]
              with <estado>Aprovado</estado>');
    $self->sedna->commit;
};

txn_method 'rejeitar' => authorized 'revisor' => sub {
    my ($self, $leitura, $id_doc) = @_;
    $id_doc =~ s/\"\\//gs;
    $self->sedna->begin;
    $self->sedna->execute('UPDATE replace $a in
              collection("leitura-'.$leitura->id_leitura.'")/registroDigitacao/documento/estado[../id="'.$id_doc.'"]
              with <estado>Rejeitado</estado>');
    $self->sedna->commit;
};

txn_method 'obter_campo_controle' => authorized 'revisor' => sub {
    my ($self, $leitura, $id_doc) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->begin;
    $self->sedna->execute('for $x in collection("leitura-'.$leitura->id_leitura.'")/registroDigitacao/documento[id = "'.$id_doc.'"] return data($x/controle)');
    $xml = $self->sedna->get_item;
    $self->sedna->commit;
    return $xml;
};

txn_method 'visualizar' => authorized 'revisor' => sub {
    my ($self, $leitura, $id_doc) = @_;
    $id_doc =~ s/\"\\//gs;
    my $xml;
    $self->sedna->begin;
    $self->sedna->execute('for $x in collection("leitura-'.$leitura->id_leitura.'")/registroDigitacao/documento[id = "'.$id_doc.'"] return $x/conteudo/*');
    $xml = $self->sedna->get_item;
    $self->sedna->commit;
    return $xml;
};

txn_method 'obter_xsd_leitura' => authorized 'revisor' => sub {
    my ($self, $leitura) = @_;
    return $self->sedna->get_document($leitura->instrumento->xml_schema);
};

