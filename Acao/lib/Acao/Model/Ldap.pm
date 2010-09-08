package Acao::Model::Ldap;

use base qw/Catalyst::Model::LDAP/;

__PACKAGE__->config(
#    host => 'ldap.ufl.edu',
#    base => 'ou=People,dc=ufl,dc=edu'

    host => '10.101.40.200',
    base => 'ou=logos,dc=virgo,dc=atlantico,dc=net,dc=br'

);
1;

