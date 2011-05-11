#importa as tabelas do banco de dados e constroi as classe para o dbi class

perl -MDBIx::Class::Schema::Loader=dump_to_dir:"/home/paulo/devel/acao-viladomar/trunk/schemas" -e 'DBIx::Class::Schema::Loader->connection("dbi:Pg:dbname=acaodw;host=127.0.0.1;port=5432","acao","blableblibloblu")'

#importa as tabelas do banco de dados e constroi as classe para o dbi class
dbicdump Acao::Plugins::SDH::DimSchema "dbi:Pg:dbname=sdh;host=127.0.0.1;port=5432" acao blableblibloblu

#importa as tabelas do banco de dados e constroi as classe para o dbi class setando o schema do banco
dbicdump -o db_schema=pronasci_teste Acao::Plugins::Pronasci::DimSchema  "dbi:Pg:dbname=acao;host=127.0.0.1;port=5432" acao 12345

#importa as tabelas do banco de dados e constroi as classe para o dbi class
perl -MDBIx::Class::Schema::Loader=dump_to_dir:"/tmp/bla" -e 'DBIx::Class::Schema::Loader->connection("dbi:SQLite:dbname=acao.db")'


#gera as tabela a partir das classes do dbixclass sem estar no MODEL
perl -MAcao::Plugins::VilaDoMar::DimSchema -e'my $schema = Acao::Plugins::VilaDoMar::DimSchema->connect("dbi:Pg:host=127.0.0.1;dbname=acaodw",'acao', '12345'); $schema->deploy();'

# a partir das classes do dbix class no MODEL constrói as tabelas
perl -Ilib -MAcao -e 'Acao->model("DB")->schema->deploy'


perl -MDBIx::Class::Schema::Loader=dump_to_dir:"/tmp/bla" -e 'DBIx::Class::Schema::Loader->connection("dbi:SQLite:dbname=acao.db")'

#gera as tabela a partir das classes do dbixclass sem estar no MODEL
perl -MAcao::Schema -e'my $schema = Acao::Schema->connect("dbi:Pg:host=127.0.0.1;dbname=acao",'acao', '12345'); $schema->deploy();'
