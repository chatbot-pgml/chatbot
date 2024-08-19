-- chatbot.agente definition

-- Drop table

-- DROP TABLE chatbot.agente;

CREATE TABLE chatbot.agente (
	id_agente bigserial NOT NULL,
	id_tenacidade int8 NULL,
	nome varchar(255) NULL,
	modelo varchar(255) NULL,
	prompt_modelo text NULL,
	prompt_modelo_sistema text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	tipo_modelo varchar(50) NULL,
	tarefa varchar(100) NULL,
	modelo_prompt_sessao text NULL,
	modelo_prompt_dialogo_u text NULL,
	modelo_prompt_dialogo_a text NULL
);

-- Permissions

ALTER TABLE chatbot.agente OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.agente TO u_znz1rkducdgumst;


-- chatbot.aplicacao definition

-- Drop table

-- DROP TABLE chatbot.aplicacao;

CREATE TABLE chatbot.aplicacao (
	id_aplicacao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	nome varchar(255) NULL,
	tipo varchar(20) NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.aplicacao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.aplicacao TO u_znz1rkducdgumst;


-- chatbot.aplicacao_sync definition

-- Drop table

-- DROP TABLE chatbot.aplicacao_sync;

CREATE TABLE chatbot.aplicacao_sync (
	id_aplicacao_sync bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_grupo_usuario int8 NULL,
	id_aplicacao int8 NULL,
	nome varchar(255) NULL,
	tipo varchar(20) NULL,
	situacao varchar(1) NULL
);

-- Permissions

ALTER TABLE chatbot.aplicacao_sync OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.aplicacao_sync TO u_znz1rkducdgumst;


-- chatbot.arquivo definition

-- Drop table

-- DROP TABLE chatbot.arquivo;

CREATE TABLE chatbot.arquivo (
	id_arquivo bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	texto text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.arquivo OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.arquivo TO u_znz1rkducdgumst;


-- chatbot.arquivo_parte definition

-- Drop table

-- DROP TABLE chatbot.arquivo_parte;

CREATE TABLE chatbot.arquivo_parte (
	id_arquivo_parte bigserial NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_arquivo int8 NOT NULL,
	sequencial int4 NOT NULL,
	parte text NOT NULL,
	embed _float4 NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.arquivo_parte OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.arquivo_parte TO u_znz1rkducdgumst;


-- chatbot.auditoria definition

-- Drop table

-- DROP TABLE chatbot.auditoria;

CREATE TABLE chatbot.auditoria (
	id_auditoria bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	data_hora_inclusao timestamp NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	nome_tabela_auditoria varchar(255) NULL,
	tipo_operacao_auditoria bpchar(1) NULL,
	valor_id_chave_primaria_auditoria int8 NULL,
	endereco_ip_auditoria varchar(50) NULL
);

-- Permissions

ALTER TABLE chatbot.auditoria OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.auditoria TO u_znz1rkducdgumst;


-- chatbot.auditoria_campo definition

-- Drop table

-- DROP TABLE chatbot.auditoria_campo;

CREATE TABLE chatbot.auditoria_campo (
	id_auditoria_campo bigserial NOT NULL,
	id_auditoria int8 NULL,
	nome_campo varchar(100) NULL,
	valor_anterior text NULL,
	valor_atual text NULL
);

-- Permissions

ALTER TABLE chatbot.auditoria_campo OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.auditoria_campo TO u_znz1rkducdgumst;


-- chatbot.configuracao definition

-- Drop table

-- DROP TABLE chatbot.configuracao;

CREATE TABLE chatbot.configuracao (
	id_configuracao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	servidor_smtp varchar(60) NULL,
	usuario_smtp varchar(60) NULL,
	senha_smtp varchar(60) NULL,
	assunto varchar(100) NULL,
	remetente varchar(60) NULL,
	msg_envio_senha text NULL,
	url_saida varchar(255) NULL,
	diretorio_pdf varchar(255) NULL,
	diretorio_exportacao varchar(255) NULL,
	diretorio_arquivo varchar(255) NULL,
	cliente_ativo bpchar(1) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.configuracao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.configuracao TO u_znz1rkducdgumst;


-- chatbot.dialogo definition

-- Drop table

-- DROP TABLE chatbot.dialogo;

CREATE TABLE chatbot.dialogo (
	id_dialogo bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario int8 NULL,
	data_hora_mensagem timestamp NULL,
	mensagem text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	direcao varchar(1) NULL,
	mensagem_embbed _float4 NULL,
	ordem int4 NULL,
	id_sessao int8 NULL
);

-- Permissions

ALTER TABLE chatbot.dialogo OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.dialogo TO u_znz1rkducdgumst;


-- chatbot.dialogo_sessao definition

-- Drop table

-- DROP TABLE chatbot.dialogo_sessao;

CREATE TABLE chatbot.dialogo_sessao (
	id_dialogo_sessao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_agente int8 NULL,
	id_usuario int8 NULL,
	data_hora_conversa timestamp NULL,
	sumario text NULL,
	sumario_integrado float8 NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.dialogo_sessao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.dialogo_sessao TO u_znz1rkducdgumst;


-- chatbot.grupo_documento definition

-- Drop table

-- DROP TABLE chatbot.grupo_documento;

CREATE TABLE chatbot.grupo_documento (
	id_grupo_documento bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.grupo_documento OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.grupo_documento TO u_znz1rkducdgumst;


-- chatbot.grupo_usuario definition

-- Drop table

-- DROP TABLE chatbot.grupo_usuario;

CREATE TABLE chatbot.grupo_usuario (
	id_grupo_usuario bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.grupo_usuario OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.grupo_usuario TO u_znz1rkducdgumst;


-- chatbot.grupo_usuario_aplicacao definition

-- Drop table

-- DROP TABLE chatbot.grupo_usuario_aplicacao;

CREATE TABLE chatbot.grupo_usuario_aplicacao (
	id_grupo_usuario_aplicacao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_grupo_usuario int8 NULL,
	id_aplicacao int8 NULL,
	id_usuario_auditoria int8 NULL,
	consulta varchar(3) NULL,
	inclusao varchar(3) NULL,
	exclusao varchar(3) NULL,
	alteracao varchar(3) NULL,
	exportacao varchar(3) NULL,
	impressao varchar(3) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.grupo_usuario_aplicacao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.grupo_usuario_aplicacao TO u_znz1rkducdgumst;


-- chatbot.pessoa definition

-- Drop table

-- DROP TABLE chatbot.pessoa;

CREATE TABLE chatbot.pessoa (
	id_pessoa bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_situacao_pessoa int8 NULL,
	id_usuario_auditoria int8 NULL,
	tipo_pessoa bpchar(1) NULL,
	razao_social varchar(255) NULL,
	nome_fantasia varchar(255) NULL,
	documento_identificacao varchar(14) NULL,
	email varchar(100) NULL,
	observacoes text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.pessoa OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.pessoa TO u_znz1rkducdgumst;


-- chatbot.pessoa_comunicacao definition

-- Drop table

-- DROP TABLE chatbot.pessoa_comunicacao;

CREATE TABLE chatbot.pessoa_comunicacao (
	id_pessoa_comunicacao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_pessoa int8 NULL,
	id_tipo_comunicacao int8 NULL,
	id_usuario_auditoria int8 NULL,
	data_hora_comunicacao timestamp NULL,
	data_hora_inclusao timestamp NULL,
	assunto varchar(255) NULL,
	nome_arquivo varchar(255) NULL,
	nome_referencia varchar(255) NULL,
	obervacoes text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.pessoa_comunicacao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.pessoa_comunicacao TO u_znz1rkducdgumst;


-- chatbot.pessoa_contato definition

-- Drop table

-- DROP TABLE chatbot.pessoa_contato;

CREATE TABLE chatbot.pessoa_contato (
	id_pessoa_contato bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_pessoa int8 NULL,
	id_tipo_parentesco int8 NULL,
	id_usuario_auditoria int8 NULL,
	nome varchar(255) NULL,
	telefone varchar(50) NULL,
	celular varchar(50) NULL,
	email varchar(100) NULL,
	obervacoes text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.pessoa_contato OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.pessoa_contato TO u_znz1rkducdgumst;


-- chatbot.pessoa_documento definition

-- Drop table

-- DROP TABLE chatbot.pessoa_documento;

CREATE TABLE chatbot.pessoa_documento (
	id_pessoa_documento bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_pessoa int8 NULL,
	id_tipo_documento_pessoa int8 NULL,
	id_usuario_auditoria int8 NULL,
	numero varchar(255) NULL,
	obervacoes text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.pessoa_documento OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.pessoa_documento TO u_znz1rkducdgumst;


-- chatbot.pessoa_endereco definition

-- Drop table

-- DROP TABLE chatbot.pessoa_endereco;

CREATE TABLE chatbot.pessoa_endereco (
	id_pessoa_endereco bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_pessoa int8 NULL,
	id_tipo_endereco int8 NULL,
	id_usuario_auditoria int8 NULL,
	cep varchar(8) NULL,
	tipo_logradouro varchar(100) NULL,
	logradouro varchar(100) NULL,
	numero varchar(100) NULL,
	complemento varchar(100) NULL,
	bairro varchar(100) NULL,
	cidade varchar(100) NULL,
	estado bpchar(2) NULL,
	referencia text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.pessoa_endereco OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.pessoa_endereco TO u_znz1rkducdgumst;


-- chatbot.sessao definition

-- Drop table

-- DROP TABLE chatbot.sessao;

CREATE TABLE chatbot.sessao (
	id_sessao int8 default nextval('chatbot.sessao_id_sessao_seq') NOT NULL,
	id_tenacidade int8 NULL,
	id_agente_inferencia int8 NULL,
	id_usuario int8 NULL,
	data_hora_conversa timestamp NULL,
	sumario text NULL,
	sumario_integrado float8 NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	id_agente_sumario int8 NULL,
	id_agente_embed int8 NULL,
	ultima_ordem int4 NULL
);

-- Permissions

ALTER TABLE chatbot.sessao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.sessao TO u_znz1rkducdgumst;


-- chatbot.situacao_pessoa definition

-- Drop table

-- DROP TABLE chatbot.situacao_pessoa;

CREATE TABLE chatbot.situacao_pessoa (
	id_situacao_pessoa bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NOT NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.situacao_pessoa OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.situacao_pessoa TO u_znz1rkducdgumst;


-- chatbot.tenacidade definition

-- Drop table

-- DROP TABLE chatbot.tenacidade;

CREATE TABLE chatbot.tenacidade (
	id_tenacidade bigserial NOT NULL,
	id_pessoa int8 NULL,
	id_usuario_auditoria int8 NULL,
	chave_acesso varchar(255) NULL,
	data_expiracao timestamp NULL,
	ativo bpchar(1) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tenacidade OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tenacidade TO u_znz1rkducdgumst;


-- chatbot.teste definition

-- Drop table

-- DROP TABLE chatbot.teste;

CREATE TABLE chatbot.teste (
	texto text NULL
);

-- Permissions

ALTER TABLE chatbot.teste OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.teste TO u_znz1rkducdgumst;


-- chatbot.tipo_comunicacao definition

-- Drop table

-- DROP TABLE chatbot.tipo_comunicacao;

CREATE TABLE chatbot.tipo_comunicacao (
	id_tipo_comunicacao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_comunicacao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_comunicacao TO u_znz1rkducdgumst;


-- chatbot.tipo_documento_arquivo definition

-- Drop table

-- DROP TABLE chatbot.tipo_documento_arquivo;

CREATE TABLE chatbot.tipo_documento_arquivo (
	id_tipo_documento_arquivo bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_documento_arquivo OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_documento_arquivo TO u_znz1rkducdgumst;


-- chatbot.tipo_documento_pessoa definition

-- Drop table

-- DROP TABLE chatbot.tipo_documento_pessoa;

CREATE TABLE chatbot.tipo_documento_pessoa (
	id_tipo_documento_pessoa bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_documento_pessoa OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_documento_pessoa TO u_znz1rkducdgumst;


-- chatbot.tipo_endereco definition

-- Drop table

-- DROP TABLE chatbot.tipo_endereco;

CREATE TABLE chatbot.tipo_endereco (
	id_tipo_endereco bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_endereco OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_endereco TO u_znz1rkducdgumst;


-- chatbot.tipo_parentesco definition

-- Drop table

-- DROP TABLE chatbot.tipo_parentesco;

CREATE TABLE chatbot.tipo_parentesco (
	id_tipo_parentesco bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_parentesco OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_parentesco TO u_znz1rkducdgumst;


-- chatbot.tipo_telefone definition

-- Drop table

-- DROP TABLE chatbot.tipo_telefone;

CREATE TABLE chatbot.tipo_telefone (
	id_tipo_telefone bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tipo_telefone OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tipo_telefone TO u_znz1rkducdgumst;


-- chatbot.tmp_mensagem definition

-- Drop table

-- DROP TABLE chatbot.tmp_mensagem;

CREATE TABLE chatbot.tmp_mensagem (
	id_mensagem bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario int8 NULL,
	data_hora timestamp NULL,
	mensagem varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.tmp_mensagem OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tmp_mensagem TO u_znz1rkducdgumst;


-- chatbot.tmp_tabela definition

-- Drop table

-- DROP TABLE chatbot.tmp_tabela;

CREATE TABLE chatbot.tmp_tabela (
	id_tabela bigserial NOT NULL,
	id_usuario int8 NULL,
	nome_banco varchar(100) NULL,
	nome_tabela varchar(100) NULL,
	chave_primaria varchar(100) NULL
);

-- Permissions

ALTER TABLE chatbot.tmp_tabela OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tmp_tabela TO u_znz1rkducdgumst;


-- chatbot.tmp_tabela_trigger definition

-- Drop table

-- DROP TABLE chatbot.tmp_tabela_trigger;

CREATE TABLE chatbot.tmp_tabela_trigger (
	id_tabela_trigger bigserial NOT NULL,
	id_tabela_trigger_execucao int8 NULL,
	id_tabela int8 NULL,
	id_usuario int8 NULL,
	uniq_id varchar(50) NULL,
	nome_trigger varchar(100) NULL,
	evento varchar(20) NULL,
	data_hora_inclusao timestamp NULL,
	mensagem varchar(100) NULL,
	script_trigger text NULL
);

-- Permissions

ALTER TABLE chatbot.tmp_tabela_trigger OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tmp_tabela_trigger TO u_znz1rkducdgumst;


-- chatbot.tmp_tabela_trigger_execucao definition

-- Drop table

-- DROP TABLE chatbot.tmp_tabela_trigger_execucao;

CREATE TABLE chatbot.tmp_tabela_trigger_execucao (
	id_tabela_trigger_execucao bigserial NOT NULL,
	id_usuario int8 NULL,
	data_hora_inicio timestamp NULL,
	data_hora_fim timestamp NULL,
	qtd_tabelas int2 NULL,
	qtd_triggers int2 NULL,
	mensagem text NULL,
	uniq_id varchar(50) NULL
);

-- Permissions

ALTER TABLE chatbot.tmp_tabela_trigger_execucao OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.tmp_tabela_trigger_execucao TO u_znz1rkducdgumst;


-- chatbot.usuario definition

-- Drop table

-- DROP TABLE chatbot.usuario;

CREATE TABLE chatbot.usuario (
	id_usuario bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	nome varchar(100) NULL,
	login varchar(32) NULL,
	senha varchar(32) NULL,
	email varchar(100) NULL,
	ativo varchar(3) NULL,
	data_ativacao timestamp NULL,
	codigo_ativacao varchar(32) NULL,
	administrador varchar(3) NULL,
	acesso_auditoria varchar(1) NULL,
	acesso_autorizacoes varchar(1) NULL,
	lista_empresa varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.usuario OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.usuario TO u_znz1rkducdgumst;


-- chatbot.usuario_grupo_usuario definition

-- Drop table

-- DROP TABLE chatbot.usuario_grupo_usuario;

CREATE TABLE chatbot.usuario_grupo_usuario (
	id_usuario_grupo_usuario bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario int8 NULL,
	id_grupo_usuario int8 NULL,
	id_usuario_auditoria int8 NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.usuario_grupo_usuario OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.usuario_grupo_usuario TO u_znz1rkducdgumst;


-- chatbot.arquivo_parte_usuario definition

-- Drop table

-- DROP TABLE chatbot.arquivo_parte_usuario;

CREATE TABLE chatbot.arquivo_parte_usuario (
	id_arquivo_parte_usuario bigserial NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_arquivo_usuario int8 NOT NULL,
	sequencial int4 NOT NULL,
	parte text NOT NULL,
	embed _float4 NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL
);

-- Permissions

ALTER TABLE chatbot.arquivo_parte_usuario OWNER TO u_znz1rkducdgumst;
GRANT ALL ON TABLE chatbot.arquivo_parte_usuario TO u_znz1rkducdgumst;