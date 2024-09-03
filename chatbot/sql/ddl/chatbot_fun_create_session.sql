-- DROP FUNCTION chatbot.create_session(int8, int8, int8, int8);

CREATE OR REPLACE FUNCTION chatbot.create_session(ten bigint, ag_inf bigint, us bigint, ag_emb bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
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
$function$
;