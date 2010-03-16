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
    my ( $self, $id_definicao_consolidacao ) = @_;
    return $self->dbic->resultset('DefinicaoConsolidacao')->find(
        {
            'consolidador.dn'              => $self->user->id,
            'me.id_definicao_consolidacao' => $id_definicao_consolidacao
        },
        {
            prefetch => 'projeto',
            join     => 'consolidador',
        }
    );
};

txn_method 'obter_consolidacao' => authorized 'consolidador' => sub {
    my ( $self, $id_consolidacao ) = @_;
    return $self->dbic->resultset('Consolidacao')->find(
        {
            'consolidador.dn'    => $self->user->id,
            'me.id_consolidacao' => $id_consolidacao
        },

# prefetch tem funcao similar a do join diferenciando por trazer os elementos na clausula select
        {
            prefetch => [
                'alertas',
                { 'definicao_consolidacao' => [ 'consolidador', 'projeto' ] }
            ],
        }
    );
};

txn_method iniciar_consolidacao => authorized 'consolidador' => sub {
    my ( $self, $definicao_consolidacao ) = @_;
    my $consolidacao = $definicao_consolidacao->consolidacao->create(
        {
            status   => 'Criada',
            data_ini => DateTime->now(),
            dn       => $self->user->id
        }
    );

    my $script = Acao->path_to('script/acao_consolida.pl');

    if ( my $pid = fork() ) {
        return $consolidacao;
    }
    else {
        close STDOUT;
        close STDIN;
        my $pid = system( $^X, $script, $consolidacao->id_consolidacao,
            $self->user->id );
        use POSIX ":sys_wait_h";
        waitpid( $pid, WNOHANG );
        exit;
    }
};

1;
