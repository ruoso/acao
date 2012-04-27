package Acao::Plugins::VilaDoMar::ColetaDeDados;
use Moose;
use XML::Compile::Schema;
use XML::LibXML;
use XML::Compile::Util qw(pack_type);
use DateTime;

use constant CONSOLIDACAO_NS =>
  'http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd';

my $controle =
  XML::Compile::Schema->new(
    Acao->path_to('schemas/controleconsolidacao.xsd') );
my $controle_w = $controle->compile(
    WRITER => pack_type( CONSOLIDACAO_NS, 'registroConsolidacao' ) );
my $entradas_r =
  $controle->compile( READER => pack_type( CONSOLIDACAO_NS, 'entradas' ) );

has 'dbic'  => ( is => 'rw', required => 1 );
has 'sedna' => ( is => 'rw', required => 1 );
has 'sedna_writer' => ( is => 'rw', required => 1 );
has 'user'  => ( is => 'rw', required => 1 );

my $xq = join '', <DATA>;

sub processar {
    my ( $self, $consolidacao, $ip ) = @_;

    # $consolidacao é o objeto da consolidação que foi criada e representa o
    # processo atual... de acordo com o modelo de dados do Acao.

    my $definicao = $consolidacao->definicao_consolidacao;

    my $leituraa =
      $definicao->entrada_consolidacao->find( { papel_leitura => 'cadernoa' } );
    my $id_leitura_a = $leituraa->id_leitura;

    my $leiturab =
      $definicao->entrada_consolidacao->find( { papel_leitura => 'cadernob' } );
    my $id_leitura_b = $leiturab->id_leitura;

    my $docname_base = join '_', 'consolidacao', $consolidacao->id_consolidacao,
      $self->user->id, time;
    my $seq = 0;

    my $query = $xq;
    $query =~ s/\<\<\<id_leitura_1\>\>\>/$id_leitura_a/gs;
    $query =~ s/\<\<\<id_leitura_2\>\>\>/$id_leitura_b/gs;

    $self->sedna->begin;
    $self->sedna->execute($query);
    $self->sedna_writer->begin;

    while (1) {
        my ( $entradas, $familia );
        eval {
            $entradas = $self->sedna->get_item;
            $familia  = $self->sedna->get_item;
        };
        last if $@;
        last unless $entradas;

        my $docname = $docname_base . '_' . ( $seq++ );

        my $xml_entradas = XML::LibXML->load_xml( string => $entradas );
        my $hash_entradas = $entradas_r->($xml_entradas);

        my $xml_familia = XML::LibXML->load_xml( string => $familia );
        my $el_familia = $xml_familia->documentElement;
        my $type =
          pack_type( $el_familia->namespaceURI, $el_familia->localname );

        my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
        my $res_xml = $controle_w->(
            $doc,
            {
                consolidacao => {
                    consolidador      => $self->user->id,
                    dataConsolidacao  => DateTime->now(),
                    localConsolidacao => $ip,
                    entradas          => $hash_entradas,
                },
                definicaoConsolidacao => {
                    id      => $definicao->id,
                    projeto => {
                        id   => $definicao->projeto->id,
                        nome => $definicao->projeto->nome,
                   }
                },
                documento => {
                    id       => $docname,
                    conteudo => { $type => $xml_familia->documentElement },
                }
            }
        );

        $self->sedna_writer->conn->loadData( $res_xml->toString, $docname,
            'consolidacao-entrada-' . $consolidacao->id_consolidacao );
        $self->sedna_writer->conn->endLoadData();

        $consolidacao->alertas->create(
            {
                etapa            => 1,
                log_level        => 'TRACE',
                datahora         => DateTime->now(),
                descricao_alerta => 'Documento inserido na collection.',
                id_documento_consolidado
                                 => $docname,
            }
        );

    }

    $self->sedna_writer->commit;
    $self->sedna->commit;

}

1;

__DATA__
declare namespace dig="http://schemas.fortaleza.ce.gov.br/acao/controledigitacao.xsd";
declare namespace cons="http://schemas.fortaleza.ce.gov.br/acao/controleconsolidacao.xsd";
declare namespace forma="http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernoa.xsd";
declare namespace formb="http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-cadernob.xsd";
declare namespace formc="http://schemas.fortaleza.ce.gov.br/habitafor/viladomar-consolidado.xsd";
for
  $a in collection("leitura-<<<id_leitura_1>>>")[dig:registroDigitacao/dig:documento/dig:estado="Aprovado"]

let $b := collection("leitura-<<<id_leitura_2>>>")[dig:registroDigitacao/dig:documento/dig:conteudo/formb:formCadernoB/formb:composicaoFamiliar/formb:formularioPrincipal = $a/dig:registroDigitacao/dig:documento/dig:controle and dig:registroDigitacao/dig:documento/dig:estado="Aprovado"]

return 
 ( <cons:entradas>
    <cons:entrada> 
     <cons:leitura>{ $a/dig:registroDigitacao/dig:leitura/dig:id/text() }</cons:leitura>
     <cons:iddoc>{ $a/dig:registroDigitacao/dig:documento/dig:id/text() }</cons:iddoc>
     <cons:controle>{ $a/dig:registroDigitacao/dig:documento/dig:controle/text() }</cons:controle>
    </cons:entrada>
    { for $c in $b
      return
        <cons:entrada>
         <cons:leitura>{ $c/dig:registroDigitacao/dig:leitura/dig:id/text() }</cons:leitura>
         <cons:iddoc>{ $c/dig:registroDigitacao/dig:documento/dig:id/text() }</cons:iddoc>
         <cons:controle>{ $c/dig:registroDigitacao/dig:documento/dig:controle/text() }</cons:controle>
        </cons:entrada>
    }
   </cons:entradas> ,
   <formc:familia>
    <formc:formCadernoA>
     { $a/dig:registroDigitacao/dig:documento/dig:conteudo/forma:formCadernoA/*  }
    </formc:formCadernoA>
    { for $c in $b
      return
        <formc:formCadernoB>
        { $c/dig:registroDigitacao/dig:documento/dig:conteudo/formb:formCadernoB/* }
        </formc:formCadernoB>
    }
   </formc:familia> )
