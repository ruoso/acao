#!/usr/bin/perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Sedna;
use warnings;
use lib '/home/edilson/devel-programa-acao/acao/Acao/lib';
use Acao;
use utf8;
use Data::Dumper;

my $collection;
my $sedna = Sedna->connect('127.0.0.1', 'AcaoDb', 'acao', '12345');
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

{   package DumbUser;
    use Moose;
    sub memberof {[ Acao->config->{roles}{dossie}{criar}, Acao->config->{roles}{volume}{criar} , Acao->config->{roles}{documento}{criar}]}
    sub uid {'importacao.pronasci'}
    sub id {'importacao.pronasci'}
    sub cn {'Importação Pronasci'}
}

my $auth = {
          'autorizacao' => [
                           {
                             'principal' => 'ou=SIS,o=CTI,o=GP,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br',
                             'role' => 'alterar'
                           },
                           {
                             'principal' => 'ou=SIS,o=CTI,o=GP,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br',
                             'role' => 'criar'
                           },
                           {
                             'principal' => 'ou=SIS,o=CTI,o=GP,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br',
                             'role' => 'listar'
                           },
                           {
                             'principal' => 'ou=SIS,o=CTI,o=GP,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br',
                             'role' => 'visualizar'
                           },
                           {
                             'principal' => 'ou=SIS,o=CTI,o=GP,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br',
                             'role' => 'transferir'
                           }
                         ]
        };

my $model = Acao::Model::Dossie->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);

sub extract{
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse('/home/pauloneto/BANCO DE CADASTRO DE TODOS OS JOVENS ATUALIZADO.xls');

    if ( !defined $workbook ) {
            die $parser->error(), ".\n";
    }

    for my $worksheet ( $workbook->worksheets() ) {
#            my $worksheet = $workbook->worksheet(0);
            my ( $row_min, $row_max ) = $worksheet->row_range();
            my ( $col_min, $col_max ) = $worksheet->col_range();

            for my $row ( $row_min +1 .. $row_max ) {
#                for my $col ( $col_min .. $col_max ) {
my $col = 0;
                    my $nome = $worksheet->get_cell( $row, $col )->value;
                    my $idade = $worksheet->get_cell( $row, $col + 1 );
                    my $endereco = $worksheet->get_cell( $row, $col + 2);
                    my $bairro = $worksheet->get_cell( $row, $col + 3);
                    my $fone = $worksheet->get_cell( $row, $col + 4);
                    my $interesse = $worksheet->get_cell( $row, $col + 5);
                    utf8::encode($nome);
                    utf8::encode($idade);
                    utf8::encode($endereco);
                    utf8::encode($bairro);
                    utf8::encode($fone);
                    utf8::encode($interesse);

                    next unless $nome;

    #               print "Row, Col    = ($row, $col)\n";
    #               print "Value       = ", $cell->value(),       "\n";
    #               print "Unformatted = ", $cell->unformatted(), "\n";
    #               print "\n";
    #                warn "Preparando ". $cell->value();
    #                my $value = $cell->value;
    #                utf8::encode($value);
warn $nome;
                    load($nome);
#            }
        }
    }
}

sub transform{}

sub load{
    my $nomeProntuario = shift;
   # criarProntuario($nomeProntuario);
}

sub criarProntuario(){
     my $nome = shift;
     my($representaDossieFisico, $classificacao, $localizacao,$autorizacoes, $ip, $herdar_author, $id_volume) = 
       (0, {'classificacao' => ["cn=Protejo,cn=Infância e Adolescência,cn=Segurança Pública"]}, 'SERCEFOR', $auth , '127.0.0.1', 1, $collection);
     my $prontuario = $model->criar_dossie($ip, $nome, $id_volume, $representaDossieFisico, $classificacao, $localizacao, $herdar_author, $autorizacoes);
     warn "Prontuario $nome criado com sucesso!";
}

sub criarDocumento{

}

sub criaVolume{
    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; for $x in collection("volume")/vol:volume[vol:nome/text() eq "PROTEJO"]/vol:collection/text() return $x';
    $sedna->begin;
    $sedna->execute($xq);
    $collection = $sedna->getItem();
    $sedna->commit;
    if($collection){
        warn "collection Protejo encontrada com id $collection";
    }else{
        my($nome, $representaVolumeFisico, $classificacao, $localizacao,$autorizacoes, $ip) = ('PROTEJO' , 0, {'classificacao' => ["cn=Protejo,cn=Infância e Adolescência,cn=Segurança Pública,dc=assuntos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br"]}, '', $auth , '127.0.0.1');
        my $model = Acao::Model::Volume->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);
        $collection = $model->criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao, $auth, $ip);
        warn "collection $collection criada com sucesso!";
    }
    return $collection;
}

criaVolume();
extract();
