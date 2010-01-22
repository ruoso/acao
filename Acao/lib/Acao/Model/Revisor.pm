package Acao::Model::Revisor;
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;

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
	my ($self,$id_leitura) = @_;
	
	return $self->dbic->resultset('Leitura')->find({
		'revisores.dn' => $self->user->id,
		'me.id_leitura' => $id_leitura,
	},
	{
		prefetch => {'instrumento' => 'projeto'},
		join => 'revisores',
	});
	
};