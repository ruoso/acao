# IMPORTANT: if you delete this file your app will not work as
# expected.  you have been warned
use inc::Module::Install;

name 'Acao';
all_from 'lib/Acao.pm';

requires 'Catalyst::Runtime' => '5.80007';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::StackTrace';
requires (
	 'Catalyst::Plugin::Authentication' => '0',
	 'Catalyst::Plugin::Session' => '0',
	 'Catalyst::Plugin::Session::Store::FastMmap' => '0',
	 'Catalyst::Plugin::Session::State::Cookie' => '0',
);
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'parent';
requires 'Config::General'; # This should reflect the config file format you've chosen
                 # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
