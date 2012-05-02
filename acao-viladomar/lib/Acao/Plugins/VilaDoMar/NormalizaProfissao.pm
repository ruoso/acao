package Acao::Plugins::VilaDoMar::NormalizaProfissao;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;
use utf8;

sub processar{

    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;

    my $membros = $conteudo->{formCadernoB};

    my $profissao;

     foreach my $membro (@$membros) {
        next unless exists $membro->{trabalho}{profissaoAtividade};

        $profissao = $membro->{trabalho}{profissaoAtividade};

        if( substr($profissao,length($profissao)-1, 1) eq "a" ) {
            if (substr($profissao,length($profissao)-2, 1) eq "r") {
                $profissao = substr($profissao,1, length($profissao)-2);
            }
            else {
                $profissao = substr($profissao,1, length($profissao)-2) . "o";
            }
        }
    #    $membro->{trabalho}{profissaoAtividade} = $profissao;
     }
}
1;
