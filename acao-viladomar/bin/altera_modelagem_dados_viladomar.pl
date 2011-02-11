use Sedna;
use warnings;
use lib '/home/pauloneto/devel/acao/Acao/lib';
use Acao;
use strict;

local $/ = undef;
open(FILE,"../consultas/prontuarios_viladomar.txt");
my $xquery = <FILE>;
close FILE;

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

{   package DumbUser;
    use Moose;
    sub memberof {[ Acao->config->{roles}{dossie}{criar}, Acao->config->{roles}{volume}{criar} , Acao->config->{roles}{documento}{criar}]}
    sub uid {'importacao.vila.do.mar'}
    sub id {'importacao.vila.do.mar'}
    sub cn {'Importação Vila do Mar'}
}

my %auth = (
    autorizacao => {
        principal => 'paulo.neto',
        role => [qw(alterar criar listar visualizar)]
    }
);

sub init{
    my $id_volume = criaVolume();
    my @documentos;
    #inicia a conexão com o sedna
    $sedna->begin;
    #executa a consulta
    $sedna->execute($xquery);
    my $i = 1;
     while ($sedna->next){
        push(@documentos,$sedna->getItem());
        warn "consultando... ", $i++;
     }
    $sedna->commit;
    $sedna->begin;
    for (my $i=0; $i<scalar@documentos; $i=$i+2){
        $sedna->loadData( $documentos[$i], $documentos[$i+1], "volume-8EDE55BE-2EE6-11E0-B564-1D84EDEBDB25" );
        $sedna->endLoadData();
        warn "Protuario " . $documentos[$i+1] . "inserido";
    }
    $sedna->commit;
}

sub criaVolume{
    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; for $x in collection("volume")/vol:volume[vol:nome/text() eq "Vila do Mar"]/vol:collection/text() return $x';
    my $collection;
    $sedna->begin;
    $sedna->execute($xq);
    $collection = $sedna->getItem();
    $sedna->commit;
    if($collection){
        warn "collection Vila do Mar encontrada com id $collection";
    }else{
        my($nome, $representaVolumeFisico, $classificacao, $localizacao,$autorizacoes, $ip) = ('Vila do Mar' , 0, 'cn=Habitação', '', \%auth , '127.0.0.1');
        my $model = Acao::Model::Volume->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);
        $collection = $model->criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao, $autorizacoes, $ip);
        warn "collection $collection criada com sucesso!";
    }
    return $collection;
}

init();
