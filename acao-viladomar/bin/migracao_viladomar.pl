use Sedna;
use warnings;
use lib '/home/pauloneto/devel/acao/Acao/lib';
use Acao;
use Data::Dumper;
use strict;
use utf8;
use Storable;



local $/ = undef;
open(FILE, "<:encoding(UTF-8)", "../consultas/migracao_vm.txt");
my $xquery = <FILE>;
close FILE;

my $sedna = Sedna->connect('127.0.0.1', 'AcaoDb', 'acao', '12345');
#my $sedna = Sedna->connect('172.30.116.73', 'acao', 'acao', '12345');
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
	my %documentos;

	$sedna->begin;
	$sedna->execute($xquery);

	my $i = 1;
	while ($sedna->next){
		warn "consultando... $i" unless  $i%100;
		my $controle = $sedna->getItem();
		$controle =~ s/\D//go;
		$sedna->next;
		$documentos{$controle} = $sedna->getItem();
		$i++;
	}

	$sedna->commit;

        store \%documentos, 'documentos.st';
#for \$z in collection("leitura-1")[cc:registroDigitacao/cc:documento/cc:controle/text()="$ctrl" and cc:registroDigitacao/cc:documento/cc:estado/text() eq "Rejeitado"]
	my $counter = 0;
	for my $ctrl (keys %documentos) {
		$counter++;
		warn "preparando... $counter" unless  $counter%100;
#consulta todos os forms caderno A com estado rejeitado
		my $xq = qq|declare namespace cc = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
declare namespace vc = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
declare namespace fa = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernoa.xsd";
declare namespace fb = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernob.xsd";
declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
declare namespace class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";

for \$z in index-scan("controle1", "$ctrl", 'EQ')[cc:documento/cc:estado/text() eq "Rejeitado"]
return 
          <documento xmlns="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd">
              <id>{\$z/cc:documento/cc:controle/text()}</id>
              <nome/>
              <criacao>{\$z/cc:digitacao/cc:dataDigitacao/text()}</criacao>
              <invalidacao>{\$z/cc:digitacao/cc:dataDigitacao/text()}</invalidacao>
              <motivoInvalidacao/>
              <representaDocumentoFisico>1</representaDocumentoFisico>
              <autorizacoes herdar="1"/>
              <documento>
                <conteudo>
                     { \$z/cc:documento/cc:conteudo/* }
                </conteudo>
              </documento>
           </documento>  
|;

		$sedna->begin;
		$sedna->execute($xq);
		my $inv = '';
		while ($sedna->next){
			$inv .= $sedna->getItem();
		}
		$sedna->commit;
		$documentos{$ctrl} =~ s/<invalidados\/>/$inv/o;

#for \$y in collection("leitura-2")[cc:registroDigitacao/cc:documento/cc:conteudo/fb:formCadernoB/fb:composicaoFamiliar/fb:formularioPrincipal/text() eq "$ctrl"]

		$xq = qq|declare namespace cc = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
declare namespace vc = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
declare namespace fa = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernoa.xsd";
declare namespace fb = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernob.xsd";
declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
declare namespace class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";

for \$y in index-scan("formularioPrincipal", "$ctrl", 'EQ')[cc:documento/cc:estado/text() eq "Aprovado"]
return
          <documento xmlns="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd">
              <id>{\$y/cc:documento/cc:controle/text()}</id>
              <nome/>
              <criacao>{\$y/cc:digitacao/cc:dataDigitacao/text()}</criacao>
              <invalidacao>1970-01-01T00:00:00Z</invalidacao>
              <motivoInvalidacao/>
              <representaDocumentoFisico>1</representaDocumentoFisico>
              <autorizacoes herdar="1"/>
              <documento>
                <conteudo>
                     { \$y/cc:documento/cc:conteudo/* }
                </conteudo>
              </documento>
           </documento>

|;

		$sedna->begin;
		$sedna->execute($xq);
		my $cdb = '';
		while ($sedna->next){
			$cdb.= $sedna->getItem();
		}
		$sedna->commit;

		$xq = qq|declare namespace cc = "http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
declare namespace vc = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
declare namespace fa = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernoa.xsd";
declare namespace fb = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernob.xsd";
declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
declare namespace dc="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
declare namespace audt="http://schemas.fortaleza.ce.gov.br/acao/auditoria.xsd";
declare namespace class="http://schemas.fortaleza.ce.gov.br/acao/classificacao.xsd";

for \$y in index-scan("formularioPrincipal", "$ctrl", 'EQ')[cc:documento/cc:estado eq "Rejeitado"]
return
          <documento xmlns="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd">
              <id>{\$y/cc:documento/cc:controle/text()}</id>
              <nome/>
              <criacao>{\$y/cc:digitacao/cc:dataDigitacao/text()}</criacao>
              <invalidacao>{\$y/cc:digitacao/cc:dataDigitacao/text()}</invalidacao>
              <motivoInvalidacao/>
              <representaDocumentoFisico>1</representaDocumentoFisico>
              <autorizacoes herdar="1"/>
              <documento>
                <conteudo>
                     { \$y/cc:documento/cc:conteudo/* }
                </conteudo>
              </documento>
           </documento>

|;

		$sedna->begin;
		$sedna->execute($xq);
		while ($sedna->next){
			$cdb.= $sedna->getItem();
		}
		$sedna->commit;

		$documentos{$ctrl} =~ s/<cadernob\/>/$cdb/o;


	}

#	print &Dumper(\%documentos);exit;
	$sedna->begin;

	for my $ctrl (keys %documentos) {
		$sedna->loadData( $documentos{$ctrl}, $ctrl, $id_volume );
		$sedna->endLoadData();
		warn "Protuario $ctrl inserido com sucesso!";
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


__END__
     { for $z in $fainv return 
          <documento xmlns="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd">
              <id>{$z/cc:registroDigitacao/cc:documento/cc:controle/text()}</id>
              <nome/>
              <criacao>{$z/cc:registroDigitacao/cc:digitacao/cc:dataDigitacao/text()}</criacao>
              <invalidacao>{$z/cc:registroDigitacao/cc:digitacao/cc:dataDigitacao/text()}</invalidacao>
              <motivoInvalidacao/>
              <representaDocumentoFisico>1</representaDocumentoFisico>
              <autorizacao principal="paulo.neto" role="role" dataIni="2011-02-01T15:08:25" dataFim=""/>
              <documento>
                <conteudo>
                     { $z/cc:registroDigitacao/cc:documento/cc:conteudo/* }
                </conteudo>
              </documento>
           </documento>     },
     { for $y in $fb return
          <documento xmlns="http://schemas.fortaleza.ce.gov.br/acao/documento.xsd">
              <id>{$y/cc:registroDigitacao/cc:documento/cc:controle/text()}</id>
              <nome/>
              <criacao>{$y/cc:registroDigitacao/cc:digitacao/cc:dataDigitacao/text()}</criacao>
              <invalidacao>1970-01-01T00:00:00Z</invalidacao>
              <motivoInvalidacao/>
              <representaDocumentoFisico>1</representaDocumentoFisico>
              <autorizacoes herdar="1"/>
              <documento>
                <conteudo>
                     { $y/cc:registroDigitacao/cc:documento/cc:conteudo/* }
                </conteudo>
              </documento>
           </documento>
     }

