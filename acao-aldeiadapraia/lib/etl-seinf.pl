use Sedna;
use XML::Compile::Schema;
use XML::Compile::Util qw(pack_type);
use File::Spec::Functions;
use FindBin qw($Bin);
use lib catfile($Bin, '..', 'lib');
use strict;
use warnings;
use Data::Dumper;

my $sedna = Sedna->connect('172.30.116.22', 'AcaoDb', 'acao', 'acao');

$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

BEGIN { die 'Informe a variavel de ambiente ACAO_HOME' unless -d $ENV{ACAO_HOME}; }

#define as constantes para os caminhos dos schemas, utilizando variável de ambiente
use constant HOME_SCHEMAS => $ENV{HOME_SCHEMAS} || catfile($Bin, '..', 'schemas');
use constant SCHEMA_DOSSIE    => catfile($ENV{ACAO_HOME}, 'schemas', 'dossie.xsd');
use constant SCHEMA_DOCUMENTO => catfile($ENV{ACAO_HOME}, 'schemas', 'documento.xsd');
use constant SCHEMA_AUTORIZACAO => catfile($ENV{ACAO_HOME}, 'schemas', 'autorizacoes.xsd');
use constant SCHEMA_FORMCADERNOA => catfile(HOME_SCHEMAS, 'aldeiadapraia-cadernoa.xsd');
use constant SCHEMA_FORMCADERNOB => catfile(HOME_SCHEMAS, 'aldeiadapraia-cadernob.xsd');
use constant DOSSIE_NS    => 'http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd';
use constant DOCUMENTO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/documento.xsd';
use constant AUTORIZACAO_NS => 'http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd';

my $schema_form = { 'formCadernoA' => XML::Compile::Schema->new(SCHEMA_FORMCADERNOA), 'formCadernoB' => XML::Compile::Schema->new(SCHEMA_FORMCADERNOB) };
my $volume = 'volume-F595D2F6-BF95-11E0-B232-6830BA214A32';

sub getDossies{

    my @dossies ;
    my $xq = ' declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
               declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
               for $x in collection("'.$volume.'")/dos:dossie/dos:controle/text() return $x';
        $sedna->begin;
        $sedna->execute($xq);
        my $value;
         while ($sedna->next){
            $value = $sedna->getItem();
            $value =~ s/^\s+//;
            push(@dossies, $value);
         }
        $sedna->commit;
    geIdtDocumentos(@dossies);
}

sub geIdtDocumentos{
    my (@dossies) = @_;
    my $xq;
    my %hash = ();
    my $id_doc;
    my $value;
    my $strHash;

    for (my $i=0; $i < scalar(@dossies); $i++){
       $xq = 'declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd";
              declare namespace dc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
              for $x in collection("' . $volume . '")/dos:dossie[dos:controle="'. $dossies[$i] .'"]/dos:doc/dc:documento/dc:id/text() return $x';
       $sedna->begin;
       $sedna->execute($xq);
       while ($sedna->next){
            $value = $sedna->getItem();
            $value =~ s/^\s+//;
            $id_doc .= $value . ' - ';
       }
       $value =  $dossies[$i];
       $sedna->commit;
       $id_doc = $id_doc = "" ? "vazio" : $id_doc;
       $hash{$value} = $id_doc;
   
       $id_doc = "";      
        
    }

warn Dumper(\%hash);
}

getDossies();



