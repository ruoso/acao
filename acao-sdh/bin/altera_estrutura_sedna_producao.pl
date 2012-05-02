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

    my @volumes;

    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; 
              for $x in collection("volume")/vol:volume/vol:collection/text() return $x';
    $sedna->begin;
    $sedna->execute($xq);

    while ($sedna->next){
        push(@volumes, $sedna->getItem());
    }

    for (my $i = 0; $i < scalar @volumes; $i++) {
        $volumes[$i]=~ s/^\s+//;
    }

    $sedna->commit;

    altera_dados_dossie_documentos(@volumes);

    altera_dados_volume();

}


sub altera_dados_dossie_documentos {
    my (@volumes) = @_;
    my $xq;   
    $sedna->begin;
    
    #altera classificacao nos protuarios
    for (my $i = 0; $i < scalar @volumes; $i++) {
        warn $volumes[$i];
        $xq = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
             update replace $x in collection("|.$volumes[$i].q|")/ns:dossie/ns:classificacao with
             <classificacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd"></classificacoes>|;
        $sedna->execute($xq);

        # removendo a tag audit (auditoria) dos dossies
        my $xqauditdossie = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                              update delete collection("|.$volumes[$i].q|")/ns:dossie/ns:audit|;
        $sedna->execute($xqauditdossie);

        # removendo a tag localizacao dos dossies
        my $xqlocaldossie = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                              update delete collection("|.$volumes[$i].q|")/ns:dossie/ns:localizacao|;
        $sedna->execute($xqlocaldossie);

        # removendo a tag audit (auditoria) dos documentos
        my $xqauditdoc = q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                           declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
                           update delete collection("|.$volumes[$i].q|")/ns:dossie/ns:doc/dc:documento/dc:audit|;
        $sedna->execute($xqauditdoc);

        # incluindo heranca de autorizacao do volume
        my $xqauthordossie q|declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
                            declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";
                            update replace $x in collection(|.$volumes[$i].q|)/ns:dossie/ns:autorizacao with
                            <autorizacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd" xmlns:author="http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd" herdar="1"></autorizacoes>|;
        $sedna->execute($xqauthordossie);

    }

    $sedna->commit;

}

sub altera_dados_volume {

    $sedna->begin;
    #alterando estrutura de classificacao nos volumes
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
    
    #alterando estrutura de localizacao nos volumes
    my $xqlocal = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                   update replace $x in collection("volume")/ns:volume/ns:localizacao with 
                   <localizacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">ser=SERCEFOR,dc=local,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br</localizacao>';

    $sedna->execute($xqlocal);

    #alterando estrutura de autorização nos volumes
    my $xqauto = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                  update replace $x in collection("volume")/ns:volume/ns:autorizacao with 
                  <autorizacoes xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd" xmlns:author="http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd">
                      <author:autorizacao principal="ou=SE GARANTA,ou=FUNCI,ou=SECEXE,ou=SECMUN,o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="alterar"/>
                      <author:autorizacao principal="ou=SE GARANTA,ou=FUNCI,ou=SECEXE,ou=SECMUN,o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="criar"/>
                      <author:autorizacao principal="ou=SE GARANTA,ou=FUNCI,ou=SECEXE,ou=SECMUN,o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="listar"/>
                      <author:autorizacao principal="ou=SE GARANTA,ou=FUNCI,ou=SECEXE,ou=SECMUN,o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="visualizar"/>
                      <author:autorizacao principal="ou=SE GARANTA,ou=FUNCI,ou=SECEXE,ou=SECMUN,o=SDH,o=PMF,dc=adm,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br" role="transferir"/>
                  </autorizacoes>';

    $sedna->execute($xqauto);

    #apagando auditoria dentro dos XMLs
    my $xqaudit = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                   update delete collection("volume")/ns:volume/ns:audit';

    $sedna->execute($xqaudit);

    $sedna->commit;

}

getVolumes();
