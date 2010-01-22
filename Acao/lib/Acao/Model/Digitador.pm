package Acao::Model::Digitador;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

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
    $docname =~ s/[^a-zA-Z0-9]/_/gs;
    $self->sedna->store_document($xml, $docname, 'leitura-'.$leitura->id_leitura);
};

42;
