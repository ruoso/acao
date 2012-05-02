use Sedna;
use strict;
use warnings;
use Switch;

use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

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
    my $xq;   
    $sedna->begin;

    for (my $i = 0; $i < scalar @volumes; $i++) {
        warn $volumes[$i];
        if ($volumes[$i] eq 'volume-2633497e-7395-411b-9587-a9ec8da00c05') {
          $xq = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                 update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacao with
                 <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>cn=Prestação de Serviços à Comunidade,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=assuntos,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                 </classificacoes>|;
          $sedna->execute($xq);
        } 
        else {
          $xq =  q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                  update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacao with
                  <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>cn=Liberdade Assistida,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=assuntos,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                  </classificacoes>|;
          $sedna->execute($xq);
        }

    }

    $sedna->commit;

}

sub altera_dados_volume {

    $sedna->begin;

    my $xqclass_la = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                   update replace $x in collection("volume")/ns:volume[ns:collection != "volume-2633497e-7395-411b-9587-a9ec8da00c05"]/ns:classificacao with 
                   <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                       <class:classificacao>cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Liberdade Assistida,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                   </classificacoes>';
    my $xqclass_psc = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                   update replace $x in collection("volume")/ns:volume[ns:collection = "volume-2633497e-7395-411b-9587-a9ec8da00c05"]/ns:classificacao with 
                   <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                       <class:classificacao>cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                       <class:classificacao>cn=Prestação de Serviços à Comunidade,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos</class:classificacao>
                   </classificacoes>';

    $sedna->execute($xqclass_la);
    $sedna->execute($xqclass_psc);

    my $xql  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:localizacao with 
                <localizacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">ser=SERCEFOR,dc=local,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br</localizacao>';

    $sedna->execute($xql);


    my $xqa  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:autorizacao with 
                <autorizacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:author="http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd">
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="alterar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="criar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="listar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="visualizar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=intranet,dc=cti,dc=fortaleza,dc=ce,dc=gov,dc=br" role="transferir"/>
                </autorizacoes>';

    $sedna->execute($xqa);

    $sedna->commit;
}

getVolumes();
