--
-- PostgreSQL database dump
--

-- Started on 2010-08-03 10:38:15 BRT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = off;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET escape_string_warning = off;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 1532 (class 1259 OID 16399)
-- Dependencies: 6
-- Name: alertas; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE alertas (
    id_alerta integer NOT NULL,
    id_consolidacao integer NOT NULL,
    etapa integer NOT NULL,
    log_level character varying NOT NULL,
    datahora timestamp with time zone NOT NULL,
    id_documento_consolidado character varying,
    descricao_alerta character varying NOT NULL
);


ALTER TABLE public.alertas OWNER TO acao;

--
-- TOC entry 1533 (class 1259 OID 16405)
-- Dependencies: 1532 6
-- Name: alertas_id_alerta_seq; Type: SEQUENCE; Schema: public; Owner: acao
--

CREATE SEQUENCE alertas_id_alerta_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.alertas_id_alerta_seq OWNER TO acao;

--
-- TOC entry 1850 (class 0 OID 0)
-- Dependencies: 1533
-- Name: alertas_id_alerta_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acao
--

ALTER SEQUENCE alertas_id_alerta_seq OWNED BY alertas.id_alerta;


--
-- TOC entry 1851 (class 0 OID 0)
-- Dependencies: 1533
-- Name: alertas_id_alerta_seq; Type: SEQUENCE SET; Schema: public; Owner: acao
--

SELECT pg_catalog.setval('alertas_id_alerta_seq', 158, true);


--
-- TOC entry 1534 (class 1259 OID 16407)
-- Dependencies: 6
-- Name: consolidacao; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE consolidacao (
    id_consolidacao integer NOT NULL,
    id_definicao_consolidacao integer NOT NULL,
    data_ini timestamp with time zone,
    data_fim timestamp with time zone,
    dn character varying NOT NULL,
    status character varying NOT NULL
);


ALTER TABLE public.consolidacao OWNER TO acao;

--
-- TOC entry 1535 (class 1259 OID 16413)
-- Dependencies: 1534 6
-- Name: consolidacao_id_consolidacao_seq; Type: SEQUENCE; Schema: public; Owner: acao
--

CREATE SEQUENCE consolidacao_id_consolidacao_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.consolidacao_id_consolidacao_seq OWNER TO acao;

--
-- TOC entry 1852 (class 0 OID 0)
-- Dependencies: 1535
-- Name: consolidacao_id_consolidacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acao
--

ALTER SEQUENCE consolidacao_id_consolidacao_seq OWNED BY consolidacao.id_consolidacao;


--
-- TOC entry 1853 (class 0 OID 0)
-- Dependencies: 1535
-- Name: consolidacao_id_consolidacao_seq; Type: SEQUENCE SET; Schema: public; Owner: acao
--

SELECT pg_catalog.setval('consolidacao_id_consolidacao_seq', 19, true);


--
-- TOC entry 1536 (class 1259 OID 16415)
-- Dependencies: 6
-- Name: consolidador; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE consolidador (
    id_definicao_consolidacao integer NOT NULL,
    dn character varying NOT NULL
);


ALTER TABLE public.consolidador OWNER TO acao;

--
-- TOC entry 1537 (class 1259 OID 16421)
-- Dependencies: 6
-- Name: definicao_consolidacao; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE definicao_consolidacao (
    id_definicao_consolidacao integer NOT NULL,
    id_projeto integer,
    xml_schema character varying,
    nome character varying,
    status character varying,
    data_ini timestamp with time zone,
    data_fim timestamp with time zone
);


ALTER TABLE public.definicao_consolidacao OWNER TO acao;

--
-- TOC entry 1538 (class 1259 OID 16427)
-- Dependencies: 6 1537
-- Name: definicao_consolidacao_id_definicao_consolidacao_seq; Type: SEQUENCE; Schema: public; Owner: acao
--

CREATE SEQUENCE definicao_consolidacao_id_definicao_consolidacao_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.definicao_consolidacao_id_definicao_consolidacao_seq OWNER TO acao;

--
-- TOC entry 1854 (class 0 OID 0)
-- Dependencies: 1538
-- Name: definicao_consolidacao_id_definicao_consolidacao_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acao
--

ALTER SEQUENCE definicao_consolidacao_id_definicao_consolidacao_seq OWNED BY definicao_consolidacao.id_definicao_consolidacao;


--
-- TOC entry 1855 (class 0 OID 0)
-- Dependencies: 1538
-- Name: definicao_consolidacao_id_definicao_consolidacao_seq; Type: SEQUENCE SET; Schema: public; Owner: acao
--

SELECT pg_catalog.setval('definicao_consolidacao_id_definicao_consolidacao_seq', 1, false);


--
-- TOC entry 1539 (class 1259 OID 16429)
-- Dependencies: 6
-- Name: digitador; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE digitador (
    id_leitura integer NOT NULL,
    dn character varying NOT NULL
);


ALTER TABLE public.digitador OWNER TO acao;

--
-- TOC entry 1540 (class 1259 OID 16435)
-- Dependencies: 6
-- Name: entrada_consolidacao; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE entrada_consolidacao (
    id_definicao_consolidacao integer NOT NULL,
    id_leitura integer NOT NULL,
    papel_leitura character varying
);


ALTER TABLE public.entrada_consolidacao OWNER TO acao;

--
-- TOC entry 1541 (class 1259 OID 16441)
-- Dependencies: 6
-- Name: etapa_coleta_dados; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE etapa_coleta_dados (
    id_definicao_consolidacao integer NOT NULL,
    plugin_coleta_dados character varying NOT NULL,
    ordem_coleta_dados integer
);


ALTER TABLE public.etapa_coleta_dados OWNER TO acao;

--
-- TOC entry 1542 (class 1259 OID 16447)
-- Dependencies: 6
-- Name: etapa_transformacao; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE etapa_transformacao (
    id_definicao_consolidacao integer NOT NULL,
    plugin_transformacao character varying NOT NULL,
    ordem_transformacao integer
);


ALTER TABLE public.etapa_transformacao OWNER TO acao;

--
-- TOC entry 1543 (class 1259 OID 16453)
-- Dependencies: 6
-- Name: etapa_validacao; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE etapa_validacao (
    id_definicao_consolidacao integer NOT NULL,
    plugin_validacao character varying NOT NULL,
    ordem_validacao integer
);


ALTER TABLE public.etapa_validacao OWNER TO acao;

--
-- TOC entry 1544 (class 1259 OID 16459)
-- Dependencies: 6
-- Name: instrumento; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE instrumento (
    id_projeto integer NOT NULL,
    nome character varying NOT NULL,
    xml_schema character varying NOT NULL,
    campo_controle character varying NOT NULL
);


ALTER TABLE public.instrumento OWNER TO acao;

--
-- TOC entry 1545 (class 1259 OID 16465)
-- Dependencies: 6
-- Name: leitura; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE leitura (
    id_leitura integer NOT NULL,
    id_projeto integer NOT NULL,
    nome character varying NOT NULL,
    coleta_ini timestamp with time zone,
    coleta_fim timestamp with time zone,
    digitacao_ini timestamp with time zone,
    digitacao_fim timestamp with time zone,
    revisao_ini timestamp with time zone,
    revisao_fim timestamp with time zone
);


ALTER TABLE public.leitura OWNER TO acao;

--
-- TOC entry 1546 (class 1259 OID 16471)
-- Dependencies: 1545 6
-- Name: leitura_id_leitura_seq; Type: SEQUENCE; Schema: public; Owner: acao
--

CREATE SEQUENCE leitura_id_leitura_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.leitura_id_leitura_seq OWNER TO acao;

--
-- TOC entry 1856 (class 0 OID 0)
-- Dependencies: 1546
-- Name: leitura_id_leitura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acao
--

ALTER SEQUENCE leitura_id_leitura_seq OWNED BY leitura.id_leitura;


--
-- TOC entry 1857 (class 0 OID 0)
-- Dependencies: 1546
-- Name: leitura_id_leitura_seq; Type: SEQUENCE SET; Schema: public; Owner: acao
--

SELECT pg_catalog.setval('leitura_id_leitura_seq', 1, false);


--
-- TOC entry 1547 (class 1259 OID 16473)
-- Dependencies: 6
-- Name: projeto; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE projeto (
    id_projeto integer NOT NULL,
    nome text NOT NULL
);


ALTER TABLE public.projeto OWNER TO acao;

--
-- TOC entry 1548 (class 1259 OID 16479)
-- Dependencies: 6 1547
-- Name: projeto_id_projeto_seq; Type: SEQUENCE; Schema: public; Owner: acao
--

CREATE SEQUENCE projeto_id_projeto_seq
    START WITH 1
    INCREMENT BY 1
    NO MAXVALUE
    NO MINVALUE
    CACHE 1;


ALTER TABLE public.projeto_id_projeto_seq OWNER TO acao;

--
-- TOC entry 1858 (class 0 OID 0)
-- Dependencies: 1548
-- Name: projeto_id_projeto_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: acao
--

ALTER SEQUENCE projeto_id_projeto_seq OWNED BY projeto.id_projeto;


--
-- TOC entry 1859 (class 0 OID 0)
-- Dependencies: 1548
-- Name: projeto_id_projeto_seq; Type: SEQUENCE SET; Schema: public; Owner: acao
--

SELECT pg_catalog.setval('projeto_id_projeto_seq', 1, false);


--
-- TOC entry 1549 (class 1259 OID 16481)
-- Dependencies: 6
-- Name: revisor; Type: TABLE; Schema: public; Owner: acao; Tablespace: 
--

CREATE TABLE revisor (
    id_leitura integer NOT NULL,
    dn character varying NOT NULL
);


ALTER TABLE public.revisor OWNER TO acao;

--
-- TOC entry 1827 (class 2604 OID 16487)
-- Dependencies: 1533 1532
-- Name: id_alerta; Type: DEFAULT; Schema: public; Owner: acao
--

ALTER TABLE alertas ALTER COLUMN id_alerta SET DEFAULT nextval('alertas_id_alerta_seq'::regclass);


--
-- TOC entry 1828 (class 2604 OID 16488)
-- Dependencies: 1535 1534
-- Name: id_consolidacao; Type: DEFAULT; Schema: public; Owner: acao
--

ALTER TABLE consolidacao ALTER COLUMN id_consolidacao SET DEFAULT nextval('consolidacao_id_consolidacao_seq'::regclass);


--
-- TOC entry 1829 (class 2604 OID 16489)
-- Dependencies: 1538 1537
-- Name: id_definicao_consolidacao; Type: DEFAULT; Schema: public; Owner: acao
--

ALTER TABLE definicao_consolidacao ALTER COLUMN id_definicao_consolidacao SET DEFAULT nextval('definicao_consolidacao_id_definicao_consolidacao_seq'::regclass);


--
-- TOC entry 1830 (class 2604 OID 16490)
-- Dependencies: 1546 1545
-- Name: id_leitura; Type: DEFAULT; Schema: public; Owner: acao
--

ALTER TABLE leitura ALTER COLUMN id_leitura SET DEFAULT nextval('leitura_id_leitura_seq'::regclass);


--
-- TOC entry 1831 (class 2604 OID 16491)
-- Dependencies: 1548 1547
-- Name: id_projeto; Type: DEFAULT; Schema: public; Owner: acao
--

ALTER TABLE projeto ALTER COLUMN id_projeto SET DEFAULT nextval('projeto_id_projeto_seq'::regclass);


--
-- TOC entry 1832 (class 0 OID 16399)
-- Dependencies: 1532
-- Data for Name: alertas; Type: TABLE DATA; Schema: public; Owner: acao
--



--
-- TOC entry 1833 (class 0 OID 16407)
-- Dependencies: 1534
-- Data for Name: consolidacao; Type: TABLE DATA; Schema: public; Owner: acao
--



--
-- TOC entry 1834 (class 0 OID 16415)
-- Dependencies: 1536
-- Data for Name: consolidador; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO consolidador (id_definicao_consolidacao, dn) VALUES (1, 'acao');


--
-- TOC entry 1835 (class 0 OID 16421)
-- Dependencies: 1537
-- Data for Name: definicao_consolidacao; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO definicao_consolidacao (id_definicao_consolidacao, id_projeto, xml_schema, nome, status, data_ini, data_fim) VALUES (1, 1, 'viladomar-consolidado.xsd', 'Recadastramento Vila do Mar', 'Não Iniciada', NULL, NULL);


--
-- TOC entry 1836 (class 0 OID 16429)
-- Dependencies: 1539
-- Data for Name: digitador; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO digitador (id_leitura, dn) VALUES (1, 'acao');
INSERT INTO digitador (id_leitura, dn) VALUES (1, 'ciclano');
INSERT INTO digitador (id_leitura, dn) VALUES (2, 'ciclano');
INSERT INTO digitador (id_leitura, dn) VALUES (2, 'acao');
INSERT INTO digitador (id_leitura, dn) VALUES (3, 'acao');
INSERT INTO digitador (id_leitura, dn) VALUES (3, 'ciclano');


--
-- TOC entry 1837 (class 0 OID 16435)
-- Dependencies: 1540
-- Data for Name: entrada_consolidacao; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO entrada_consolidacao (id_definicao_consolidacao, id_leitura, papel_leitura) VALUES (1, 1, 'cadernoa');
INSERT INTO entrada_consolidacao (id_definicao_consolidacao, id_leitura, papel_leitura) VALUES (1, 2, 'cadernob');


--
-- TOC entry 1838 (class 0 OID 16441)
-- Dependencies: 1541
-- Data for Name: etapa_coleta_dados; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO etapa_coleta_dados (id_definicao_consolidacao, plugin_coleta_dados, ordem_coleta_dados) VALUES (1, 'Acao::Plugins::VilaDoMar::ColetaDeDados', 1);


--
-- TOC entry 1839 (class 0 OID 16447)
-- Dependencies: 1542
-- Data for Name: etapa_transformacao; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO etapa_transformacao (id_definicao_consolidacao, plugin_transformacao, ordem_transformacao) VALUES (1, 'Acao::Plugins::VilaDoMar::NormalizaIdade', 1);
INSERT INTO etapa_transformacao (id_definicao_consolidacao, plugin_transformacao, ordem_transformacao) VALUES (1, 'Acao::Plugins::VilaDoMar::NormalizaProfissao', 1);
INSERT INTO etapa_transformacao (id_definicao_consolidacao, plugin_transformacao, ordem_transformacao) VALUES (1, 'Acao::Plugins::VilaDoMar::NormalizaString', 1);
INSERT INTO etapa_transformacao (id_definicao_consolidacao, plugin_transformacao, ordem_transformacao) VALUES (1, 'Acao::Plugins::VilaDoMar::ResumoMembros', 1);


--
-- TOC entry 1840 (class 0 OID 16453)
-- Dependencies: 1543
-- Data for Name: etapa_validacao; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO etapa_validacao (id_definicao_consolidacao, plugin_validacao, ordem_validacao) VALUES (1, 'Acao::Plugins::VilaDoMar::ValidaDocumentos', NULL);


--
-- TOC entry 1841 (class 0 OID 16459)
-- Dependencies: 1544
-- Data for Name: instrumento; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO instrumento (id_projeto, nome, xml_schema, campo_controle) VALUES (1, 'Recadastramento - Caderno B', 'viladomar-cadernob.xsd', '1');
INSERT INTO instrumento (id_projeto, nome, xml_schema, campo_controle) VALUES (1, 'Recadastramento - Caderno A', 'viladomar-cadernoa.xsd', '1');
INSERT INTO instrumento (id_projeto, nome, xml_schema, campo_controle) VALUES (2, 'SDH - Caderno A', 'sdh-cadernoa.xsd', '1');


--
-- TOC entry 1842 (class 0 OID 16465)
-- Dependencies: 1545
-- Data for Name: leitura; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO leitura (id_leitura, id_projeto, nome, coleta_ini, coleta_fim, digitacao_ini, digitacao_fim, revisao_ini, revisao_fim) VALUES (1, 1, 'Recadastramento - Caderno A', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO leitura (id_leitura, id_projeto, nome, coleta_ini, coleta_fim, digitacao_ini, digitacao_fim, revisao_ini, revisao_fim) VALUES (2, 1, 'Recadastramento - Caderno B', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO leitura (id_leitura, id_projeto, nome, coleta_ini, coleta_fim, digitacao_ini, digitacao_fim, revisao_ini, revisao_fim) VALUES (3, 2, 'SDH - Caderno A', NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 1843 (class 0 OID 16473)
-- Dependencies: 1547
-- Data for Name: projeto; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO projeto (id_projeto, nome) VALUES (1, 'Vila do Mar');
INSERT INTO projeto (id_projeto, nome) VALUES (2, 'SDH');


--
-- TOC entry 1844 (class 0 OID 16481)
-- Dependencies: 1549
-- Data for Name: revisor; Type: TABLE DATA; Schema: public; Owner: acao
--

INSERT INTO revisor (id_leitura, dn) VALUES (1, 'acao');
INSERT INTO revisor (id_leitura, dn) VALUES (1, 'beltrano');
INSERT INTO revisor (id_leitura, dn) VALUES (2, 'beltrano');
INSERT INTO revisor (id_leitura, dn) VALUES (2, 'acao');


--
-- TOC entry 1849 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2010-08-03 10:38:15 BRT

--
-- PostgreSQL database dump complete
--

