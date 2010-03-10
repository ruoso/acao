package Acao::Model::Consolidador;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

use XML::LibXML;
use XML::Compile::Schema;
use DateTime;

txn_method 'listar_definicao_consolidacao' => authorized 'consolidador' => sub {
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

txn_method 'obter_definicao_consolidacao' => authorized 'consolidador' => sub {
    my ($self, $id_definicao_consolidacao) = @_;

    # sera dentro de uma transacao, e so pode ser usado por consolidadores
    return $self->dbic->resultset('DefinicaoConsolidacao')->find(
        { 'consolidador.dn' => $self->user->id,
          'me.id_definicao_consolidacao' => $id_definicao_consolidacao },
        { prefetch => 'projeto',
          join     => 'consolidador',
        }
    );
};

txn_method 'obter_consolidacao' => authorized 'consolidador' => sub {
    my ($self, $id_consolidacao) = @_;

    return $self->dbic->resultset('Consolidacao')->search(
        { 'me.id_consolidacao' => $id_consolidacao },
        { prefetch     => 'alertas',
        }
    );
};

#txn_method 'listar_consolidacao' => authorized 'consolidador' => sub {
#    my $self = shift;
#
#    return $self->dbic->resultset('DefinicaoConsolidacao')->search(
#        { 'consolidador.dn' => $self->user->id },
#        {
#            prefetch => [ 'entrada_consolidacao',  'consolidacao' ],
#	    join     => 'consolidador',
#        }
#    );
#};

#txn_method 'obter_leitura' => authorized 'digitador' => sub {
#    my ( $self, $id_leitura ) = @_;
#
#    return $self->dbic->resultset('Leitura')->find(
#        {
#            'digitadores.dn' => $self->user->id,
#            'me.id_leitura'  => $id_leitura,
#        },
#        {
#            prefetch => { 'instrumento' => 'projeto' },
#            join     => 'digitadores',
#        }
#    );
#};
42;
