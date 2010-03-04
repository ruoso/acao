package Acao::Model::Consolidador;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;
use DateTime;

txn_method 'listar_definicoes_consolidacao' => authorized 'consolidador' => sub {
    my $self = shift;

    # sera dentro de uma transacao, e so pode ser usado por consolidadores
    return $self->dbic->resultset('DefinicaoConsolidacao')->search(
        { 'consolidador.dn' => $self->user->id },
        {
            prefetch => 'projeto',
            join     => 'consolidador',
        }
    );
};

42;
