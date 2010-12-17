# IMPORTANT: if you delete this file your app will not work as
# expected. you have been warned
use inc::Module::Install;
 
name 'Acao';
all_from 'lib/Acao.pm';
 
requires 'Catalyst::Runtime' => '5.80007';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::StackTrace';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'Catalyst::Model::DBIC::Schema';
requires 'Catalyst::Model::Sedna';
requires 'Catalyst::View::TT';
requires 'DBIx::Class';
requires 'Catalyst::Runtime';
requires 'Catalyst::Model::LDAP';
requires 'Data::Dumper';
requires 'Data::UUID';
requires 'DateTime';
requires 'Moose';
requires 'Catalyst::Controller';
requires 'Catalyst';
requires 'XML::Compile::Schema';
requires 'XML::LibXML';
requires 'Catalyst::Plugin::Unicode';
requires 'Catalyst::Plugin::Authentication';
requires 'Catalyst::Plugin::Session::Store::FastMmap';
requires 'Catalyst::Plugin::Session::State::Cookie';
requires 'Catalyst::Authentication::Store::LDAP';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;
 
install_script glob('script/*.pl');
auto_install;
WriteAll;
 


