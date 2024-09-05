-- chatbot.agente definition

-- Drop table

-- DROP TABLE chatbot.agente;

CREATE TABLE chatbot.agente (
	id_agente bigserial NOT NULL,
	id_tenacidade int8 NULL,
	id_usuario_auditoria int8 NULL,
	nome varchar(255) NULL,
	modelo varchar(255) NULL,
	prompt_modelo text NULL,
	prompt_modelo_sistema text NULL,
	tipo_modelo varchar(50) NULL,
	tarefa varchar(100) NULL,
	modelo_prompt_dialogo_u text NULL,
	modelo_prompt_dialogo_a text NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT agente_pk PRIMARY KEY (id_agente)
);

-- Table Triggers

create trigger tr_agente_ad after
delete
    on
    chatbot.agente for each row execute function func_agente_ad();
create trigger tr_agente_ai after
insert
    on
    chatbot.agente for each row execute function func_agente_ai();
create trigger tr_agente_au after
update
    on
    chatbot.agente for each row execute function func_agente_au();


-- chatbot.arquivo definition

-- Drop table

-- DROP TABLE chatbot.arquivo;

CREATE TABLE chatbot.arquivo (
	id_arquivo bigserial NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_usuario_auditoria int8 NULL,
	texto text NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	selecionar int4 NULL,
	descricao varchar(255) NULL,
	nome_arquivo varchar(255) NULL,
	id_pessoa int8 NULL,
	CONSTRAINT arquivo_pk PRIMARY KEY (id_arquivo)
);


-- chatbot.arquivo_parte definition

-- Drop table

-- DROP TABLE chatbot.arquivo_parte;

CREATE TABLE chatbot.arquivo_parte (
	id_arquivo_parte int8 DEFAULT nextval('arquivo_parten_id_arquivo_parte_seq'::regclass) NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_arquivo int8 NOT NULL,
	id_usuario_auditoria int8 NULL,
	sequencial int4 NOT NULL,
	parte text NOT NULL,
	embed _float4 NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	CONSTRAINT arquivo_parte_pk PRIMARY KEY (id_arquivo_parte)
);


-- chatbot.dialogo definition

-- Drop table

-- DROP TABLE chatbot.dialogo;

CREATE TABLE chatbot.dialogo (
	id_dialogo int8 DEFAULT nextval('dialogon_id_dialogo_seq'::regclass) NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_sessao int8 NOT NULL,
	id_usuario_auditoria int8 NULL,
	data_hora_mensagem timestamp NOT NULL,
	mensagem text NULL,
	mensagem_texto text NULL,
	direcao varchar(1) NOT NULL,
	mensagem_embbed _float4 NULL,
	ordem int4 NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	id_pessoa int8 NULL,
	CONSTRAINT dialogo_pk PRIMARY KEY (id_dialogo)
);


-- chatbot.sessao definition

-- Drop table

-- DROP TABLE chatbot.sessao;

CREATE TABLE chatbot.sessao (
	id_sessao int8 DEFAULT nextval('sessaon_id_sessao_seq'::regclass) NOT NULL,
	id_tenacidade int8 NOT NULL,
	id_agente_inferencia int8 NOT NULL,
	id_agente_embed int8 NOT NULL,
	id_usuario_auditoria int8 NULL,
	data_hora_conversa timestamp NOT NULL,
	ultima_ordem int4 NOT NULL,
	endereco_ip_auditoria varchar(50) NULL,
	nome_aplicacao_auditoria varchar(255) NULL,
	id_pessoa int8 NULL,
	CONSTRAINT sessao_pk PRIMARY KEY (id_sessao)
);


-- chatbot.agente foreign keys

ALTER TABLE chatbot.agente ADD CONSTRAINT agente_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.agente ADD CONSTRAINT agente_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.arquivo foreign keys

ALTER TABLE chatbot.arquivo ADD CONSTRAINT arquivo_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa);
ALTER TABLE chatbot.arquivo ADD CONSTRAINT arquivo_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo ADD CONSTRAINT arquivo_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.arquivo_parte foreign keys

ALTER TABLE chatbot.arquivo_parte ADD CONSTRAINT arquivo_parte_arquivo_fk FOREIGN KEY (id_arquivo) REFERENCES chatbot.arquivo(id_arquivo) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_parte ADD CONSTRAINT arquivo_parte_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.arquivo_parte ADD CONSTRAINT arquivo_parte_usuario_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.dialogo foreign keys

ALTER TABLE chatbot.dialogo ADD CONSTRAINT dialogo_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa);
ALTER TABLE chatbot.dialogo ADD CONSTRAINT dialogo_sessao_fk FOREIGN KEY (id_sessao) REFERENCES chatbot.sessao(id_sessao) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.dialogo ADD CONSTRAINT dialogo_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.dialogo ADD CONSTRAINT dialogo_usuario_auditoria_fk FOREIGN KEY (id_usuario_auditoria) REFERENCES chatbot.usuario(id_usuario) ON DELETE RESTRICT ON UPDATE RESTRICT;


-- chatbot.sessao foreign keys

ALTER TABLE chatbot.sessao ADD CONSTRAINT sessao_agente_inferencia_fk FOREIGN KEY (id_agente_inferencia) REFERENCES chatbot.agente(id_agente) ON DELETE RESTRICT ON UPDATE RESTRICT;
ALTER TABLE chatbot.sessao ADD CONSTRAINT sessao_pessoa_fk FOREIGN KEY (id_pessoa) REFERENCES chatbot.pessoa(id_pessoa);
ALTER TABLE chatbot.sessao ADD CONSTRAINT sessao_tenacidade_fk FOREIGN KEY (id_tenacidade) REFERENCES chatbot.tenacidade(id_tenacidade) ON DELETE RESTRICT ON UPDATE RESTRICT;