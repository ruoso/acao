package Acao::Model::ProcessoConsolidacao;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

sub iniciar_consolidacao {
	my ($self, $id_consolidacao) = @_;
	sleep 1; # garante que a transação de fora acabou.

	my $consolidacao = $self->dbic->resultset('Consolidacao')->find
		({ id_consolidacao => $id_consolidacao },
		 { prefetch => { definicao_consolidacao =>
				 [qw( entrada_consolidacao
				      etapa_coleta_dados
				      etapa_transformacao
				      etapa_validacao
				      projeto )] } });

	# prapara os dados de consolidacao...
	$self->preparar_consolidacao($consolidacao);

	# executa a etapa de coleta
	my $etapa = 1;
	my @plugins_entrada = 
		$consolidacao->definicao_consolidacao->etapa_coleta_dados->all;
	foreach my $plugin_entrada (@plugins_entrada) {
		my $classe = $plugin_entrada->plugin_coleta_dados;
		if (eval "require $classe") {

		} else {
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro carregando plugin - '.$@ });
			die;
		}
	}

}

txn_method 'preparar_consolidacao' => sub {
	my ($self, $consolidacao) = @_;
	my $etapa = 1;

	$consolidacao->alertas->create
		({ etapa => $etapa,
		   log_level => 'TRACE',
		   datahora => DateTime->now(),
		   descricao_alerta => 'Iniciando o processo de consolidação' });

	eval {
		my $id_consolidacao = $consolidacao->id_consolidacao;
		my $nome_collection_entrada = 'consolidacao-entrada-'.$id_consolidacao;

		eval {
			$self->sedna->execute("CREATE COLLECTION '$nome_collection_entrada'");
		};
		if ($@) {
			die 'Erro criando a Collection: '.$@;
		}

		$consolidacao->alertas->create
			({ etapa => 1,
			   log_level => 'TRACE',
			   datahora => DateTime->now(),
			   descricao_alerta => 'Criada Collection de entrada, prosseguindo para entrada de dados.' });

	};
	if ($@) {
		my $erro_original = join ' ',$@;
		eval {
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro específico: '.$erro_original });
		};
		if ($@) {
			warn 'Ocorreu um erro ao registrar o alerta de erro - '.$erro_original.' - '.$@;
		}
	}
};

1;
