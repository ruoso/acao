package Acao::Model::Ldap;

use base qw/Catalyst::Model::LDAP/;

__PACKAGE__->config(
    host => 'ldap.ufl.edu',
    base => 'ou=People,dc=ufl,dc=edu',
);

1;

