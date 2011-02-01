package Acao::Model::Indices;
# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;
use Encode;
use XML::LibXML;
use XML::Compile::Schema;
use DateTime;
use DBIx::Class::Schema;
use XML::Compile::Util qw(pack_type);
use Data::Dumper;

=head1 NAME

Acao::Model::Indices - Classe modelo para os indices

=head1 DESCRIPTION

Essa classe implementa as ações de acesso ao banco de dados dos índices.

=head1 METHODS

=over

=item insert_indices()

Este método retorna a lista de definições de consolidação que esse
usuário tem acesso.

=cut

txn_method 'insert_indices' => sub {
	my ($self, $id_volume, $controle, $id_documento, $xsd, $xml) = @_;
    my $indices = $self->extract_xml_keys($xsd, $xml);
    my $resumo = "Volume $id_volume - Dossiê $controle - Documento $id_documento";
	my $entry_id =  $self->dbic->resultset('Entry')->find_or_create({ volume =>  $id_volume, 
								dossie => $controle, 
								documento => $id_documento,
								resumo => $resumo})->entry_id;


    if ($xsd == 'http://schemas.fortaleza.ce.gov.br/acao/sdh-identificacaoPessoal.xsd') {
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.nome', value => $xml_data->{nomeCompleto}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.nomemae', value => $xml_data->{filiacao}->{mae}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.nomepai', value => $xml_data->{filiacao}->{pai}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.datanascimento', value => $xml_data->{dataNascimento}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.sexo', value => $xml_data->{sexo}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.naturalidade', value => $xml_data->{naturalidade}, entry => $entry_id});
        $self->dbic->resultset('GinIndex')->create({key => 'pessoa.etnia', value => $xml_data->{racaEtinia}, entry => $entry_id});
    }
};

sub convert_xml_hash {
    my $self = shift;   
    my ($xsdDocumento, $xml) = @_;
    
    $self->sedna->execute('for $x in collection("acao-schemas")[xs:schema/@targetNamespace="'.$xsdDocumento.'"] return $x');

    my $xsd = $self->sedna->get_item;
    my $octets = encode('utf8', $xsd);

    my $x_c_s    = XML::Compile::Schema->new($octets);
    my @elements = $x_c_s->elements;

    my $read = $x_c_s->compile( READER => $elements[0] );
    my $writ = $x_c_s->compile( WRITER => $elements[0], use_default_namespace => 1 );
    my $xml_en = encode('utf8', $xml);

    my $input_doc = XML::LibXML->load_xml( string => $xml_en );

    my $element   = $input_doc->getDocumentElement;

    my $xml_data  = $read->($element); 

    return $xml_data;
    
};

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

42;
