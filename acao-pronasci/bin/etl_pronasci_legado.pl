#!/usr/bin/perl

use strict;
use warnings;
use Spreadsheet::ParseExcel;
use Sedna;
use warnings;
use lib '/home/edilson/devel-programa-acao/acao/Acao/lib';
use Acao;
use utf8;
use Data::Dumper;

my $id_volume;
my $sedna = Sedna->connect('172.30.116.22', 'AcaoDbHom', 'acao', 'acao');
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

{   package DumbUser;
    use Moose;
    sub memberof {[ Acao->config->{roles}{dossie}{criar}, Acao->config->{roles}{volume}{criar} , Acao->config->{roles}{documento}{criar}]}
    sub uid {'importacao.pronasci'}
    sub id {'importacao.pronasci'}
    sub cn {'Importação Pronasci'}
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

my $model_dossie = Acao::Model::Dossie->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);
my $model_documento = Acao::Model::Documento->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);

sub extract{
    my $parser   = Spreadsheet::ParseExcel->new();
    my $workbook = $parser->parse('/home/pauloneto/BANCO DE CADASTRO DE TODOS OS JOVENS ATUALIZADO.xls');

    if ( !defined $workbook ) {
            die $parser->error(), ".\n";
    }

    for my $worksheet ( $workbook->worksheets() ) {
#            my $worksheet = $workbook->worksheet(0);
            my ( $row_min, $row_max ) = $worksheet->row_range();
            my ( $col_min, $col_max ) = $worksheet->col_range();

            for my $row ( $row_min +1 .. $row_max ) {
#                for my $col ( $col_min .. $col_max ) {
                    my $col = 0;
                    my $nome = $worksheet->get_cell( $row, $col )->value || '';
                    my $idade = $worksheet->get_cell( $row, $col + 1 )->value || '';
                    my $endereco = $worksheet->get_cell( $row, $col + 2)->value || '';
                    my $bairro = $worksheet->get_cell( $row, $col + 3)->value || '';
                    my $fone = $worksheet->get_cell( $row, $col + 4)->value || '';
                    my $interesse = $worksheet->get_cell( $row, $col + 5)->value || '';

                    next unless $nome;

                    my %hash = ("nome" => $nome, "idade" => $idade, "endereco" => $endereco, "bairro" => $bairro, "fone" => $fone, "interesse" => $interesse);
                    load(%hash);
        }
    }
}

sub transform_interesse{
    my ($interesse, %interesses) = @_;
    $interesse =~ tr/áéíóúçêôâãõ/aeiouceoaao/;
    my @array = split(',',$interesse);
    my $complemento = pop(@array);
    push (@array,split(' e ', $complemento));

    for my $valor (@array){
        $valor =~ s/^\s+//o;
        $valor =~ s/\s+$//o;

        if (! exists $interesses{$valor}) {
            $interesses{outros} .= $valor.',';
        } else {
            $interesses{$valor} = 1;
        }
    }
    return %interesses;
}

sub load{
    my %hash = @_;
    my $prontuario =  criarProntuario($hash{nome});
    criarDocumento($prontuario, %hash);
}

sub criarProntuario{
     my $nome = shift;
     my ($representaDossieFisico, $classificacao, $localizacao,$autorizacoes, $ip, $herdar_author) = 
       (0, {'classificacao' => ["cn=Protejo,cn=Infância e Adolescência,cn=Segurança Pública"]}, 'SERCEFOR', $auth , '127.0.0.1', 1);
    utf8::encode($nome);
    warn "is utf ".utf8::is_utf8($nome);
    print "criando prontuário $nome ...";
     my $prontuario = $model_dossie->criar_dossie($ip, $nome, $id_volume, $representaDossieFisico, $classificacao, $localizacao, $herdar_author, $autorizacoes);
     print " done!\n";
     return $prontuario;
}

sub criarDocumento{
     my ($controle, %hash) = @_;
     my $xml = gera_xml(%hash);
     my ($ip, $xsdDocumento, $representaDocumentoFisico,$herdar_author) = 
       ('127.0.0.1','http://schemas.fortaleza.ce.gov.br/acao/gmf-pronasci-instrumentalcaracterizacaojovens-protejo.xsd', 0, 1 );
    print "criando documento...." . $hash{nome};
     my $id_documento = $model_documento->inserir_documento($ip, $xml, $id_volume, $controle, $xsdDocumento, $representaDocumentoFisico,$herdar_author, $auth);
                                                          
     print "done!\n";
}

sub criaVolume{
    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd"; for $x in collection("volume")/vol:volume[vol:nome/text() eq "PROTEJO"]/vol:collection/text() return $x';
    $sedna->begin;
    $sedna->execute($xq);
    $id_volume = $sedna->getItem();
    $sedna->commit;
    if($id_volume){
        warn "Volume Protejo encontrada com id $id_volume";
    }else{
        my($nome, $representaVolumeFisico, $classificacao, $localizacao,$autorizacoes, $ip) = ('PROTEJO' , 0, {'classificacao' => ["cn=Protejo,cn=Infância e Adolescência,cn=Segurança Pública,dc=assuntos,dc=diretorio,dc=fortaleza,dc=ce,dc=gov,dc=br"]}, 'SERCEFOR', $auth , '127.0.0.1');
        my $model = Acao::Model::Volume->new(user => DumbUser->new(), sedna => Acao->model('Sedna'), dbic => Acao->model('DB')->schema);
        $id_volume = $model->criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao, $auth, $ip);
        warn "Volume $id_volume criada com sucesso!";
    }
    return $id_volume;
}

sub gera_xml{
    my %hash = @_;

    my %interesse = ("danca" => 0, 
                    "teatro" => 0, 
                    "maracatu" => 0, 
                    "violao" => 0, 
                    "cantoCoral" => 0, 
                    "percussao" => 0,
                    "customizacao" => 0,
                    "arteTecido" => 0,
                    "artesanato" => 0,
                    "reciclagem" => 0,
                    "informatica" => 0,
                    "fotografia" => 0,
                    "leituraInterpretacao" => 0,
                    "protejo" => 0,
                    "formacaoCidada" => 0,
                    "outros" => "");

    if($hash{interesse}){ %interesse = transform_interesse($hash{interesse}, %interesse) };

    my $xml = '<formProtejoInstrumentalCaracterizacaoJovem xmlns="http://schemas.fortaleza.ce.gov.br/acao/gmf-pronasci-instrumentalcaracterizacaojovens-protejo.xsd">
    <dadosInscricao/>
    <identificacaoDadosSocioeconimicos>
      <nomeEntrevistado>'.$hash{nome}.'</nomeEntrevistado>
      <telefones>'.$hash{fone}.'</telefones>
      <endereco>'.$hash{endereco}.'</endereco>
      <bairro>'.$hash{bairro}.'</bairro>
      <idade>'.$hash{idade}.'</idade>
      <documentacao/>
    </identificacaoDadosSocioeconimicos>
    <situacaoRiscoSocial/>
    <participacaoProjetosSociais/>
    <interessesHabilidades>
      <atividadeGostariaDesenvolver>
        <danca>'.$interesse{danca}.'</danca>
        <teatro>'.$interesse{teatro}.'</teatro>
        <maracatu>'.$interesse{maracatu}.'</maracatu>
        <violao>'.$interesse{violao}.'</violao>
        <cantoCoral>'.$interesse{cantoCoral}.'</cantoCoral>
        <percussao>'.$interesse{percussao}.'</percussao>
        <customizacao>'.$interesse{customizacao}.'</customizacao>
        <arteTecido>'.$interesse{arteTecido}.'</arteTecido>
        <artesanato>'.$interesse{artesanato}.'</artesanato>
        <reciclagem>'.$interesse{reciclagem}.'</reciclagem>
        <informatica>'.$interesse{informatica}.'</informatica>
        <fotografia>'.$interesse{fotografia}.'</fotografia>
        <formacaoCidada>'.$interesse{formacaoCidada}.'</formacaoCidada>
        <leituraInterpretacao>'.$interesse{leituraInterpretacao}.'</leituraInterpretacao>
        <protejo>'.$interesse{protejo}.'</protejo>
        <outros>'.$interesse{outros}.'</outros>
      </atividadeGostariaDesenvolver>
    </interessesHabilidades>
  </formProtejoInstrumentalCaracterizacaoJovem>';

    return $xml;
}



criaVolume();
extract();
