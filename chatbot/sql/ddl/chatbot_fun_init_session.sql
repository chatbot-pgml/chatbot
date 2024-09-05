-- DROP FUNCTION chatbot.init_session(int4, int8);

CREATE OR REPLACE FUNCTION chatbot.init_session(tenacidade integer, sessao bigint)
 RETURNS bigint
 LANGUAGE plpgsql
AS $function$
DECLARE
    nova_sessao_id BIGINT;
BEGIN
    -- Insere o diálogo na tabela chatbot.dialogo
    INSERT INTO chatbot.dialogo (
        id_tenacidade,
        id_sessao,
        id_pessoa,
        id_usuario_auditoria,
        data_hora_mensagem,
        direcao,
        mensagem,
        mensagem_texto,
        ordem,
        endereco_ip_auditoria,
        nome_aplicacao_auditoria
    )
    SELECT
        tenacidade,
        sessao,
        se.id_pessoa,
        se.id_pessoa,
        NOW(),
        'S',
        REPLACE(ag.prompt_modelo_sistema, '{$system_prompt}', ag.prompt_modelo || REPLACE(us.perfil, '{$nome}', us.nome_pf)) AS msg,
        ag.prompt_modelo,
        1,
        inet_client_addr(),
        'postgres'
    FROM
        chatbot.sessao AS se,
        chatbot.agente AS ag,
        chatbot.pessoa AS us
    WHERE
        se.id_sessao = sessao
        AND se.id_agente_inferencia = ag.id_agente
        AND se.id_pessoa = us.id_pessoa
    RETURNING id_sessao INTO nova_sessao_id;

    -- Retorna o id da nova sessão
    RETURN nova_sessao_id;
END;
$function$
;
