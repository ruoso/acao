#!/usr/bin/perl

use utf8;
use DBI;
use Data::Dumper;
use XML::Simple;
use Sedna;
use strict;

my $dbh = DBI->connect("DBI:Pg:dbname=dw;host=172.30.116.22", "dw", "pmfdw", {'RaiseError' => 1});

my $url = '172.31.2.9';
my $dbname = 'AcaoDb';
my $login = 'acao';
my $pass = '12345';

my $s = Sedna->connect($url,$dbname,$login,$pass);

$s->begin;

my $xq = qq| declare namespace dos = "http://schemas.fortaleza.ce.gov.br/acao/dossie.xsd"; 
declare namespace doc = "http://schemas.fortaleza.ce.gov.br/acao/documento.xsd";
declare namespace fa = "http://schemas.fortaleza.ce.gov.br/habitafor/aldeiadapraia-cadernoa.xsd";
subsequence(for \$x in collection("volume-1AB9B39E-B86C-11E0-941B-912B0FDA6DBE")/dos:dossie/dos:doc/doc:documento[doc:invalidacao/text() eq '1970-01-01T00:00:00Z']/doc:documento/doc:conteudo
return \$x/fa:formCadernoA,1,2000)|;


$s->execute($xq);

my $counter = 1;
my %csd;
while ( $s->next ) {
	my $item = $s->getItem();
	my $hash = XMLin($item);
	print "Registro ".$counter++."\n";

	$hash->{caracteristicasImovel}{tipoMoradia} ||= 'Não Informado';
	$hash->{caracteristicasImovel}{casaEmSituacaRisco} ||= 'Não Informado';
	$hash->{infraestrutura}{redeDeAgua} ||= 'Não Informado';
	$hash->{infraestrutura}{abastecimentoAgua}{tipoAbastecimentoAgua} ||= 'Não Informado';
	$hash->{infraestrutura}{redeColetaEsgoto} ||= 'Não Informado';
	$hash->{infraestrutura}{esgotamentoSanitario} ||= 'Não Informado';
	$hash->{infraestrutura}{esgotamentoSanitario2}{tipo} ||= 'Não Informado';
	$hash->{infraestrutura}{tipoLigacaoRedeEletrica} ||= 'Não Informado';
	$hash->{infraestrutura}{tipoServicoTelefonicoPredominante} ||= 'Não Informado';

	$csd{$hash->{caracteristicasImovel}{tipoMoradia}}{$hash->{caracteristicasImovel}{casaEmSituacaRisco}}{$hash->{infraestrutura}{redeDeAgua}}{$hash->{infraestrutura}{abastecimentoAgua}{tipoAbastecimentoAgua}}{$hash->{infraestrutura}{redeColetaEsgoto}}{$hash->{infraestrutura}{esgotamentoSanitario}}{$hash->{infraestrutura}{esgotamentoSanitario2}{tipo}}{$hash->{infraestrutura}{tipoLigacaoRedeEletrica}}{$hash->{infraestrutura}{tipoServicoTelefonicoPredominante}}{quantidade}++;

	for my $destinoLixo (keys %{$hash->{infraestrutura}{destinoLixo}}) {
		$csd{$hash->{caracteristicasImovel}{tipoMoradia}}{$hash->{caracteristicasImovel}{casaEmSituacaRisco}}{$hash->{infraestrutura}{redeDeAgua}}{$hash->{infraestrutura}{abastecimentoAgua}{tipoAbastecimentoAgua}}{$hash->{infraestrutura}{redeColetaEsgoto}}{$hash->{infraestrutura}{esgotamentoSanitario}}{$hash->{infraestrutura}{esgotamentoSanitario2}{tipo}}{$hash->{infraestrutura}{tipoLigacaoRedeEletrica}}{$hash->{infraestrutura}{tipoServicoTelefonicoPredominante}}{$destinoLixo} += $hash->{infraestrutura}{destinoLixo}{$destinoLixo};
	}
}
$s->commit;
exit;

my $id_tipo_moradia = 0;
my %c_tipo_moradia;

my $id_sit_risco = 0;
my %c_sit_risco;

my $id_rede_agua = 0;
my %c_rede_agua;

my $id_tipo_abastecimento = 0;
my %c_tipo_abastecimento;

my $id_rede_esgoto = 0;
my %c_rede_esgoto;

my $id_esgotamento_sanitario = 0;
my %c_esgotamento_sanitario;

my $id_esgotamento_sanitario_tipo = 0;
my %c_esgotamento_sanitario_tipo;

my $id_ligacao_eletrica= 0;
my %c_ligacao_eletrica;

my $id_servico_telefonico = 0;
my %c_servico_telefonico;
my @sqls;
my $sql;
#iniciando pelo tipo de moradia
for my $tipo_moradia (keys %csd) {
	unless ($c_tipo_moradia{$tipo_moradia}) {
		$id_tipo_moradia++;
		$sql = "INSERT INTO seinf.d_tipo_moradia VALUES ($id_tipo_moradia, '$tipo_moradia')";
		$dbh->do($sql);
		$c_tipo_moradia{$tipo_moradia} = $id_tipo_moradia;
	}

	#indo para o tipo de risco
	for my $sit_risco (keys %{$csd{$tipo_moradia}}) {
		unless ($c_sit_risco{$sit_risco}) {
			$id_sit_risco++;
			$sql = "INSERT INTO seinf.d_situacao_risco VALUES ($id_sit_risco, '$sit_risco')";
			$dbh->do($sql);
			$c_sit_risco{$sit_risco} = $id_sit_risco;
		}

		#indo para rede de agua
		for my $rede_agua (keys %{$csd{$tipo_moradia}{$sit_risco}}) {
			unless ($c_rede_agua{$rede_agua}) {
				$id_rede_agua++;
				$sql = "INSERT INTO seinf.d_rede_agua VALUES ($id_rede_agua, '$rede_agua')";
				$dbh->do($sql);
				$c_rede_agua{$rede_agua} = $id_rede_agua;
			}

			#indo para tipo de abastecimento
			for my $tipo_abastecimento (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}}) {
				unless ($c_tipo_abastecimento{$tipo_abastecimento}) {
					$id_tipo_abastecimento++;
					$sql = "INSERT INTO seinf.d_tipo_abastecimento_agua VALUES ($id_tipo_abastecimento, '$tipo_abastecimento')";
					$dbh->do($sql);
					$c_tipo_abastecimento{$tipo_abastecimento} = $id_tipo_abastecimento;
				}

				#indo para rede de coleta de esgoto 
				for my $rede_esgoto (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}}) {
					unless ($c_rede_esgoto{$rede_esgoto}) {
						$id_rede_esgoto++;
						$sql = "INSERT INTO seinf.d_rede_coleta_esgoto VALUES ($id_rede_esgoto, '$rede_esgoto')";
						$dbh->do($sql);
						$c_rede_esgoto{$rede_esgoto} = $id_rede_esgoto;
					}

					#indo para esgotamento sanitário
					for my $esgotamento_sanitario (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}}) {
						unless ($c_esgotamento_sanitario{$esgotamento_sanitario}) {
							$id_esgotamento_sanitario++;
							$sql = "INSERT INTO seinf.d_esgotamento_sanitario VALUES ($id_esgotamento_sanitario, '$esgotamento_sanitario')";
							$dbh->do($sql);
							$c_esgotamento_sanitario{$esgotamento_sanitario} = $id_esgotamento_sanitario;
						}

						#indo para tipo de esgotamento sanitários
						for my $esgotamento_sanitario_tipo (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}}) {
							unless ($c_esgotamento_sanitario_tipo{$esgotamento_sanitario_tipo}) {
								$id_esgotamento_sanitario_tipo++;
								$sql = "INSERT INTO seinf.d_tipo_esgotamento_sanitario VALUES ($id_esgotamento_sanitario_tipo, '$esgotamento_sanitario_tipo')";
								$dbh->do($sql);
								$c_esgotamento_sanitario_tipo{$esgotamento_sanitario_tipo} = $id_esgotamento_sanitario_tipo;
							}

							#indo para ligacao elétrica
							for my $ligacao_eletrica (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}}) {
								unless ($c_ligacao_eletrica{$ligacao_eletrica}) {
									$id_ligacao_eletrica++;
									$sql = "INSERT INTO seinf.d_tipo_ligacao_rede_eletrica VALUES ($id_ligacao_eletrica, '$ligacao_eletrica')";
									$dbh->do($sql);
									$c_ligacao_eletrica{$ligacao_eletrica} = $id_ligacao_eletrica;
								}

								#indo para servico telefonico
								for my $servico_telefonico (keys %{$csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}}) {
									unless ($c_servico_telefonico{$servico_telefonico}) {
										$id_servico_telefonico++;
										$sql = "INSERT INTO seinf.d_tipo_servico_telefonico VALUES ($id_servico_telefonico, '$servico_telefonico')";
										$dbh->do($sql);
										$c_servico_telefonico{$servico_telefonico} = $id_servico_telefonico;
									}

									my $quantidade = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{quantidade} || 0;
									my $coleta = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{sistemaColeta} || 0;
									my $conteiner = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{conteiner} || 0;
									my $terreno = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{terrenoBaldio} || 0;
									my $curso = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{cursoDagua} || 0;
									my $passeio = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{passeio} || 0;
									my $logradouro = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{logradouro} || 0;
									my $enterrado = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{enterrado} || 0;
									my $queimado = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{queimado} || 0;
									my $outros = $csd{$tipo_moradia}{$sit_risco}{$rede_agua}{$tipo_abastecimento}{$rede_esgoto}{$esgotamento_sanitario}{$esgotamento_sanitario_tipo}{$ligacao_eletrica}{$servico_telefonico}{outros} || 0;

									$sql = "INSERT INTO seinf.f_cadastro_familia VALUES ($id_tipo_moradia, $id_sit_risco, $id_rede_agua, $id_tipo_abastecimento, $id_rede_esgoto, $id_esgotamento_sanitario, $id_esgotamento_sanitario_tipo, $id_ligacao_eletrica, $id_servico_telefonico, $coleta, $conteiner, $terreno, $curso, $passeio, $logradouro, $enterrado, $queimado, $outros, $quantidade)";
									push @sqls, $sql;

								}

							}

						}

					}

				}
			}


		}

	}

}

for (@sqls) {
	$dbh->do($_);
}


