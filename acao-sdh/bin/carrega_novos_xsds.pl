use Sedna;
use strict;
use warnings;
use Switch;

use utf8;
binmode STDIN, ':utf8';
binmode STDOUT, ':utf8';
binmode STDERR, ':utf8';

my $sedna = Sedna->connect(q|127.0.0.1', 'acao', 'acao', '12345|);
my $novo_nome;
my $valor = 1;
$sedna->setConnectionAttr(AUTOCOMMIT => Sedna::SEDNA_AUTOCOMMIT_OFF() );

sub load_xsds {
    $sedna->begin;

    $sedna->execute( q|DROP COLLECTION "acao-schemas"| );

    $sedna->execute( q|CREATE COLLECTION "acao-schemas"| );

    $sedna->execute( q|LOAD "sdh-origemEncaminhamento.xsd" "sdh-origemEncaminhamento.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-vinculacaoNaCCA.xsd" "sdh-vinculacaoNaCCA.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-identificacaoPessoal.xsd" "sdh-identificacaoPessoal.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-documentacao.xsd" "sdh-documentacao.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-convivenciaFamiliarComunitaria.xsd" "sdh-convivenciaFamiliarComunitaria.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-composicaoFamiliar.xsd" "sdh-composicaoFamiliar.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-documentacaoFamiliar.xsd" "sdh-documentacaoFamiliar.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-profissionalizacaoHabilidades.xsd" "sdh-profissionalizacaoHabilidades.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-vinculoReligioso.xsd" "sdh-vinculoReligioso.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-condicoesDeMoradia.xsd" "sdh-condicoesDeMoradia.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-protecaoEspecial.xsd" "sdh-protecaoEspecial.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-saude.xsd" "sdh-saude.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-saudeFamiliar.xsd" "sdh-saudeFamiliar.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-saudeSubstanciaPsicoativas.xsd" "sdh-saudeSubstanciaPsicoativas.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-convivenciaSocial.xsd" "sdh-convivenciaSocial.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-educacao.xsd" "sdh-educacao.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-direcionamentoDoAtendimento.xsd" "sdh-direcionamentoDoAtendimento.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-atendimento.xsd" "sdh-atendimento.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-evolucao.xsd" "sdh-evolucao.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-visitaInstitucional.xsd" "sdh-visitaInstitucional.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-atendimentoEspecificoSEGARANTA.xsd" "sdh-atendimentoEspecificoSEGARANTA.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-individualFamilia.xsd" "sdh-individualFamilia.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-juridico.xsd" "sdh-juridico.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-servicoSocial.xsd" "sdh-servicoSocial.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-psicologia.xsd" "sdh-psicologia.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-pedagogia.xsd" "sdh-pedagogia.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-visitaDomiciliar.xsd" "sdh-visitaDomiciliar.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-relatoriosEncaminhados.xsd" "sdh-relatoriosEncaminhados.xsd" "acao-schemas"| );
    $sedna->execute( q|LOAD "sdh-planoIndividualDeAtendimento.xsd" "sdh-planoIndividualDeAtendimento.xsd" "acao-schemas"| );

    $sedna->commit;

}

load_xsds();
