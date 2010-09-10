package Acao::Model::Ldap;

use base qw/Catalyst::Model::LDAP/;

__PACKAGE__->config(
#    host => 'ldap.ufl.edu',
#    base => 'ou=People,dc=ufl,dc=edu'

   host              => 'logos.virgo.atlantico.net.br',
   base              => 'cn=Browser Default Schema',
   dn                => '',
   password          => '',
   start_tls         => 0,
   start_tls_options => {},
   options           => {},  # Options passed to search

);
1;

