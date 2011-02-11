package Acao::Role::Model::BuscaXSD;
use 5.10.0;
use Moose::Role;
use Acao::Util::AnnotatedSimpleType;

sub get_simpletype_annotations {
    my ( $self, $xsd ) = @_;
    my $schemadoc    = XML::LibXML->load_xml( string => $xsd );
    my $schemabaseel = $schemadoc->getDocumentElement;
    my $targetns     = $schemabaseel->getAttribute('targetNamespace');
    my ( $stack, $stelements ) = ( [], [] );
    Acao::Util::AnnotatedSimpleType::traverse_schema( $schemabaseel, $targetns,
        $schemabaseel, $stack, $stelements );
    return $stelements;
}

sub get_target_namespace {
    my ( $self, $xsd ) = @_;

    my $schemadoc = XML::LibXML->load_xml( string => $xsd );
    my $schemabaseel = $schemadoc->getDocumentElement;
    return $schemabaseel->getAttribute('targetNamespace');
}

sub produce_xpath {
    my $self = shift;
    return join '/', $self->produce_xpath_segments(@_);
}

sub produce_xpath_segments {
    my ( $self, $nsprefix, $path_form ) = @_;
    return map { $nsprefix . ':' . $_ }
      grep     { $_ }
      map { s/[^0-9a-zA-Z\_\-]//gs; $_ }
      split /\//, $path_form;
}

sub produce_expr_where {
    my $self = shift;
    return $self->produce_expr( @_, 'where' );
}

sub produce_expr_xpfilter {
    my $self = shift;
    return $self->produce_expr( @_, 'xpfilter' );
}

sub produce_expr {
    my ( $self, $nsprefix, $path_form, $oper, $valor, $xpath_prefix, $type ) =
      @_;
    $xpath_prefix ||= '';
    $type         ||= 'where';
    my $tipo_operador;
    my $operador;
    my $classe_operador;
    given ($oper) {
        when ('igual') {
            $operador        = 'eq';
            $tipo_operador   = 'infix';
            $classe_operador = 'string';
        }
        when ('igualn') {
            $operador        = '=';
            $tipo_operador   = 'infix';
            $classe_operador = 'num';
        }
        when ('diferente') {
            $operador        = 'ne';
            $tipo_operador   = 'infix';
            $classe_operador = 'string';
        }
        when ('maiorn') {
            $operador        = '>=';
            $tipo_operador   = 'infix';
            $classe_operador = 'num';
        }
        when ('menorn') {
            $operador        = '<=';
            $tipo_operador   = 'infix';
            $classe_operador = 'num';
        }
        when ('maior') {
            $operador        = 'gt';
            $tipo_operador   = 'infix';
            $classe_operador = 'string';
        }
        when ('menor') {
            $operador        = 'lt';
            $tipo_operador   = 'infix';
            $classe_operador = 'string';
        }
        when ('contem') {
            $operador        = 'contains';
            $tipo_operador   = 'function';
            $classe_operador = 'string';
        }
        when ('inicia') {
            $operador        = 'starts-with';
            $tipo_operador   = 'function';
            $classe_operador = 'string';
        }
        when ('termina') {
            $operador        = 'ends-with';
            $tipo_operador   = 'function';
            $classe_operador = 'string';
        }
        default {
            die 'submissao-invalida: ' . $oper;
        }
    };
    given ($type) {
        when ('where') {
            my $va =
              $xpath_prefix . $self->produce_xpath( $nsprefix, $path_form );
            my $vb = $valor;
            return $self->produce_operador( $classe_operador, $tipo_operador,
                $operador, $va, $vb );
        }
        when ('xpfilter') {
            my @seg = $self->produce_xpath_segments( $nsprefix, $path_form );
            my $va  = pop @seg;
            my $vb  = $valor;
            my $filter =
              $self->produce_operador( $classe_operador, $tipo_operador,
                $operador, $va, $vb );
            chop($xpath_prefix) if $xpath_prefix =~ /\/$/;
            return join '', '[', ( join '/', $xpath_prefix, @seg ), '[',
              $filter, ']', ']';
        }
    }
}

sub produce_operador {
    my ( $self, $classe_operador, $tipo_operador, $operador, $va, $vb ) = @_;
    given ($classe_operador) {
        when ('string') {
            given ($tipo_operador) {
                when ('infix') {
                    return join ' ', 'upper-case(' . $va . ')',
                      $operador, 'upper-case(' . $self->quote_valor($vb) . ')';
                }
                when ('function') {
                    return join ' ', $operador, '(',
                      'upper-case(' . $va . '),',
                      'upper-case(' . $self->quote_valor($vb) . '))';
                }
            }
        }
        when ('num') {
            given ($tipo_operador) {
                when ('infix') {
                    return join ' ', '(0 + ' . $va . ')',
                      $operador, ( $vb + 0 );
                }
                when ('function') {
                    return join ' ', $operador, '(',
                      '(0 + ' . $va . '),',
                      ( $vb + 0 ), ')';
                }
            }
        }
    }
}

sub quote_valor {
    my ( $self, $valor ) = @_;
    $valor =~ s/\\/\\\\/gs;
    $valor =~ s/\"/\\\"/gs;
    $valor =~ s/\'/\\\'/gs;
    return q(") . $valor . q(");
}

1;
