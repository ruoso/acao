package Acao::Model::Digitador;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;

txn_method 'listar_leituras' => authorized 'digitador' => sub {
    my $self = shift;
    # sera dentro de uma transacao, e so pode ser usado por digitadores
    return $self->dbic->resultset('Leitura')->search({
        'digitadores.dn' => $self->user->id
    },
    {
        prefetch => { 'instrumento' => 'projeto' },
        join => 'digitadores',
    });
};

txn_method 'obter_leitura' => authorized 'digitador' => sub {
    my ($self, $id_leitura) = @_;
    
    return $self->dbic->resultset('Leitura')->find(
    {
        'digitadores.dn' => $self->user->id,
        'me.id_leitura' => $id_leitura,
    },
    {
        prefetch => {'instrumento' => 'projeto'},
        join => 'digitadores',
    });
};

txn_method 'obter_xsd_leitura' => authorized 'digitador' => sub {
    my ($self, $leitura) = @_;
    return $self->sedna->get_document($leitura->instrumento->xml_schema);
};

txn_method 'salvar_digitacao' => authorized 'digitador' => sub {
    my ($self, $leitura, $xml) = @_;
    my $docname = join '_', 'digitacao', $leitura->instrumento->projeto->id_projeto, $leitura->instrumento->nome,
                                         $leitura->id_leitura, $self->user->id, time;

    my $xsd = $self->sedna->get_document($leitura->instrumento->xml_schema);
    my $x_c_s = XML::Compile::Schema->new($xsd);
    my $read = $x_c_s->compile(READER => 'formCadernoA');
    my $writ = $x_c_s->compile(WRITER => 'formCadernoA');

    my $doc = XML::LibXML::Document->new('1.0', 'UTF-8');
    my $xml_data = $read->($xml);

    my $res_xml = $writ->($doc, $xml_data);

    $docname =~ s/[^a-zA-Z0-9]/_/gs;
    $self->sedna->store_document($res_xml->toString, $docname, 'leitura-'.$leitura->id_leitura);
};

42;
