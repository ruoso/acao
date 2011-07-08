package Acao::View::Download;

use Moose;


extends 'Catalyst::View::Download';

#
=head1 NAME

Acao::View::Download::CSV - Renderiza documentos CSV.

=head1 DESCRIPTION

Essa view é utilizada para enviar ao usuário um documento csv que está
no stash sob a chave "csv".

=cut



__PACKAGE__->config(
    content_type => {'text/csv' => { 'outfile' => 'relatorio_'.time.'.csv' } }
);

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut

1;
