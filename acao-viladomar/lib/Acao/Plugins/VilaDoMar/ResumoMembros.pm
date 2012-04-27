package Acao::Plugins::VilaDoMar::ResumoMembros;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;
use utf8;

my %desc2min =
    (
        '0 a 1⁄2 salário mínimo'     => 0,
        '1⁄2 a 1 salário mínimo'     => 0.5,
        '1 a 2 salários mínimos'     => 1,
        '2 a 3 salários mínimos'     => 2,
        'Mais de 4 salários mínimos' => 3
    );
my %min2desc = reverse %desc2min;

sub processar{
    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;

    my $renda_min = 0;
    $renda_min += ($desc2min{$_->{renda}{rendaMensal}} or 0)
        for @{$conteudo->{formCadernoB}};

    $renda_min = int($renda_min) if $renda_min > 0.5;
    $renda_min = 3 if $renda_min > 3;   

    $conteudo->{resumoMembros}{rendaFamiliar} = $min2desc{$renda_min};
    $conteudo->{resumoMembros}{qtdMembros} = scalar @{$conteudo->{formCadernoB}};
}

1;
