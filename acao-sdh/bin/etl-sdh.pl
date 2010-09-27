use Sedna;
use XML::Compile::Schema;
use XML::Compile::Util qw(pack_type);
use DBIx::Class::Schema;
use File::Spec::Functions;
use FindBin qw($Bin);
use lib catfile($Bin, '..', 'lib');
use DateTime::Format::XSD;
use strict;
use warnings;

use aliased 'Acao::Plugins::SDH::DimSchema';

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');

my $dbi = DimSchema->connect("dbi:Pg:dbname=sdh;host=127.0.0.1;port=5432",'acao','blableblibloblu');

sub extract {

 #   my ($id_volume) = @_;

    my $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
              let $sorted-people := 
                    for $x in collection("volume-011BA75E-C712-11DF-8789-B79CE9E43239")/dos:dossie[dos:controle=1]/dos:doc/dc:documento 
                        order by ($x/dc:criacao) descending  
                    return $x/dc:documento/dc:conteudo/*
                        [namespace-uri($x/dc:documento/dc:conteudo/*) = "http://schemas.fortaleza.ce.gov.br/acao/sdh-documentacaoFamiliar.xsd"]  
                    for $x at $count in subsequence($sorted-people, 1,1) return $x';

    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);

  while ($sedna->next){
        #atribui os itens retornados da consulta acima na variavel $xsd sob a forma de XML String
        my $xml_string = $sedna->getItem();
  }
    $sedna->commit;
}

sub transform {

}

sub load{
 $dbi->resultset('DAtendimentoadolescentesatividade')->create({raca => "preto tissão"})
}
 extract();
 load();
