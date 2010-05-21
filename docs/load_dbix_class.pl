#importa as tabelas do acaodw e constroi as classe para o dbi class

perl -MDBIx::Class::Schema::Loader=dump_to_dir:"/home/paulo/devel/acao-viladomar/trunk/schemas" -e 'DBIx::Class::Schema::Loader->connection("dbi:Pg:dbname=acaodw;host=127.0.0.1;port=5432","acao","blableblibloblu")'



