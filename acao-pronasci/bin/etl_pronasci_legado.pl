#!/usr/bin/perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Sedna;
use warnings;
use lib '/home/pauloneto/devel/acao/Acao/lib';
use Acao;
use utf8;


my $sedna = Sedna->connect('172.30.116.22', 'AcaoDb', 'acao', '12345');
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

{   package DumbUser;
    use Moose;
    sub memberof {[ Acao->config->{roles}{dossie}{criar}, Acao->config->{roles}{volume}{criar} , Acao->config->{roles}{documento}{criar}]}
    sub uid {'importacao.pronasci'}
    sub id {'importacao.pronasci'}
    sub cn {'Importação Pronasci'}
}

my %auth = (
    autorizacao => {
        principal => 'paulo.neto',
        role => [qw(alterar criar listar visualizar)]
    }
);

my $model = Acao::Model::Dossie->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);

sub extract{
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse('/home/pauloneto/PLANILHA DOS JOVENS CADASTRADOS NO PROTEJO.xls');

    if ( !defined $workbook ) {
            die $parser->error(), ".\n";
    }

    for my $worksheet ( $workbook->worksheets() ) {

            my ( $row_min, $row_max ) = $worksheet->row_range();
            my ( $col_min, $col_max ) = $worksheet->col_range();

            for my $row ( $row_min .. $row_max ) {
                for my $col ( $col_min .. $col_max ) {

                    my $cell = $worksheet->get_cell( $row, $col );
                    next unless $cell;

    #               print "Row, Col    = ($row, $col)\n";
    #               print "Value       = ", $cell->value(),       "\n";
    #               print "Unformatted = ", $cell->unformatted(), "\n";
    #               print "\n";
                    warn "Preparando ". $cell->value();
                    my $value = $cell->value;
                    utf8::encode($value);
                    load($value);
            }
        }
    }
}

sub transform{}

sub load{
    my $nomeProntuario = shift;
    criarPrntuario($nomeProntuario);
}

sub criarPrntuario(){
     my $nome = shift;
     my($representaDossieFisico, $classificacao, $localizacao,$autorizacoes, $ip, $herdar_author, $id_volume) = 
       (0, {'classificacao' => ["cn=Protejo,cn=Infância e Adolescência,cn=Segurança Pública"]}, 'SERCEFOR', \%auth , '127.0.0.1', 1, 'volume-4D9D2944-5485-11E0-A3EB-A024E72DC907');
     my $prontuario = $model->criar_dossie($ip, $nome, $id_volume, $representaDossieFisico, $classificacao, $localizacao, $herdar_author, $autorizacoes);
     warn "Prontuario $nome criado com sucesso!";
}

extract();

