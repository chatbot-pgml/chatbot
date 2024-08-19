-- FUNCTION: chatbot.create_session(bigint, bigint, bigint, bigint)

-- DROP FUNCTION IF EXISTS chatbot.create_session(bigint, bigint, bigint, bigint);

CREATE OR REPLACE FUNCTION chatbot.create_session(
	ten bigint,
	ag_inf bigint,
	us bigint,
	ag_emb bigint)
    RETURNS bigint
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
    sessao_id BIGINT;
BEGIN
    INSERT INTO chatbot.sessao
    (
        id_tenacidade,
        id_agente_inferencia,
        id_usuario,
        data_hora_conversa,
        endereco_ip_auditoria,
        nome_aplicacao_auditoria,
        id_agente_embed,
        ultima_ordem
    )
    VALUES
    (
        ten,
        ag_inf,
        us,
        NOW(),
        '127.0.0.1',
        'chatbot',
        ag_emb,
        1
    )
    RETURNING id_sessao INTO sessao_id;

    RETURN sessao_id;
END;
$BODY$;

ALTER FUNCTION chatbot.create_session(bigint, bigint, bigint, bigint)
    OWNER TO u_znz1rkducdgumst;
