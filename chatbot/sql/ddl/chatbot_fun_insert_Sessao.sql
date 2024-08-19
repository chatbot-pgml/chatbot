DROP FUNCTION IF EXISTS chatbot.create_session;

CREATE OR REPLACE FUNCTION chatbot.create_session(
    ten BIGINT,
    ag_inf BIGINT,
    us BIGINT,
    ag_sum BIGINT,
    ag_emb BIGINT
)
RETURNS BIGINT AS $$
DECLARE
    sessao_id BIGINT;
BEGIN
    INSERT INTO chatbot.sessao
    (
        id_tenacidade,
        id_agente_inferencia,
        id_usuario,
        data_hora_conversa,
        sumario,
        sumario_integrado,
        endereco_ip_auditoria,
        nome_aplicacao_auditoria,
        id_agente_sumario,
        id_agente_embed,
        ultima_ordem
    )
    VALUES
    (
        ten,
        ag_inf,
        us,
        NOW(),
        ' ',
        0,
        '127.0.0.1',
        'chatbot',
        ag_sum,
        ag_emb,
        1
    )
    RETURNING id_sessao INTO sessao_id;

    RETURN sessao_id;
END;
$$ LANGUAGE plpgsql;
