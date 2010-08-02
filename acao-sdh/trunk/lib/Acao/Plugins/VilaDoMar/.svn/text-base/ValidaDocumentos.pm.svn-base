package Acao::Plugins::VilaDoMar::ValidaDocumentos;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;
use utf8;
use Business::BR::CPF;

has 'dbic' => ( is => 'rw', required => 1 );
has 'sedna' => ( is => 'rw', required => 1 );
has 'sedna_writer' => ( is => 'rw', required => 1 );
has 'user' => (is => 'rw', required => 1 );

my $xq = join '', <DATA>;


use constant VILADOMARCONS_NS =>
    "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";

my $viladomarcons =
  XML::Compile::Schema->new(
    Acao->path_to('plugins/viladomar/schemas/viladomar-consolidado.xsd') );
$viladomarcons->importDefinitions( Acao->path_to('plugins/viladomar/schemas/viladomar-cadernoa.xsd') );
$viladomarcons->importDefinitions( Acao->path_to('plugins/viladomar/schemas/viladomar-cadernob.xsd') );
my $familia_r =
  $viladomarcons->compile( READER => pack_type(  VILADOMARCONS_NS, 'familia' ) );


sub _obter_membro_duplicado {
    my ($membro, $verificacao, $overr) = @_;
    my $rg = $membro->{composicaoFamiliar}{rg};
    my $exp = $membro->{composicaoFamiliar}{expedidor};
    my $cpf = $membro->{composicaoFamiliar}{cpf};
    my $nis = $membro->{composicaoFamiliar}{nis};
    my $outro;    
    my @ret;
    if ($rg and $outro = $verificacao->{rg}{$rg.'/'.$exp}) {
        push @ret, [ $outro, 'RG' ];
    } else {
        $verificacao->{rg}{$rg.'/'.$exp} = $membro if $rg && $overr;
    }
    if ($cpf and $outro = $verificacao->{cpf}{$cpf}) {
        push @ret, [ $outro, 'CPF' ];
    } else {
        $verificacao->{cpf}{$cpf} = $membro if $cpf && $overr;
    }
    if ($nis and $outro = $verificacao->{nis}{$nis}) {
        push @ret, [ $outro, 'NIS' ];
    } else {
        $verificacao->{nis}{$nis} = $membro if $nis && $overr;
    }
    return @ret;
}

sub processar {
    my ($self, $consolidacao, $registroConsolidacao, $conteudo) = @_;

    my $este_documento = $registroConsolidacao->{documento}{id};

    # essa variavel vai ser usada para verificar que nao tem membros dentro
    # dessa familia com documentos duplicados.
    my $verificacao = { rg => {}, cpf => {}, nis => {} };

    my $membros = $conteudo->{formCadernoB};
    foreach my $membro (@$membros) {
        if(!test_cpf($membro->{composicaoFamiliar}{cpf}) ) {
            # validando o cpf...
            # aqui a gente tem como dizer qual de quem o cpf é invalido...
            $consolidacao->alertas->create
		    ({ etapa => 2,
		       log_level => 'ERROR',
		       datahora => DateTime->now(),
               id_documento_consolidado => $este_documento,
		       descricao_alerta => ' o cpf '. $membro->{composicaoFamiliar}{cpf} . ' do membro '
                                    . $membro->{composicaoFamiliar}{nome} . ' desta família é inválido.' 
             });
        }

        foreach my $dup (_obter_membro_duplicado($membro,$verificacao,1)) {
            my ($outro, $doc) = @$dup;
            # duplicidade em membro da familia...
            # aqui a gente tem como dizer qual é o cadastro que está duplicado...
            $consolidacao->alertas->create
		    ({ etapa => 2,
		       log_level => 'ERROR',
		       datahora => DateTime->now(),
               id_documento_consolidado => $este_documento,
		       descricao_alerta => $doc.' duplicado na família entre '
                                    .$membro->{composicaoFamiliar}{nome}.' e '
                                    .$outro->{composicaoFamiliar}{nome} });
        }
    }

    # fazer uma única xquery que busque logo todos os documentos de todos os membros
    # procurar documentos na consolidacao que:
    #   1) Não sejam $este_documento
    #   2) Que tenham qualquer um dos membros com:
    #       2.1) rg/exp igual a qualquer um dos listados acima
    #       2.2) cpf igual a qualquer um dos listados acima
    #       2.3) nis igual a qualquer um dos listados acima

    my $path = 'rc:conteudo/fc:familia/fc:formCadernoB/cf:composicaoFamiliar/';
    my $condicoes = 
        join ' or ',
        map {
            my ($tipo, $valor) = @$_;
            if ($tipo eq 'rg') {
                my ($rg, $exp) = split /\//, $valor;
                if ($exp) {
                    '(( '.$path.'cf:rg = "'.$rg.'" ) and '
                    .'( '.$path.'cf:expedidor = "'.$exp.'"))'
                } else {
                    '(( '.$path.'cf:rg = "'.$rg.'" ) and ('
                    .'( '.$path.'cf:expedidor = "'.$exp.'") or'
                    .' not(exists('.$path.'cf:expedidor)) ))'
                }
            } else {
                '( rc:conteudo/fc:familia/fc:formCadernoB/cf:'.$tipo.' = "'.$valor.'" )'
            }
        }
        map {
            my $key = $_;
            map {
               [ $key => $_ ]
            } keys %{$verificacao->{$key}}
        } qw(rg cpf nis);

    my $query = $xq;
    $query =~ s/\<\<\<id_consolidacao\>\>\>/$consolidacao->id_consolidacao/ges;    
    $query =~ s/\<\<\<id_documento_consolidado\>\>\>/$este_documento/gs;
    $query =~ s/\<\<\<condicoes\>\>\>/$condicoes/gs;
    # warn $query;
    $self->sedna_writer->begin;
    $self->sedna_writer->execute($query);

    while (my $doc = $self->sedna_writer->get_item) {
        $doc =~ s/^\s+//s;
        # aqui a gente tem como dizer qual é o cadastro que está duplicado...
        my $xml_docs = XML::LibXML->load_xml(string => $doc);
        my $hash_docs = $familia_r->($xml_docs);          
       
        my $membros_outra_familia = $hash_docs->{formCadernoB};
        foreach my $membro_outra_familia (@$membros_outra_familia) {
            foreach my $dup (_obter_membro_duplicado($membro_outra_familia,$verificacao,0)) {
                my ($outro, $doc) = @$dup;
                # duplicidade em membro da em outra familia...
                # aqui a gente tem como dizer qual é o cadastro que está duplicado...
                $consolidacao->alertas->create({
                    etapa => 2,
                    log_level => 'ERROR',
                    datahora => DateTime->now(),
                    id_documento_consolidado => $este_documento,
                    descricao_alerta => $doc.' do membro '
                        .$outro->{composicaoFamiliar}{nome}
                        .' desta família duplicado com o membro '
                        .$membro_outra_familia->{composicaoFamiliar}{nome}
                        .' na família cujo código de controle é '
                        .$membro_outra_familia->{composicaoFamiliar}{formularioPrincipal} });
            }
        }

    }

    $self->sedna_writer->commit;
       

}

1;

__DATA__
declare namespace rc = "http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd";
declare namespace fc = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
declare namespace cf = "http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernob.xsd";
for $x in 
  collection("consolidacao-entrada-<<<id_consolidacao>>>")/rc:registroConsolidacao/rc:documento[rc:id != '<<<id_documento_consolidado>>>' and (<<<condicoes>>>)]
return
  $x/rc:conteudo/fc:familia

