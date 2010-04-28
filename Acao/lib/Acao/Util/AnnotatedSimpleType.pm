package Acao::Util::AnnotatedSimpleType;
use 5.10.0;
use Moose;
use XML::LibXML;
use utf8;
use constant XSD_NS => 'http://www.w3.org/2001/XMLSchema';

sub traverse_schema {
    my ( $baseschemael, $targetns, $node, $stack, $stelements ) = @_;
    return unless ref $node eq 'XML::LibXML::Element';
    given ( $node->localname ) {
        when ('schema') {
            $baseschemael = $node;
            $targetns = $node->getAttribute( 'targetNamespace' );
            foreach my $el ( $node->childNodes ) {
                traverse_schema( $baseschemael, $targetns, $el, [ $baseschemael, $stack ], $stelements );
            }
        }
        when ('element') {
            my ($innertype);
            if ( my $type = $node->getAttribute('type') ) {
                # inline type declaration...
                my ($valuens, $valuensprefix, $valuestr);
                if ($type =~ /\:/) {
                    ($valuensprefix, $valuestr) = split /:/, $type;
                } else {
                    $valuensprefix = '';
                    $valuestr = $type;
                }
                $valuens = resolve_ns($node, $stack, $valuensprefix);
                if ($valuens eq XSD_NS) {
                    # este cara é um simple type.
                    push @$stelements, build_xpath([$node, $stack]);
                    return;
                } elsif ($valuens eq $targetns) {
                    # eu tenho que achar o tipo no próprio schema
                    ($innertype) =
                        grep { ref $_ eq 'XML::LibXML::Element' &&
                               $_->localname =~ /(complex|simple)Type/ &&
                               $_->getAttribute('name') eq $valuestr }
                        $baseschemael->childNodes;
                } else {
                    die "References to external schemas not yet implemented";
                }
            } else {
                ($innertype) =
                    grep { ref $_ eq 'XML::LibXML::Element' &&
                           $_->localname =~ /(complex|simple)Type/ }
                    $node->childNodes;
            }
            if ($innertype->localname eq 'simpleType') {
                push @$stelements, build_xpath([$node, $stack]);
                return;
            } else {
                my $inner = [ $node, $stack ];
                foreach my $el ($innertype->childNodes) {
                    traverse_schema( $baseschemael, $targetns, $el, [ $innertype, $inner ], $stelements );
                }
            }
        }
        when ('sequence') {
            foreach my $el ($node->childNodes) {
                traverse_schema( $baseschemael, $targetns, $el, [ $node, $stack ], $stelements );
            }
        }
    }
}

sub resolve_ns {
    my ($node, $stack, $prefix) = @_;
    my $attrname = $prefix ? 'xmlns:'.$prefix : 'xmlns';
    if (my $value = $node->getAttribute($attrname)) {
        return $value;
    } elsif (ref $stack eq 'ARRAY' &&
             scalar @$stack == 2) {
        return resolve_ns($stack->[0], $stack->[1], $prefix);
    } else {
        die "prefix $prefix lookup failed.";
    }
}

sub build_xpath {
    my $stack = shift;
    my ($node, $outer) = @$stack;
    my $outer_info = { path => '' };
    $outer_info = build_xpath($outer) if $outer;

    if (ref $node eq 'XML::LibXML::Element' &&
        $node->localname eq 'element') {
        my $label = get_label($node);
        my $complabel = $outer_info->{completelabel} ?
                $outer_info->{completelabel}.' - '.$label :
                $label;
        my $type = get_type($node);
        return { type => $type,
                 name => $node->getAttribute('name'),
                 path => $outer_info->{path}.'/'.$node->getAttribute('name'),
                 label => $label,
                 completelabel => $complabel }
    } else {
        return $outer_info;
    }
}

sub get_label {
    my $node = shift;
    my ($ann) = grep { ref $_ eq 'XML::LibXML::Element' &&
                       $_->localname eq 'annotation' }
        $node->childNodes;
    return '' unless $ann;
    my ($app) = grep { ref $_ eq 'XML::LibXML::Element' &&
                       $_->localname eq 'appinfo' }
        $ann->childNodes;
    return '' unless $app;
    my ($lab) = grep { ref $_ eq 'XML::LibXML::Element' &&
                       $_->localname eq 'label' }
        $app->childNodes;
    my ($txt) = grep { ref $_ eq 'XML::LibXML::Text' }
        $lab->childNodes;
    return '' unless $txt;
    return $txt->data;
}

sub get_type {
    my $node = shift;
    my $direct_type = $node->getAttribute('type');
    return $direct_type if $direct_type;

    my ($sty) = grep { ref $_ eq 'XML::LibXML::Element' &&
                       $_->localname eq 'simpleType' }
        $node->childNodes;
    return unless $sty;

    my ($def) = grep { ref $_ eq 'XML::LibXML::Element' }
        $sty->childNodes;
    return $def->getAttribute('base');
}

1;
