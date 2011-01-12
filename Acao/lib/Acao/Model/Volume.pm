package Acao::Model::Volume;
# Copyright 2010 - Prefeitura Municipal de Fortaleza
#
# Este arquivo é parte do programa Ação - Sistema de Acompanhamento de
# Projetos Sociais
#
# O Ação é um software livre; você pode redistribui-lo e/ou modifica-lo
# dentro dos termos da Licença Pública Geral GNU como publicada pela
# Fundação do Software Livre (FSF); na versão 2 da Licença.
#
# Este programa é distribuido na esperança que possa ser util, mas SEM
# NENHUMA GARANTIA; sem uma garantia implicita de ADEQUAÇÂO a qualquer
# MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU
# para maiores detalhes.
#
# Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o
# título "LICENCA.txt", junto com este programa, se não, escreva para a
# Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor,
use Moose;
extends 'Acao::Model';
use Acao::ModelUtil;
use XML::LibXML;
use XML::Compile::Schema;
use XML::Compile::Util;
use DateTime;
use Encode;
use Data::UUID;
use Data::Dumper;
use List::MoreUtils 'pairwise';


use constant VOLUME_NS =>'http://schemas.fortaleza.ce.gov.br/acao/volume.xsd';
my $controle = XML::Compile::Schema->new( Acao->path_to('schemas/volume.xsd') );
$controle->importDefinitions( Acao->path_to('schemas/autorizacoes.xsd') );
my $controle_w = $controle->compile( WRITER => pack_type( VOLUME_NS, 'volume' ), use_default_namespace => 1 );
my $controle_r = $controle->compile( READER => pack_type( VOLUME_NS, 'volume') );

my $autoriza_w = $controle->compile( WRITER => pack_type( VOLUME_NS, 'autorizacoes'), use_default_namespace => 1);
my $autoriza_r = $controle->compile( READER => pack_type( VOLUME_NS, 'autorizacoes'));

my $role_criar = Acao->config->{'roles'}->{'volume'}->{'criar'};
my $role_alterar = Acao->config->{'roles'}->{'volume'}->{'alterar'};
my $role_listar = Acao->config->{'roles'}->{'volume'}->{'listar'};


=head1 NAME

Acao::Model::Volume - Implementa as regras de negócio do papel volume

=head1 DESCRIPTION

Essa classe implementa as regras de negócio específicas para o papel
de volume.

=head1 METHODS

=over

=item listar_volumes()

Retorna os volumes os quais o usuário autenticado tem acesso.

=cut

txn_method 'listar_volumes' => authorized $role_listar => sub {
    my ($self, $args) = @_;


  my $grupos = join ' or ', map { '@principal = "'.$_.'"' } @{$self->user->memberof};


  # Query para listagem
   my $list = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
            . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
            . 'subsequence('
            . 'for $x in collection("volume")/ns:volume[ns:autorizacoes/author:autorizacao[('.$grupos.')'
            . 'and @role="listar"]]'
            . 'return ($x/ns:collection/text(), '.$args->{xqueryret}.'),'
            . '('.$args->{interval_ini} * $args->{num_por_pagina}.') + 1 ,'.$args->{num_por_pagina}.''
            . ')';


    # Contrução da query de contagem para contrução da paginação

  my $count = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
            . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
            . 'count('
            . 'for $x in collection("volume")/ns:volume[ns:autorizacoes/author:autorizacao[('.$grupos.')'
            . 'and @role="listar"]]'
            . 'return "")';

    return {
        list       => $list,
          count      => $count
    };

};

sub auditoria  {
    my ($self, $args) = @_;

}


=item criar_volume($nome, $representaVolumeFisico, $classificacao, $localizacao ,$ip)

=cut

txn_method 'criar_volume' => authorized $role_criar => sub {
    my $self = shift;
    my ( $nome, $representaVolumeFisico, $classificacao, $localizacao,$autorizacoes, $ip ) = @_;

    my $ug  = new Data::UUID;
    my $uuid = $ug->create();
    my $str = $ug->to_string($uuid);
    my $doc_name = 'volume-' . $str;

    my $acao = 'insert';
    my $dados = 'create collection ("'.$doc_name.'")';
    my $role = 'role';

    $self->sedna->execute($dados);

    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );

    my $res_xml = $controle_w->($doc,
                                {
                                    nome       => $nome,
                                    criacao    => DateTime->now(),
                                    fechamento => '',
                                    arquivamento => '',
                                    collection => $doc_name,
                                    estado => 'aberto',
                                    representaVolumeFisico => $representaVolumeFisico,
                                    classificacao => $classificacao,
                                    localizacao => $localizacao,
                                    autorizacoes => $autorizacoes,

                                },
                               );

    $self->sedna->conn->loadData( $res_xml->toString, $doc_name, 'volume' );
    $self->sedna->conn->endLoadData();

};

txn_method 'alterar_estado' => authorized $role_alterar => sub {
    my $self = shift;
    my ( $id_volume, $estado, $ip ) = @_;

    my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
       $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]/ns:estado with <ns:estado>'.$estado.'</ns:estado> ';
    $self->sedna->execute($xq);

    if($estado eq 'fechado')
    {
            my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
               $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]';
               $xq .= '/ns:fechamento with <ns:fechamento>'.DateTime->now().'</ns:fechamento>';
            $self->sedna->execute($xq);
    }

    if($estado eq 'arquivado')
    {
            my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
               $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]';
               $xq .= '/ns:arquivamento with <ns:arquivamento>'.DateTime->now().'</ns:arquivamento>';
            $self->sedna->execute($xq);
    }

    if($estado eq 'aberto')
    {
            my $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
               $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]';
               $xq .= '/ns:arquivamento with <ns:arquivamento></ns:arquivamento>';
            $self->sedna->execute($xq);

               $xq  = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";';
               $xq .= 'update replace $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]';
               $xq .= '/ns:fechamento with <ns:fechamento></ns:fechamento>';
            $self->sedna->execute($xq);
    }

};

txn_method 'getDadosVolumeId' => authorized $role_listar => sub {
    my $self = shift;
    my ($id_volume) = @_;
    my $xq = 'declare namespace ns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
                    for $x in collection("volume")/ns:volume[ns:collection="'.$id_volume.'"]
                    return ($x/ns:nome/text(), $x/ns:classificacao/text(), $x/ns:localizacao/text(), $x/ns:estado/text(),
                            $x/ns:criacao/text(), $x/ns:representaVolumeFisico/text())';

   $self->sedna->execute($xq);

    my $vol = {};
    while(my $nome = $self->sedna->get_item){
        $vol = {
                    nome => $nome,
                    classificacao => $self->sedna->get_item,
                    localizacao   => $self->sedna->get_item,
                    estado        => $self->sedna->get_item,
                    criacao       => $self->sedna->get_item,
                    volume_fisico => $self->sedna->get_item > 0 ? 'Sim' : 'Não',
                  };
    };

   return $vol;
};

txn_method 'options_volumes' => authorized $role_alterar => sub {
    my ( $self, $volume_origem ) = @_;

    my $grupos = join ' or ', map { '@principal = "'.$_.'"' } @{$self->user->memberof};

    my $xq = 'declare namespace vol = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";
              declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";
              for $x in collection("volume")/vol:volume[vol:autorizacoes/author:autorizacao[('.$grupos.')
                 and @role="criar"]][vol:collection/text() ne "'.$volume_origem.'"]
                     return <option value="{$x/vol:collection/text()}">{$x/vol:nome/text()}</option>';

    $self->sedna->execute($xq);
    my $ret;
    while (my $item = $self->sedna->get_item()) {
       $ret .= $item;
    }
   return $ret;
};

sub new_autorizacao {
  my ($self, $initial_principals) = @_;
    my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
    my $xml = $autoriza_w->($doc,{ })->toString;

  return $self->add_autorizacoes($xml,$self->build_autorizacao_AoH($initial_principals,
      [qw(alterar criar listar visualizar)]));
}

sub remove_autorizacoes {
  my ($self, $xml_autorizacoes, @positions) = @_;
  my $hash = $autoriza_r->($xml_autorizacoes);
  splice @{$hash->{autorizacao}}, $_, 1, () for reverse sort @positions;
  my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
  return $autoriza_w->($doc, $hash)->toString;
}

sub add_autorizacoes {
  my ($self, $xml_autorizacoes, $AoH_novas_autorizacoes) = @_;
  my $hash = $autoriza_r->($xml_autorizacoes);
  push @{$hash->{autorizacao}}, @$AoH_novas_autorizacoes;
  my $doc = XML::LibXML::Document->new( '1.0', 'UTF-8' );
  return $autoriza_w->($doc, $hash)->toString;
}

sub build_autorizacao_AoH {
  my ($self, $principal, $role) = @_;

  my @cart_p     = sort( (@$principal) x @$role );
  my @cart_r     = (@$role) x @$principal;
  my @permissoes = pairwise { { principal => $a, role => $b } } @cart_p, @cart_r;
  return \@permissoes;
}

sub desserialize_autorizacoes {
  my ($self, $xml_autorizacoes) = @_;
  return $autoriza_r->($xml_autorizacoes);
}

sub pode_ver_volume {
  my($self, $id_volume) = @_;

  my $grupos = join ' or ', map { '@principal = "'.$_.'"' } @{$self->user->memberof};

  $self->sedna->begin;
    my $query  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
             . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
             . 'for $x in collection("volume")/ns:volume[ns:collection = "'.$id_volume.'"] '
             . 'where $x/ns:autorizacoes/author:autorizacao[('.$grupos.') and @role="listar"] '
             . 'return $x/ns:autorizacoes';

    $self->sedna->execute($query);
    my $res =$self->sedna->get_item();
    $self->sedna->commit;
  return $res;
}

sub pode_criar_volume {
  my($self) = @_;
  return $role_criar ~~ @{$self->user->memberof};

}
sub pode_alterar_volume {
  my($self, $id_volume) = @_;
  return $self->_checa_autorizacao_volume($id_volume, 'alterar') &&
    $role_alterar ~~ @{$self->user->memberof};
}

sub autorizacoes_do_volume {
    my($self, $id_volume) = @_;


  $self->sedna->begin;
    my $query  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
             . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
             . 'for $x in collection("volume")/ns:volume[ns:collection = "'.$id_volume.'"] '
             . 'return $x/ns:autorizacoes';



    $self->sedna->execute($query);
    my $xml =$self->sedna->get_item();
    $self->sedna->commit;
  return $xml;


}

sub _checa_autorizacao_volume {
   my($self, $id_volume, $acao) = @_;
  my $grupos = join ' or ', map { '@principal = "'.$_.'"' }  @{$self->user->memberof};

  $self->sedna->begin;
  my $query  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
             . 'declare namespace author = "http://schemas.fortaleza.ce.gov.br/acao/autorizacoes.xsd";'
             . 'for $x in collection("volume")/ns:volume[ns:collection = "'.$id_volume.'"] '
             . 'where $x/ns:autorizacoes/author:autorizacao[('.$grupos.') and @role="'.$acao.'"] '
             . 'return $x/ns:autorizacoes';

  $self->sedna->execute($query);
  my $criar_dossie_no_volume =$self->sedna->get_item();
  $self->sedna->commit;

   return $criar_dossie_no_volume;
}


sub store_altera_volume {
    my($self, $args) = @_;
# Gambis provisória -  Fazendo Update de cada campo separadamente!
    my $query_autorizacao  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
               . 'update replace $x in collection("volume")'
               . '[/ns:volume/ns:collection="'.$args->{id_volume}.'"]/ns:volume/ns:autorizacoes'
               . ' with '.$args->{autorizacoes};

    $self->sedna->begin;
    $self->sedna->execute($query_autorizacao);




    my $query_nome  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
               . 'update replace $x in collection("volume")'
               . '[/ns:volume/ns:collection="'.$args->{id_volume}.'"]/ns:volume/ns:nome'
               . ' with <nome xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">'.$args->{nome}.'</nome>';


    $self->sedna->execute($query_nome);


    my $query_classificacao  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
               . 'update replace $x in collection("volume")'
               . '[/ns:volume/ns:collection="'.$args->{id_volume}.'"]/ns:volume/ns:classificacao'
               . ' with <classificacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">'.$args->{classificacao}.'</classificacao>';

    $self->sedna->execute($query_classificacao);


    my $query_volume_fisico  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
               . 'update replace $x in collection("volume")'
               . '[/ns:volume/ns:collection="'.$args->{id_volume}.'"]/ns:volume/ns:representaVolumeFisico'
               . ' with <representaVolumeFisico xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">'.$args->{volume_fisico}.'</representaVolumeFisico>';

    $self->sedna->execute($query_volume_fisico);


    my $query_localizacao  = 'declare namespace ns = "http://schemas.fortaleza.ce.gov.br/acao/volume.xsd";'
               . 'update replace $x in collection("volume")'
               . '[/ns:volume/ns:collection="'.$args->{id_volume}.'"]/ns:volume/ns:localizacao'
               . ' with <localizacao xmlns="http://schemas.fortaleza.ce.gov.br/acao/volume.xsd">'.$args->{localizacao}.'</localizacao>';

    $self->sedna->execute($query_localizacao);

$self->sedna->commit;
}




=cut

=item

=cut

=head1 COPYRIGHT AND LICENSING

Copyright 2010 - Prefeitura de Fortaleza. Este software é licenciado
sob a GPL versão 2.

=cut
42;
