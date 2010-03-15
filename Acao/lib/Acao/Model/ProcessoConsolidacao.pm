package Acao::Model::ProcessoConsolidacao;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;
use XML::Compile::Schema;
use XML::Compile::Util qw(pack_type);

use constant CONSOLIDACAO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd';

my $controle =
  XML::Compile::Schema->new( Acao->path_to('schemas/controleconsolidacao.xsd') );
my $controle_r = $controle->compile( READER => pack_type(CONSOLIDACAO_NS, 'registroConsolidacao'),
				     any_element => 'TAKE_ALL' );

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

	# vamos incluir os "lib" dos plugins no nosso @INC
	my $plugins_path = Acao->path_to('plugins');
	my $plugins_dir;
	opendir $plugins_dir, $plugins_path;
	while (my $subdir = readdir $plugins_dir) {
		next if $subdir eq '.';
		next if $subdir eq '..';
		my $final = join '/', $plugins_path, $subdir, 'lib'; 
		push @INC, $final;
	}
	closedir $plugins_dir;

	my @plugins_entrada = 
		$consolidacao->definicao_consolidacao->etapa_coleta_dados->all;
	foreach my $plugin_entrada (@plugins_entrada) {
		my $classe = $plugin_entrada->plugin_coleta_dados;
		eval "require $classe";
		if ($@) {
                        my $erro_original = $@;
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro carregando plugin - '.$erro_original });
			exit 1;
		}

		eval {
			my $obj = $classe->new({ dbic => $self->dbic,
						 user => $self->user,
						 sedna => $self->sedna });
 			$obj->processar($consolidacao,'TODO');
		};
		if ($@) {
                        my $erro_original = $@;
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro executando coleta de dados - '.$erro_original });
			exit 1;
		}
	}

	# inicia a etapa de validação.
        $etapa = 2;

	# vamos percorrer todos os documentos do collection de entrada
 	# dessa consolidacao e executar todos os plugins de validação para cada
	# um deles.

	my @plugins_validacao = map { $_->plugin_validacao }
		$consolidacao->definicao_consolidacao->etapa_validacao->all;
	my @objetos_plugins_validacao;
	foreach my $classe (@plugins_validacao) {
		eval "require $classe";
		if ($@) {
                        my $erro_original = $@;
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro carregando plugin - '.$erro_original });
			exit 1;
		}
		eval {
			my $obj = $classe->new({ dbic => $self->dbic,
						 user => $self->user,
						 sedna => $self->sedna });
			push @objetos_plugins_validacao, $obj;
		};
		if ($@) {
                        my $erro_original = $@;
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'FATAL',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro inicializando plugin - '.$erro_original });
			exit 1;
		}
	}

	$self->sedna->begin;
	# temos que obter o xml-schema dessa consolidacao
	my $schema_str = $self->sedna->get_document($consolidacao->definicao_consolidacao->xml_schema);
	# agora vamos compilar esse schema..
	my $schema = XML::Compile::Schema->new($schema_str);

	my $schema_element = ($schema->elements)[0];

	# vamos importar as definicoes dos schemas das leituras
	foreach my $entrada ($consolidacao->definicao_consolidacao->entrada_consolidacao
                              ({},{prefetch => { leitura => 'instrumento' }})->all) {
		my $doc_name = $entrada->leitura->instrumento->xml_schema;
		my $doc_str = $self->sedna->get_document($doc_name);
		$schema->importDefinitions($doc_str);
	}

        my $schema_r = $schema->compile( READER => $schema_element);
        my $schema_w = $schema->compile( WRITER => $schema_element, use_default_namespace => 1 );


	$consolidacao->alertas->create
		({ etapa => $etapa,
		   log_level => 'TRACE',
		   datahora => DateTime->now(),
		   descricao_alerta => 'Vai iniciar o processo de validacao' });


	my $query_todos = 'for $x in collection("consolidacao-entrada-'.$id_consolidacao.'") return $x';
	$self->sedna->execute($query_todos);
	while (my $doc = $self->sedna->get_item) {

	    my ($registroConsolidacao, $conteudo);
		warn $doc;
	    eval {
              # fazer o parse do registroConsolidacao
  	      $registroConsolidacao = $controle_r->($doc);
	      # fazer o parse do conteudo...
	      my $element = $registroConsolidacao->{documento}{conteudo}{$schema_element}[0];
	      $conteudo = $schema_r->($element);
            };

	    if ($@) {
                my $erro_original = $@;
		$consolidacao->alertas->create
			({ etapa => $etapa,
			   log_level => 'FATAL',
			   datahora => DateTime->now(),
			   descricao_alerta => 'Inconsistencia no registro XML, validacao falhou - '.$erro_original });
		next;
	    }

	    $consolidacao->alertas->create
		({ etapa => $etapa,
		   log_level => 'TRACE',
		   datahora => DateTime->now(),
		   descricao_alerta => 'Vai validar o documento '.$registroConsolidacao->{documento}{id} });

  	    foreach my $obj (@objetos_plugins_validacao) {
		eval {
 			$obj->processar($consolidacao, $registroConsolidacao, $conteudo);
		};
		if ($@) {
                        my $erro_original = $@;
			$consolidacao->alertas->create
				({ etapa => $etapa,
				   log_level => 'ERROR',
				   datahora => DateTime->now(),
				   descricao_alerta => 'Erro validando documento - '.$erro_original });
		}
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
