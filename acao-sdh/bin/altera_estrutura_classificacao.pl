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
                    <class:classificacao>cn=Direitos Humanos,dc=assuntos,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                  </classificacoes>';

        $sedna->execute($xq);

        $sedna->commit;

    }

}

sub altera_dados_volume {

    $sedna->begin;

    my $xqc  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:classificacao with 
                <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>cn=Direitos Humanos,dc=assuntos,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                </classificacoes>';

    $sedna->execute($xqc);

    my $xql  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:localizacao
                with <localizacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">ser=SERCEFOR,dc=local,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</localizacao>';

    $sedna->execute($xql);


    my $xqa  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:autorizacao with 
                <autorizacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:author="http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd">
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="alterar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="criar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="listar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="visualizar"/>
                </autorizacoes>';

    $sedna->execute($xqa);

    $sedna->commit;
}

getVolumes();
