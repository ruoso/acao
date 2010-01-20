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
}