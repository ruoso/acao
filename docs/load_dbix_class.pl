#importa as tabelas do acaodw e constroi as classe para o dbi class

perl -MDBIx::Class::Schema::Loader=dump_to_dir:"/home/paulo/devel/acao-viladomar/trunk/schemas" -e 'DBIx::Class::Schema::Loader->connection("dbi:Pg:dbname=acaodw;host=127.0.0.1;port=5432","acao","blableblibloblu")'

# cmd best
dbicdump Acao::Plugins::SDH::DimSchema "dbi:Pg:dbname=sdh;host=127.0.0.1;port=5432" acao blableblibloblu


#gera as tabela a partir das classes do dbixclass sem estar no MODEL
perl -MAcao::Plugins::VilaDoMar::DimSchema -e'my $schema = Acao::Plugins::VilaDoMar::DimSchema->connect("dbi:Pg:host=127.0.0.1;dbname=acaodw",'acao', '12345'); $schema->deploy();'

# a partir das classes do dbix class no MODEL constrói as tabelas
perl -Ilib -MAcao -e 'Acao->model("DB")->schema->deploy'

