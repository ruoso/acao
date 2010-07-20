package Acao::Plugins::VilaDoMar::NormalizaBairro;
use Moose;
use utf8;

my @versoes_pirambu = split /\n/, <<VERSOES_PIRAMBU;
JACAREGANGA
JACARECANGA
CRISTO REDENTOR/PIRAMBU
PIRAMBU(CRISTO REDENTOR)
PIRAMBU/NOSSA SENHORA DAS GRAÇAS
PIRA
NOSSA SENHORA DAS GRAÇAS
NOSSA SRA. DAS GRAÇAS
VERSOES_PIRAMBU

my @versoes_cristo_redentor = split /\n/, <<VERSOES_CRISTO_REDENTOR;
CRISTO REDENTOR/JACAREGANGA
PIRAMBU/CRISTO REDENTOR
VERSOES_CRISTO_REDENTOR

my @versoes_barra_do_ceara = split /\n/, <<VERSOES_BARRA_DO_CEARA;
PIRAMBU/BARRA DO CEARA
JARDIM PETROPOLIS
JARDIM PETROPOLES
CONJUNTO PLANALTO DAS GOIABEIRAS
COLONIA
GOIABEIRAS
GOIABEIRA
PLANALTO DAS GOIABEIRAS
BARRA DO CEARA – 4 VARAS
BARRA DO CEARA/ COLONIA
COLONIA/ BARRA DO CEARA
GOIABEIRAS/ BARRA DO CEARA
VERSOES_BARRA_DO_CEARA

sub processar{
    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;

    my $bairro = $conteudo->{formCadernoA}{enderecoImovel}{bairro};

    if (grep { index uc($bairro), uc($_) } @versoes_pirambu) {
        $bairro = 'PIRAMBU';
    } elsif (grep { index uc($bairro), uc($_) } @versoes_cristo_redentor) {
        $bairro = 'CRISTO REDENTOR';
    } elsif (grep { index uc($bairro), uc($_) } @versoes_cristo_redentor) {
        $bairro = 'BARRA DO CEARA';
    }

    $conteudo->{formCadernoA}{enderecoImovel}{bairro} = $bairro;
}


1;
