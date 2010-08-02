package Acao::Plugins::VilaDoMar::NormalizaString;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;
use Text::Unaccent::PurePerl qw(unac_string);
use utf8;

sub trim {
  my ($param) = @_;
  $param =~ s/^\s+|\s+$//gs;
  $param =~ s/\s\s+/ /gs;
  return $param;
}

sub normaliza {
    my ($param) = @_;
    return unless defined $param;
    return uc(trim(unac_string($param)));
}

sub processar{
    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;

    my $fromsA = $conteudo->{formCadernoA};
    my $fromsB = $conteudo->{formCadernoB};    
    
    for (qw(orgaoCadastrador entrevistador titularBeneficiario)) {
      $fromsA->{identificacao}{$_} = normaliza($fromsA->{identificacao}{$_})
         if exists $fromsA->{identificacao}{$_}
    }
    for (qw(logradouro complemento localizacaoCartografica bairro)) {
      $fromsA->{enderecoImovel}{$_} = normaliza($fromsA->{enderecoImovel}{$_})
         if exists $fromsA->{enderecoImovel}{$_}
    }

    foreach my $formB (@$fromsB) {
        for (qw(nome apelido expedidor)) {
          $formB->{composicaoFamiliar}{$_} = normaliza($formB->{composicaoFamiliar}{$_})
             if exists $formB->{composicaoFamiliar}{$_}
        }
    }

}
1;
