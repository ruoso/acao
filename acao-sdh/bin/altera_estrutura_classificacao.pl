use Sedna;
use strict;
use warnings;
use Switch;

my $sedna = Sedna->connect('127.0.0.1', 'acao', 'acao', '12345');
my $novo_nome;
my $valor = 1;
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

sub getVolumes{

    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
              for $x in collection("volume")/vol:volume/vol:collection/text() return $x';

    my @volumes;
    #inicia a conexão com o sedna
    $sedna->begin;

    #executa a consulta
    $sedna->execute($xq);
     while ($sedna->next){
        push(@volumes, $sedna->getItem());
     }
    for (my $i = 0; $i < scalar @volumes; $i++) {
        $volumes[$i]=~ s/^\s+//;
    }

    $sedna->commit;

    altera_dados_dossie(@volumes);

    altera_dados_volume();
    
}


sub altera_dados_dossie {
    my (@volumes) = @_;
   
    for (my $i = 0; $i < scalar @volumes; $i++) {
        $sedna->begin;
        my $xq = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                  update replace $x in collection("'.$volumes[$i].'")/ns:dossie/ns:classificacao with
                  <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>{$x/text()}</class:classificacao>
                  </classificacoes>';

        $sedna->execute($xq);
        $sedna->commit;

    }

}

sub altera_dados_volume {

    $sedna->begin;

    my $xq  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
               update replace $x in collection("volume")/ns:volume/ns:classificacao with 
               <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                <class:classificacao>{$x/text()}</class:classificacao>
               </classificacoes>';

    $sedna->execute($xq);
    $sedna->commit;
}

getVolumes();
