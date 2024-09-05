-- DROP FUNCTION chatbot.process_dialogue(int4, int4, int4, text, int4);

CREATE OR REPLACE FUNCTION chatbot.process_dialogue(p_id_tenacidade integer, p_id_sessao integer, p_id_usuario integer, p_question text, p_id_arquivo integer DEFAULT 0)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_modelo TEXT;
    v_ultima_ordem INTEGER;
    v_user_question TEXT;
    v_answer TEXT;
    v_prompt_assistente TEXT;
    v_mensagem_texto TEXT;
    v_id_dialogo INTEGER;
    cur refcursor;
    rec RECORD;
    v_data_hora_pergunta timestamp;
	v_data_hora_resposta timestamp;
BEGIN
    -- Obter modelo embed
    SELECT ag.modelo INTO v_modelo
    FROM chatbot.sessao se
    JOIN chatbot.agente ag ON se.id_agente_embed = ag.id_agente
    WHERE se.id_sessao = p_id_sessao
      AND se.id_tenacidade = p_id_tenacidade
      AND ag.id_tenacidade = p_id_tenacidade;

    -- Obter data e hora da pergunta do usuário
	SELECT clock_timestamp() INTO v_data_hora_pergunta; 

    -- Abrir cursor para consulta complexa
    OPEN cur FOR
        WITH modelo_embed AS (
            SELECT v_modelo AS modelo
        ),
        lista_contexto AS (
            SELECT ch.id_arquivo,
                   string_agg(ch.parte, chr(13)) AS lista_partes
            FROM (
                SELECT ap.id_arquivo, ap.parte
                FROM chatbot.arquivo_parte ap
                JOIN chatbot.arquivo ar ON ap.id_arquivo = ar.id_arquivo
                JOIN modelo_embed me ON ap.id_tenacidade = p_id_tenacidade
                WHERE ar.selecionar = 1 OR (p_id_arquivo <> 0 AND ap.id_arquivo = p_id_arquivo)
                ORDER BY pgml.embed(me.modelo, p_question)::vector <=> ap.embed::vector
                LIMIT 20
            ) ch
            GROUP BY ch.id_arquivo
        ),
        historico AS (
            SELECT di.id_sessao,
                   string_agg(di.mensagem, ' ' ORDER BY di.ordem) AS mensagens
            FROM chatbot.dialogo di
            WHERE di.id_sessao = p_id_sessao
              AND di.id_tenacidade = p_id_tenacidade
            GROUP BY di.id_sessao
        ),
        questao_usuario AS (
            SELECT replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', ''), 
                           '{$question}', p_question)::text AS user_question,
                   se.ultima_ordem
            FROM chatbot.sessao se
            JOIN chatbot.agente ag ON se.id_agente_inferencia = ag.id_agente
            WHERE se.id_sessao = p_id_sessao
              AND se.id_tenacidade = p_id_tenacidade
        ),
        inferencia AS (
            SELECT pgml.transform(
                       task => replace(replace('{ "task" : "{tarefa}", "model" : "{modelo}" }',
                                               '{tarefa}', ag.tarefa), 
                                       '{modelo}', ag.modelo)::JSONB,
                       inputs => ARRAY[
                           his.mensagens||replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', 'considerando o contexto a seguir:' || chr(13) || lc.lista_partes), 
                                                 '{$question}', 
                                                 p_question)::text
                       ], 
                       args   => '{ "max_new_tokens": 1000 }'::JSONB)::text AS answer,
                   se.ultima_ordem,
                   ag.modelo_prompt_dialogo_a AS prompt_assistente
            FROM lista_contexto lc,
                 chatbot.sessao se,
                 chatbot.agente ag,
                 historico his
            WHERE se.id_sessao = p_id_sessao
              AND se.id_tenacidade = p_id_tenacidade
              AND se.id_agente_inferencia = ag.id_agente
        )
        SELECT 
            p_id_tenacidade AS tenacidade,
            p_id_sessao AS sessao,
            p_id_usuario AS usuario,
            now() as dataagora,
            'U' AS direcao,
            '127.0.0.1',
            'chatbot',
            qu.user_question AS mensagem,
            pgml.embed(me.modelo, p_question)::vector AS msg_embed, 
            qu.ultima_ordem + 1 AS ordem
        FROM questao_usuario qu, modelo_embed me
        UNION ALL
        SELECT
            p_id_tenacidade,
            p_id_sessao,
            p_id_usuario,
            now(),
            'A',
            '127.0.0.1',
            'chatbot',
            replace(inf.prompt_assistente, '{$answer}', replace(inf.answer, '\n', chr(13))),
            pgml.embed(me.modelo, replace(inf.answer, '\n', chr(13)))::vector,
            inf.ultima_ordem + 2
        FROM inferencia inf, modelo_embed me;

    -- Percorrer os registros retornados pelo cursor
    LOOP
        FETCH cur INTO rec;
        EXIT WHEN NOT FOUND;

        -- Processar os registros
        INSERT INTO chatbot.dialogo(
            id_tenacidade,
            id_sessao, 
            id_pessoa,
            data_hora_mensagem,
            direcao,
            endereco_ip_auditoria,
            nome_aplicacao_auditoria,
            mensagem,
            mensagem_embbed,
            ordem
        )
        VALUES (
            rec.tenacidade,
            rec.sessao,
            rec.usuario,
            rec.dataagora,
            rec.direcao,
            '127.0.0.1',
            'chatbot',
            rec.mensagem,
            rec.msg_embed,
            rec.ordem
        )
        RETURNING id_dialogo INTO v_id_dialogo;
		
        
        IF rec.direcao = 'U' THEN
            -- Atualizar mensagem_texto para mensagens do usuário
        	v_mensagem_texto := replace(rec.mensagem, '\r', chr(13));
        	v_mensagem_texto := replace(v_mensagem_texto, '<|start_header_id|>', '');
			v_mensagem_texto := replace(v_mensagem_texto, 'user', '');        	
        	v_mensagem_texto := replace(v_mensagem_texto, '<|end_header_id|>', '');
        	v_mensagem_texto := replace(v_mensagem_texto, '<|eot_id|>', '');
        
        	v_mensagem_texto := replace(v_mensagem_texto, '["', '');
        	v_mensagem_texto := replace(v_mensagem_texto, '"]', '');
        
            UPDATE chatbot.dialogo  
            SET mensagem_texto = v_mensagem_texto, data_hora_mensagem = v_data_hora_pergunta
            WHERE id_dialogo = v_id_dialogo;
        ELSE
    		SELECT clock_timestamp() INTO v_data_hora_resposta; 

        	-- Atualizar mensagem_texto para mensagens do assistente
    		v_mensagem_texto := replace(rec.mensagem, '\r', chr(13));
        	v_mensagem_texto := replace(v_mensagem_texto, '<|end_header_id|>' || chr(13) || chr(13), '');
        	v_mensagem_texto := replace(v_mensagem_texto, '<|start_header_id|>', '');
			v_mensagem_texto := replace(v_mensagem_texto, 'assistant', '');        	
        	v_mensagem_texto := replace(v_mensagem_texto, '<|end_header_id|>', '');
        	v_mensagem_texto := replace(v_mensagem_texto, '<|eot_id|>', '');	
        	v_mensagem_texto := replace(v_mensagem_texto, '\"', '"');
        
        	v_mensagem_texto := replace(v_mensagem_texto, '["', '');
        	v_mensagem_texto := replace(v_mensagem_texto, '"]', '');
        	
        
        	
        	
            UPDATE chatbot.dialogo
            SET mensagem_texto = v_mensagem_texto, data_hora_mensagem = v_data_hora_resposta
            WHERE id_dialogo = v_id_dialogo;
        END IF;
    END LOOP;

    -- Fechar o cursor
    CLOSE cur;

    -- Atualizar última ordem na sessão
    UPDATE chatbot.sessao
    SET ultima_ordem = ultima_ordem + 2
    WHERE id_sessao = p_id_sessao
      AND id_tenacidade = p_id_tenacidade;

    RETURN v_mensagem_texto;
END;
$function$
;
