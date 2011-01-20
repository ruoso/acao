package Acao::Role::Model::BuscaXSD;
use 5.10.0;
use Moose::Role;
use Acao::Util::AnnotatedSimpleType;

sub get_simpletype_annotations {
    my ($self, $xsd) = @_;
    my $schemadoc = XML::LibXML->load_xml(string => $xsd);
    my $schemabaseel = $schemadoc->getDocumentElement;
    my $targetns = $schemabaseel->getAttribute('targetNamespace');
    my ($stack, $stelements) = ([], []);
    Acao::Util::AnnotatedSimpleType::traverse_schema($schemabaseel,$targetns,$schemabaseel,$stack,$stelements);
    return $stelements;
}

sub get_target_namespace {
    my ($self, $xsd) = @_;

    my $schemadoc = XML::LibXML->load_xml(string => $xsd);
    my $schemabaseel = $schemadoc->getDocumentElement;
    return $schemabaseel->getAttribute('targetNamespace');
}

sub produce_xpath {
    my ($self, $nsprefix, $path_form) = @_;

    return
        join '/',
        map { $nsprefix.':'.$_ }
        grep { $_ }
        map { s/[^0-9a-zA-Z\_\-]//gs; $_ }
        split /\//, $path_form;
}

sub produce_expr {
    my ($self, $nsprefix, $path_form, $oper, $valor, $xpath_prefix)= @_;
    $xpath_prefix ||= '';
    my $tipo_operador;
    my $operador;
    my $classe_operador;
    given ($oper) {
        when ('igual') {
            $operador = 'eq';
            $tipo_operador = 'infix';
            $classe_operador = 'string';
        }
        when ('igualn') {
            $operador = '=';
            $tipo_operador = 'infix';
            $classe_operador = 'num';
        }
        when ('diferente') {
            $operador = 'ne';
            $tipo_operador = 'infix';
            $classe_operador = 'string';
        }
        when ('maiorn') {
            $operador = '>=';
            $tipo_operador = 'infix';
            $classe_operador = 'num';
        }
        when ('menorn') {
            $operador = '<=';
            $tipo_operador = 'infix';
            $classe_operador = 'num';
        }
        when ('maior') {
            $operador = 'gt';
            $tipo_operador = 'infix';
            $classe_operador = 'string';
        }
        when ('menor') {
            $operador = 'lt';
            $tipo_operador = 'infix';
            $classe_operador = 'string';
        }
        when ('contem') {
            $operador = 'contains';
            $tipo_operador = 'function';
            $classe_operador = 'string';
        }
        when ('inicia') {
            $operador = 'starts-with';
            $tipo_operador = 'function';
            $classe_operador = 'string';
        }
        when ('termina') {
            $operador = 'ends-with';
            $tipo_operador = 'function';
            $classe_operador = 'string';
        }
        default {
            die 'submissao-invalida: '.$oper;
        }
    };
    given ($classe_operador) {
      when ('string') {
        given ($tipo_operador) {
          when ('infix') {
            return join ' ', 'upper-case('.$xpath_prefix.$self->produce_xpath($nsprefix, $path_form).')',
              $operador, 'upper-case('.$self->quote_valor($valor).')';
          }
          when ('function') {
            return join ' ', $operador , '(' ,
              'upper-case('.$xpath_prefix.$self->produce_xpath($nsprefix, $path_form).'),',
                'upper-case('.$self->quote_valor($valor).'))';
          }
        }
      }
      when ('num') {
        given ($tipo_operador) {
          when ('infix') {
            return join ' ', '(0 + '.$xpath_prefix.$self->produce_xpath($nsprefix, $path_form).')',
              $operador, $valor;
          }
          when ('function') {
            return join ' ', $operador , '(' ,
              '(0 + '.$xpath_prefix.$self->produce_xpath($nsprefix, $path_form).'),',
                $valor.')';
          }
        }
      }
    }
}

sub quote_valor {
    my ($self, $valor) = @_;
    $valor =~ s/\\/\\\\/gs;
    $valor =~ s/\"/\\\"/gs;
    $valor =~ s/\'/\\\'/gs;
    return q(").$valor.q(");
}

1;
