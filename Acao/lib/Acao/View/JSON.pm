package Acao::View::JSON;
use Moose;
use JSON;
use Encode;
use utf8;
use namespace::autoclean;
use Data::Dumper;

extends 'Catalyst::View::JSON';
__PACKAGE__->config(
	allow_callback  => 1,
	expose_stash    => 'json',
	encoding	=> 'utf-8'
);

=head1 NAME

Acao::View::JSON - Catalyst View

=head1 DESCRIPTION

Catalyst View.

=head1 AUTHOR

edilson,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

sub process {
	my($self, $c) = @_;

	# get the response data from stash
	my $cond = sub { 1 };

	my $single_key;
	if (my $expose = $self->expose_stash) {
		if (ref($expose) eq 'Regexp') {
			$cond = sub { $_[0] =~ $expose };
		} elsif (ref($expose) eq 'ARRAY') {
			my %match = map { $_ => 1 } @$expose;
			$cond = sub { $match{$_[0]} };
		} elsif (!ref($expose)) {
			$single_key = $expose;
		} else {
			$c->log->warn("expose_stash should be an array referernce or Regexp object.");
		}
	}

	my $data;
	if ($single_key) {
		$data = $c->stash->{$single_key};
	} else {
		$data = { map { $cond->($_) ? ($_ => $c->stash->{$_}) : () }
			keys %{$c->stash} };
	}

	my $cb_param = $self->allow_callback
		? ($self->callback_param || 'callback') : undef;
	my $cb = $cb_param ? $c->req->param($cb_param) : undef;
	$self->validate_callback_param($cb) if $cb;
	my $json = $self->json_dumper->($data, $self, $c); # weird order to be backward compat
	warn "JSON: $json";
	warn "JSON: ".decode("utf-8", $json);

	# When you set encoding option in View::JSON, this plugin DWIMs
	my $encoding = $self->encoding || 'utf-8';

# if you pass a valid Unicode flagged string in the stash,
# this view automatically transcodes to the encoding you set.
# Otherwise it just bypasses the stash data in JSON format
	if ( Encode::is_utf8($json) ) {
		$json = Encode::encode($encoding, $json);
	}

#$c->res->content_type("application/json; charset=$encoding");
	$c->res->content_type("text/html; charset=$encoding");

	if ($c->req->header('X-Prototype-Version') && !$self->no_x_json_header) {
		$c->res->header('X-JSON' => 'eval("("+this.transport.responseText+")")');
	}

	my $output;

## add UTF-8 BOM if the client is Safari
	if ($encoding eq 'utf-8') {
		my $user_agent = $c->req->user_agent || '';
		if ($user_agent =~ m/\bSafari\b/ and $user_agent !~ m/\bChrome\b/) {
			$output = "\xEF\xBB\xBF";
		}
	}
	warn "OUT $json";
	$output .= "$cb(" if $cb;
	$output .= $json;
	$output .= ");"   if $cb;

	$c->res->output($output);
}

1;
