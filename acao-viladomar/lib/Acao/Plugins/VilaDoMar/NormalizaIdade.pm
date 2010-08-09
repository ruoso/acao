package Acao::Plugins::VilaDoMar::NormalizaIdade;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;
use DateTime::Format::XSD;
use utf8;

sub processar{

    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;
     
    my $membros = $conteudo->{formCadernoB};

    foreach my $membro (@$membros) {
        next unless exists $membro->{composicaoFamiliar}{documentos}{data};
        my $data = DateTime::Format::XSD->parse_datetime(
            $membro->{composicaoFamiliar}{documentos}{data}
        );
        
        my $idade_atual = $data - DateTime->now();

        $membro->{composicaoFamiliar}{documentos}{idade} = $idade_atual->years;
    }
}

1;
