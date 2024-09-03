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
	situacao varchar(1) NULL,
	CONSTRAINT aplicacao_sync_pk PRIMARY KEY (id_aplicacao_sync)
);


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT aplicacao_pk PRIMARY KEY (id_aplicacao)
);


-- chatbot.arquivo_parte_usuario definition

-- Drop table

-- DROP TABLE chatbot.arquivo_parte_usuario;

CREATE TABLE chatbot.arquivo_parte_usuario (
	id_arquivo_parte_usuario int8 DEFAULT nextval('arquivo_usuario_parte_id_arquivo_usuario_parte_seq'::regclass) NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_arquivo_usuario int8 NOT NULL,
	id_usuario_auditoria int8 NOT NULL,
	texto text NOT NULL,
	endereco_ip_auditoria varchar(50) NOT NULL,
	nome_aplicacao_auditoria varchar(255) NOT NULL,
	parte text NOT NULL,
	embed _float4 NOT NULL,
	CONSTRAINT arquivo_usuario_parte_pk PRIMARY KEY (id_arquivo_parte_usuario)
);

-- Table Triggers

create trigger tr_arquivo_usuario_parte_ad after
delete
    on
    chatbot.arquivo_parte_usuario for each row execute function func_arquivo_usuario_parte_ad();
create trigger tr_arquivo_usuario_parte_ai after
insert
    on
    chatbot.arquivo_parte_usuario for each row execute function func_arquivo_usuario_parte_ai();
create trigger tr_arquivo_usuario_parte_au after
update
    on
    chatbot.arquivo_parte_usuario for each row execute function func_arquivo_usuario_parte_au();


-- chatbot.arquivo_usuario definition

-- Drop table

-- DROP TABLE chatbot.arquivo_usuario;

CREATE TABLE chatbot.arquivo_usuario (
	id_arquivo_usuario bigserial NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_usuario int8 NOT NULL,
	id_usuario_auditoria int8 NOT NULL,
	texto text NOT NULL,
	endereco_ip_auditoria varchar(50) NOT NULL,
	nome_aplicacao_auditoria varchar(255) NOT NULL,
	CONSTRAINT arquivo_usuario_pk PRIMARY KEY (id_arquivo_usuario)
);

-- Table Triggers

create trigger tr_arquivo_usuario_ad after
delete
    on
    chatbot.arquivo_usuario for each row execute function func_arquivo_usuario_ad();
create trigger tr_arquivo_usuario_ai after
insert
    on
    chatbot.arquivo_usuario for each row execute function func_arquivo_usuario_ai();
create trigger tr_arquivo_usuario_au after
update
    on
    chatbot.arquivo_usuario for each row execute function func_arquivo_usuario_au();


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
	endereco_ip_auditoria varchar(50) NULL,
	CONSTRAINT auditoria_pk PRIMARY KEY (id_auditoria)
);


-- chatbot.auditoria_campo definition

-- Drop table

-- DROP TABLE chatbot.auditoria_campo;

CREATE TABLE chatbot.auditoria_campo (
	id_auditoria_campo bigserial NOT NULL,
	id_auditoria int8 NULL,
	nome_campo varchar(100) NULL,
	valor_anterior text NULL,
	valor_atual text NULL,
	CONSTRAINT auditoria_campo_pk PRIMARY KEY (id_auditoria_campo)
);


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT configuracao_pk PRIMARY KEY (id_configuracao)
);

-- Table Triggers

create trigger tr_configuracao_ad after
delete
    on
    chatbot.configuracao for each row execute function func_configuracao_ad();
create trigger tr_configuracao_ai after
insert
    on
    chatbot.configuracao for each row execute function func_configuracao_ai();
create trigger tr_configuracao_au after
update
    on
    chatbot.configuracao for each row execute function func_configuracao_au();


-- chatbot.grupo_documento definition

-- Drop table

-- DROP TABLE chatbot.grupo_documento;

CREATE TABLE chatbot.grupo_documento (
	id_grupo_documento bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT grupo_documento_pk PRIMARY KEY (id_grupo_documento)
);

-- Table Triggers

create trigger tr_grupo_documento_ad after
delete
    on
    chatbot.grupo_documento for each row execute function func_grupo_documento_ad();
create trigger tr_grupo_documento_ai after
insert
    on
    chatbot.grupo_documento for each row execute function func_grupo_documento_ai();
create trigger tr_grupo_documento_au after
update
    on
    chatbot.grupo_documento for each row execute function func_grupo_documento_au();


-- chatbot.grupo_usuario definition

-- Drop table

-- DROP TABLE chatbot.grupo_usuario;

CREATE TABLE chatbot.grupo_usuario (
	id_grupo_usuario bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT grupo_usuario_pk PRIMARY KEY (id_grupo_usuario)
);

-- Table Triggers

create trigger tr_grupo_usuario_ad after
delete
    on
    chatbot.grupo_usuario for each row execute function func_grupo_usuario_ad();
create trigger tr_grupo_usuario_ai after
insert
    on
    chatbot.grupo_usuario for each row execute function func_grupo_usuario_ai();
create trigger tr_grupo_usuario_au after
update
    on
    chatbot.grupo_usuario for each row execute function func_grupo_usuario_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT grupo_usuario_aplicacao_pk PRIMARY KEY (id_grupo_usuario_aplicacao)
);

-- Table Triggers

create trigger tr_grupo_usuario_aplicacao_ad after
delete
    on
    chatbot.grupo_usuario_aplicacao for each row execute function func_grupo_usuario_aplicacao_ad();
create trigger tr_grupo_usuario_aplicacao_ai after
insert
    on
    chatbot.grupo_usuario_aplicacao for each row execute function func_grupo_usuario_aplicacao_ai();
create trigger tr_grupo_usuario_aplicacao_au after
update
    on
    chatbot.grupo_usuario_aplicacao for each row execute function func_grupo_usuario_aplicacao_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT pessoa_pk PRIMARY KEY (id_pessoa)
);

-- Table Triggers

create trigger tr_pessoa_ad after
delete
    on
    chatbot.pessoa for each row execute function func_pessoa_ad();
create trigger tr_pessoa_ai after
insert
    on
    chatbot.pessoa for each row execute function func_pessoa_ai();
create trigger tr_pessoa_au after
update
    on
    chatbot.pessoa for each row execute function func_pessoa_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT pessoa_comunicacao_pk PRIMARY KEY (id_pessoa_comunicacao)
);

-- Table Triggers

create trigger tr_pessoa_comunicacao_ad after
delete
    on
    chatbot.pessoa_comunicacao for each row execute function func_pessoa_comunicacao_ad();
create trigger tr_pessoa_comunicacao_ai after
insert
    on
    chatbot.pessoa_comunicacao for each row execute function func_pessoa_comunicacao_ai();
create trigger tr_pessoa_comunicacao_au after
update
    on
    chatbot.pessoa_comunicacao for each row execute function func_pessoa_comunicacao_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT pessoa_contato_pk PRIMARY KEY (id_pessoa_contato)
);

-- Table Triggers

create trigger tr_pessoa_contato_ad after
delete
    on
    chatbot.pessoa_contato for each row execute function func_pessoa_contato_ad();
create trigger tr_pessoa_contato_ai after
insert
    on
    chatbot.pessoa_contato for each row execute function func_pessoa_contato_ai();
create trigger tr_pessoa_contato_au after
update
    on
    chatbot.pessoa_contato for each row execute function func_pessoa_contato_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT pessoa_documento_pk PRIMARY KEY (id_pessoa_documento)
);

-- Table Triggers

create trigger tr_pessoa_documento_ad after
delete
    on
    chatbot.pessoa_documento for each row execute function func_pessoa_documento_ad();
create trigger tr_pessoa_documento_ai after
insert
    on
    chatbot.pessoa_documento for each row execute function func_pessoa_documento_ai();
create trigger tr_pessoa_documento_au after
update
    on
    chatbot.pessoa_documento for each row execute function func_pessoa_documento_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT pessoa_endereco_pk PRIMARY KEY (id_pessoa_endereco)
);

-- Table Triggers

create trigger tr_pessoa_endereco_ad after
delete
    on
    chatbot.pessoa_endereco for each row execute function func_pessoa_endereco_ad();
create trigger tr_pessoa_endereco_ai after
insert
    on
    chatbot.pessoa_endereco for each row execute function func_pessoa_endereco_ai();
create trigger tr_pessoa_endereco_au after
update
    on
    chatbot.pessoa_endereco for each row execute function func_pessoa_endereco_au();


-- chatbot.situacao_pessoa definition

-- Drop table

-- DROP TABLE chatbot.situacao_pessoa;

CREATE TABLE chatbot.situacao_pessoa (
	id_situacao_pessoa bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NOT NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT situacao_pessoa_pk PRIMARY KEY (id_situacao_pessoa)
);

-- Table Triggers

create trigger tr_situacao_pessoa_ad after
delete
    on
    chatbot.situacao_pessoa for each row execute function func_situacao_pessoa_ad();
create trigger tr_situacao_pessoa_ai after
insert
    on
    chatbot.situacao_pessoa for each row execute function func_situacao_pessoa_ai();
create trigger tr_situacao_pessoa_au after
update
    on
    chatbot.situacao_pessoa for each row execute function func_situacao_pessoa_au();


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tenacidade_pk PRIMARY KEY (id_tenacidade)
);

-- Table Triggers

create trigger tr_tenacidade_ad after
delete
    on
    chatbot.tenacidade for each row execute function func_tenacidade_ad();
create trigger tr_tenacidade_ai after
insert
    on
    chatbot.tenacidade for each row execute function func_tenacidade_ai();
create trigger tr_tenacidade_au after
update
    on
    chatbot.tenacidade for each row execute function func_tenacidade_au();


-- chatbot.tipo_comunicacao definition

-- Drop table

-- DROP TABLE chatbot.tipo_comunicacao;

CREATE TABLE chatbot.tipo_comunicacao (
	id_tipo_comunicacao bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_comunicacao_pk PRIMARY KEY (id_tipo_comunicacao)
);

-- Table Triggers

create trigger tr_tipo_comunicacao_ad after
delete
    on
    chatbot.tipo_comunicacao for each row execute function func_tipo_comunicacao_ad();
create trigger tr_tipo_comunicacao_ai after
insert
    on
    chatbot.tipo_comunicacao for each row execute function func_tipo_comunicacao_ai();
create trigger tr_tipo_comunicacao_au after
update
    on
    chatbot.tipo_comunicacao for each row execute function func_tipo_comunicacao_au();


-- chatbot.tipo_documento_arquivo definition

-- Drop table

-- DROP TABLE chatbot.tipo_documento_arquivo;

CREATE TABLE chatbot.tipo_documento_arquivo (
	id_tipo_documento_arquivo bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_documento_arquivo_pk PRIMARY KEY (id_tipo_documento_arquivo)
);

-- Table Triggers

create trigger tr_tipo_documento_arquivo_ad after
delete
    on
    chatbot.tipo_documento_arquivo for each row execute function func_tipo_documento_arquivo_ad();
create trigger tr_tipo_documento_arquivo_ai after
insert
    on
    chatbot.tipo_documento_arquivo for each row execute function func_tipo_documento_arquivo_ai();
create trigger tr_tipo_documento_arquivo_au after
update
    on
    chatbot.tipo_documento_arquivo for each row execute function func_tipo_documento_arquivo_au();


-- chatbot.tipo_documento_pessoa definition

-- Drop table

-- DROP TABLE chatbot.tipo_documento_pessoa;

CREATE TABLE chatbot.tipo_documento_pessoa (
	id_tipo_documento_pessoa bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_documento_pessoa_pk PRIMARY KEY (id_tipo_documento_pessoa)
);

-- Table Triggers

create trigger tr_tipo_documento_pessoa_ad after
delete
    on
    chatbot.tipo_documento_pessoa for each row execute function func_tipo_documento_pessoa_ad();
create trigger tr_tipo_documento_pessoa_ai after
insert
    on
    chatbot.tipo_documento_pessoa for each row execute function func_tipo_documento_pessoa_ai();
create trigger tr_tipo_documento_pessoa_au after
update
    on
    chatbot.tipo_documento_pessoa for each row execute function func_tipo_documento_pessoa_au();


-- chatbot.tipo_endereco definition

-- Drop table

-- DROP TABLE chatbot.tipo_endereco;

CREATE TABLE chatbot.tipo_endereco (
	id_tipo_endereco bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_endereco_pk PRIMARY KEY (id_tipo_endereco)
);

-- Table Triggers

create trigger tr_tipo_endereco_ai after
insert
    on
    chatbot.tipo_endereco for each row execute function func_tipo_endereco_ai();
create trigger tr_tipo_endereco_ad after
delete
    on
    chatbot.tipo_endereco for each row execute function func_tipo_endereco_ad();
create trigger tr_tipo_endereco_au after
update
    on
    chatbot.tipo_endereco for each row execute function func_tipo_endereco_au();


-- chatbot.tipo_parentesco definition

-- Drop table

-- DROP TABLE chatbot.tipo_parentesco;

CREATE TABLE chatbot.tipo_parentesco (
	id_tipo_parentesco bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_parentesco_pk PRIMARY KEY (id_tipo_parentesco)
);

-- Table Triggers

create trigger tr_tipo_parentesco_ad after
delete
    on
    chatbot.tipo_parentesco for each row execute function func_tipo_parentesco_ad();
create trigger tr_tipo_parentesco_ai after
insert
    on
    chatbot.tipo_parentesco for each row execute function func_tipo_parentesco_ai();
create trigger tr_tipo_parentesco_au after
update
    on
    chatbot.tipo_parentesco for each row execute function func_tipo_parentesco_au();


-- chatbot.tipo_telefone definition

-- Drop table

-- DROP TABLE chatbot.tipo_telefone;

CREATE TABLE chatbot.tipo_telefone (
	id_tipo_telefone bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	descricao varchar(255) NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT tipo_telefone_pk PRIMARY KEY (id_tipo_telefone)
);

-- Table Triggers

create trigger tr_tipo_telefone_ad after
delete
    on
    chatbot.tipo_telefone for each row execute function func_tipo_telefone_ad();
create trigger tr_tipo_telefone_ai after
insert
    on
    chatbot.tipo_telefone for each row execute function func_tipo_telefone_ai();
create trigger tr_tipo_telefone_au after
update
    on
    chatbot.tipo_telefone for each row execute function func_tipo_telefone_au();


-- chatbot.tmp_mensagem definition

-- Drop table

-- DROP TABLE chatbot.tmp_mensagem;

CREATE TABLE chatbot.tmp_mensagem (
	id_tmp_mensagem bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario int8 NULL,
	data_hora timestamp NULL,
	mensagem varchar(255) NULL,
	CONSTRAINT tmp_mensagem_pk PRIMARY KEY (id_tmp_mensagem)
);


-- chatbot.tmp_tabela definition

-- Drop table

-- DROP TABLE chatbot.tmp_tabela;

CREATE TABLE chatbot.tmp_tabela (
	id_tmp_tabela bigserial NOT NULL,
	id_tabela_trigger_execucao int8 NULL,
	id_usuario int8 NULL,
	nome_banco varchar(100) NULL,
	nome_tabela varchar(100) NULL,
	chave_primaria varchar(100) NULL,
	CONSTRAINT tmp_tabela_pk PRIMARY KEY (id_tmp_tabela)
);


-- chatbot.tmp_tabela_trigger definition

-- Drop table

-- DROP TABLE chatbot.tmp_tabela_trigger;

CREATE TABLE chatbot.tmp_tabela_trigger (
	id_tmp_tabela_trigger bigserial NOT NULL,
	id_tabela_trigger_execucao int8 NULL,
	id_tmp_tabela int8 NULL,
	id_usuario int8 NULL,
	nome_trigger varchar(100) NULL,
	evento varchar(20) NULL,
	data_hora_inclusao timestamp NULL,
	mensagem varchar(100) NULL,
	script_trigger text NULL,
	CONSTRAINT tmp_tabela_trigger_pk PRIMARY KEY (id_tmp_tabela_trigger)
);
CREATE INDEX tmp_tabela_trigger_evento_idx ON chatbot.tmp_tabela_trigger USING btree (evento);
CREATE INDEX tmp_tabela_trigger_id_tabela_trigger_execucao_idx ON chatbot.tmp_tabela_trigger USING btree (id_tabela_trigger_execucao);
CREATE INDEX tmp_tabela_trigger_id_tmp_tabela_idx ON chatbot.tmp_tabela_trigger USING btree (id_tmp_tabela);
CREATE INDEX tmp_tabela_trigger_id_usuario_idx ON chatbot.tmp_tabela_trigger USING btree (id_usuario);


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
	CONSTRAINT tmp_tabela_trigger_execucao_pk PRIMARY KEY (id_tabela_trigger_execucao)
);


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
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT usuario_grupo_usuario_pk PRIMARY KEY (id_usuario_grupo_usuario)
);

-- Table Triggers

create trigger tr_usuario_grupo_usuario_ad after
delete
    on
    chatbot.usuario_grupo_usuario for each row execute function func_usuario_grupo_usuario_ad();
create trigger tr_usuario_grupo_usuario_ai after
insert
    on
    chatbot.usuario_grupo_usuario for each row execute function func_usuario_grupo_usuario_ai();
create trigger tr_usuario_grupo_usuario_au after
update
    on
    chatbot.usuario_grupo_usuario for each row execute function func_usuario_grupo_usuario_au();


-- chatbot.aplicacao foreign keys

ALTER TABLE chatbot.aplicacao ADD CONSTRAINT aplicacao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.aplicacao ADD CONSTRAINT aplicacao_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.arquivo_parte_usuario foreign keys

ALTER TABLE chatbot.arquivo_parte_usuario ADD CONSTRAINT arquivo_usuario_parte_arquivo_usuario_fk FOREIGN KEY (id_arquivo_usuario) REFERENCES chatbot.arquivo_usuario(id_arquivo_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_parte_usuario ADD CONSTRAINT arquivo_usuario_parte_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_parte_usuario ADD CONSTRAINT arquivo_usuario_parte_usuario_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.arquivo_usuario foreign keys

ALTER TABLE chatbot.arquivo_usuario ADD CONSTRAINT arquivo_usuario_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_usuario ADD CONSTRAINT arquivo_usuario_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_usuario ADD CONSTRAINT arquivo_usuario_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.auditoria foreign keys

ALTER TABLE chatbot.auditoria ADD CONSTRAINT auditoria_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.auditoria ADD CONSTRAINT auditoria_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.auditoria_campo foreign keys

ALTER TABLE chatbot.auditoria_campo ADD CONSTRAINT auditoria_campo_auditoria_fk FOREIGN KEY (id_auditoria) REFERENCES chatbot.auditoria(id_auditoria) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.configuracao foreign keys

ALTER TABLE chatbot.configuracao ADD CONSTRAINT configuracao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.configuracao ADD CONSTRAINT configuracao_usuario_auiditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.grupo_documento foreign keys

ALTER TABLE chatbot.grupo_documento ADD CONSTRAINT grupo_documento_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.grupo_documento ADD CONSTRAINT grupo_documento_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.grupo_usuario foreign keys

ALTER TABLE chatbot.grupo_usuario ADD CONSTRAINT grupo_usuario_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.grupo_usuario ADD CONSTRAINT grupo_usuario_usuario_auditoriafk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.grupo_usuario_aplicacao foreign keys

ALTER TABLE chatbot.grupo_usuario_aplicacao ADD CONSTRAINT grupo_usuario_aplicacao_aplicacao_fk FOREIGN KEY (id_aplicacao) REFERENCES chatbot.aplicacao(id_aplicacao) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.grupo_usuario_aplicacao ADD CONSTRAINT grupo_usuario_aplicacao_grupo_usuario_fk FOREIGN KEY (id_grupo_usuario) REFERENCES chatbot.grupo_usuario(id_grupo_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.grupo_usuario_aplicacao ADD CONSTRAINT grupo_usuario_aplicacao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.grupo_usuario_aplicacao ADD CONSTRAINT grupo_usuario_aplicacao_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.pessoa foreign keys

ALTER TABLE chatbot.pessoa ADD CONSTRAINT pessoa_situacao_pessoa_fk FOREIGN KEY (id_situacao_pessoa) REFERENCES chatbot.situacao_pessoa(id_situacao_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa ADD CONSTRAINT pessoa_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa ADD CONSTRAINT pessoa_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.pessoa_comunicacao foreign keys

ALTER TABLE chatbot.pessoa_comunicacao ADD CONSTRAINT pessoa_comunicacao_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_comunicacao ADD CONSTRAINT pessoa_comunicacao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_comunicacao ADD CONSTRAINT pessoa_comunicacao_tipo_comunicacao_fk FOREIGN KEY (id_tipo_comunicacao) REFERENCES chatbot.tipo_comunicacao(id_tipo_comunicacao) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_comunicacao ADD CONSTRAINT pessoa_comunicacao_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.pessoa_contato foreign keys

ALTER TABLE chatbot.pessoa_contato ADD CONSTRAINT pessoa_contato_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_contato ADD CONSTRAINT pessoa_contato_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_contato ADD CONSTRAINT pessoa_contato_tipo_parentesco_fk FOREIGN KEY (id_tipo_parentesco) REFERENCES chatbot.tipo_parentesco(id_tipo_parentesco) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_contato ADD CONSTRAINT pessoa_contato_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.pessoa_documento foreign keys

ALTER TABLE chatbot.pessoa_documento ADD CONSTRAINT pessoa_documento_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_documento ADD CONSTRAINT pessoa_documento_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_documento ADD CONSTRAINT pessoa_documento_tipo_documento_pessoa_fk FOREIGN KEY (id_tipo_documento_pessoa) REFERENCES chatbot.tipo_documento_pessoa(id_tipo_documento_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_documento ADD CONSTRAINT pessoa_documento_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.pessoa_endereco foreign keys

ALTER TABLE chatbot.pessoa_endereco ADD CONSTRAINT pessoa_endereco_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_endereco ADD CONSTRAINT pessoa_endereco_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_endereco ADD CONSTRAINT pessoa_endereco_tipo_endereco_fk FOREIGN KEY (id_tipo_endereco) REFERENCES chatbot.tipo_endereco(id_tipo_endereco) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.pessoa_endereco ADD CONSTRAINT pessoa_endereco_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.situacao_pessoa foreign keys

ALTER TABLE chatbot.situacao_pessoa ADD CONSTRAINT situacao_pessoa_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.situacao_pessoa ADD CONSTRAINT situacao_pessoa_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tenacidade foreign keys

ALTER TABLE chatbot.tenacidade ADD CONSTRAINT tenacidade_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_comunicacao foreign keys

ALTER TABLE chatbot.tipo_comunicacao ADD CONSTRAINT tipo_comunicacao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_comunicacao ADD CONSTRAINT tipo_comunicacao_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_documento_arquivo foreign keys

ALTER TABLE chatbot.tipo_documento_arquivo ADD CONSTRAINT tipo_documento_arquivo_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_documento_arquivo ADD CONSTRAINT tipo_documento_arquivo_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_documento_pessoa foreign keys

ALTER TABLE chatbot.tipo_documento_pessoa ADD CONSTRAINT tipo_documento_pessoa_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_documento_pessoa ADD CONSTRAINT tipo_documento_pessoa_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_endereco foreign keys

ALTER TABLE chatbot.tipo_endereco ADD CONSTRAINT tipo_endereco_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_endereco ADD CONSTRAINT tipo_endereco_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_parentesco foreign keys

ALTER TABLE chatbot.tipo_parentesco ADD CONSTRAINT tipo_parentesco_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_parentesco ADD CONSTRAINT tipo_parentesco_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tipo_telefone foreign keys

ALTER TABLE chatbot.tipo_telefone ADD CONSTRAINT tipo_telefone_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tipo_telefone ADD CONSTRAINT tipo_telefone_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tmp_mensagem foreign keys

ALTER TABLE chatbot.tmp_mensagem ADD CONSTRAINT tmp_mensagem_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tmp_mensagem ADD CONSTRAINT tmp_mensagem_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tmp_tabela foreign keys

ALTER TABLE chatbot.tmp_tabela ADD CONSTRAINT tmp_tabela_tmp_tabela_trigger_execucao_fk FOREIGN KEY (id_tabela_trigger_execucao) REFERENCES chatbot.tmp_tabela_trigger_execucao(id_tabela_trigger_execucao) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tmp_tabela ADD CONSTRAINT tmp_tabela_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tmp_tabela_trigger foreign keys

ALTER TABLE chatbot.tmp_tabela_trigger ADD CONSTRAINT tmp_tabela_trigger_tmp_tabela_fk FOREIGN KEY (id_tmp_tabela) REFERENCES chatbot.tmp_tabela(id_tmp_tabela) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tmp_tabela_trigger ADD CONSTRAINT tmp_tabela_trigger_tmp_tabela_trigger_execucao_fk FOREIGN KEY (id_tabela_trigger_execucao) REFERENCES chatbot.tmp_tabela_trigger_execucao(id_tabela_trigger_execucao) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.tmp_tabela_trigger ADD CONSTRAINT tmp_tabela_trigger_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.tmp_tabela_trigger_execucao foreign keys

ALTER TABLE chatbot.tmp_tabela_trigger_execucao ADD CONSTRAINT tmp_tabela_trigger_execucao_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.usuario_grupo_usuario foreign keys

ALTER TABLE chatbot.usuario_grupo_usuario ADD CONSTRAINT usuario_grupo_usuario_grupo_usuario_fk FOREIGN KEY (id_grupo_usuario) REFERENCES chatbot.grupo_usuario(id_grupo_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.usuario_grupo_usuario ADD CONSTRAINT usuario_grupo_usuario_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.usuario_grupo_usuario ADD CONSTRAINT usuario_grupo_usuario_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.usuario_grupo_usuario ADD CONSTRAINT usuario_grupo_usuario_usuario_fk FOREIGN KEY (id_usuario) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;