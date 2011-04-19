use Sedna;
use strict;
use warnings;
use Switch;

use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $sedna = Sedna->connect('127.0.0.1', 'AcaoDb', 'AcaoDb', '12345');
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

    #selecionando apenas os volumes da sdh cadastrados durante o processo de digitação realizado no Instituto Atlantico
    @volumes = ("volume-2633497e-7395-411b-9587-a9ec8da00c05","volume-2806aceb-8b63-4452-8ed2-97d421b7f990","volume-4f021d95-9342-47e9-8be7-25647f1763eb","volume-ae285d25-3c95-480c-9bab-26e13b315761","volume-b76f25db-223a-4440-b2d6-5d8231791cec","volume-fbca2985-c3be-45a5-8d6e-0e5796acdf34");

    altera_dados_dossie(@volumes);

    altera_dados_volume(@volumes);
    
}


sub altera_dados_dossie {
    my (@volumes) = @_;
    my $xq;   
    $sedna->begin;

    for (my $i = 0; $i < scalar @volumes; $i++) {

        if ($volumes[$i] eq 'volume-2633497e-7395-411b-9587-a9ec8da00c05') {

          my $xq = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                 update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacao with
                 <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>cn=Prestação de Serviços à Comunidade,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                 </classificacoes>|;

          $sedna->execute($xq);

          my $xqy = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                 update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacoes with
                 <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                    <class:classificacao>cn=Prestação de Serviços à Comunidade,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                 </classificacoes>|;

          $sedna->execute($xqy);
        }
        else {

          my $xq =  q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                      update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacao with
                        <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                            <class:classificacao>cn=Liberdade Assistida,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                        </classificacoes>|;

          $sedna->execute($xq);

          my $xqy =  q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                      update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacoes with
                        <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                            <class:classificacao>cn=Liberdade Assistida,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                        </classificacoes>|;

          $sedna->execute($xqy);

        }

    }

    $sedna->commit;

}

sub altera_dados_volume {

    my (@volumes) = @_;
    $sedna->begin;
    
    for (my $i = 0; $i < scalar @volumes; $i++) {
        
        if ($volumes[$i] eq 'volume-2633497e-7395-411b-9587-a9ec8da00c05') {

            my $xqc  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                        declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";
                        update replace $x in collection("volume")/ns:volume/ns:classificacoes with 
                        <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                            <class:classificacao>cn=Prestação de Serviços à Comunidade,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                        </classificacoes>';
            warn $xqc;
            #$sedna->execute($xqc);

        }
        else {
            my $xqc  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                        declare namespace class = "http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";
                        update replace $x in collection("volume")/ns:volume/ns:classificacoes with 
                        <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd">
                            <class:classificacao>cn=Liberdade Assistida,cn=Programa SE GARANTA,cn=Criança e Adolescente,cn=Direitos Humanos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</class:classificacao>
                        </classificacoes>';
            warn $xqc;
            #$sedna->execute($xqc);
        }

    }

    my $xql  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:localizacao with 
                <localizacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">ser=SERCEFOR,dc=local,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</localizacao>';

    $sedna->execute($xql);

    my $xqa  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                update replace $x in collection("volume")/ns:volume/ns:autorizacao with 
                <autorizacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:author="http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd">
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="alterar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="criar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="listar"/>
                    <author:autorizacao principal="o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="visualizar"/>
                </autorizacoes>';

    $sedna->execute($xqa);

    $sedna->commit;
}

getVolumes();
