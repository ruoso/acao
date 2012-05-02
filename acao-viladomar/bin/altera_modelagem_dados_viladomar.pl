use Sedna;
use warnings;
use lib '/home/pauloneto/devel/acao/Acao/lib';
use Acao;
use strict;
use utf8;

local $/ = undef;
open(FILE, "<:encoding(UTF-8)", "../consultas/prontuarios_viladomar.txt");
my $xquery = <FILE>;
close FILE;

#my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');
my $sedna = Sedna->connect('127.0.0.1', 'AcaoDb', 'acao', '12345');
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

{   package DumbUser;
    use Moose;
    sub memberof {[ Acao->config->{roles}{dossie}{criar}, Acao->config->{roles}{volume}{criar} , Acao->config->{roles}{documento}{criar}]}
    sub uid {'importacao.vila.do.mar'}
    sub id {'importacao.vila.do.mar'}
    sub cn {'Importação vila.do.mar'}
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
       # if ($i > 50){
       #     last;
       # }
     }
    $sedna->commit;
    $sedna->begin;
    for (my $i=0; $i<scalar@documentos; $i=$i+2){
        $sedna->loadData( $documentos[$i], $documentos[$i+1], $id_volume );
        $sedna->endLoadData();
        warn "Protuario " . $documentos[$i+1] . " inserido com sucesso!";
    }
    $sedna->commit;
}

sub criaVolume{
    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; for $x in collection("volume")/vol:volume[vol:nome/text() eq "VILA DO MAR"]/vol:collection/text() return $x';
    my $collection;
    $sedna->begin;
    $sedna->execute($xq);
    $collection = $sedna->getItem();
    $sedna->commit;
    if($collection){
        warn "collection Vila do Mar encontrada com id $collection";
    }else{
        my($nome, $representaVolumeFisico, $classificacao, $localizacao,$autorizacoes, $ip) = ('VILA DO MAR' , 0, {'classificacao' => ["cn=Vila do Mar,cn=Habitação,dc=assuntos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br"]}, '', $auth , '127.0.0.1');
        my $model = Acao::Model::Volume->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);
        $collection = $model->criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao, $auth, $ip);
        warn "collection $collection criada com sucesso!";
    }
    return $collection;
}

init();
