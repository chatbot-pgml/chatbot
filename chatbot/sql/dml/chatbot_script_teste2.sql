set search_path= chatbot, public, pgml;
        WITH modelo_embed AS (
             SELECT ag.modelo 
    FROM chatbot.sessao se
    JOIN chatbot.agente ag ON se.id_agente_embed = ag.id_agente
    WHERE se.id_sessao = :p_id_sessao
      AND se.id_tenacidade = :p_id_tenacidade
      AND ag.id_tenacidade = :p_id_tenacidade
        ),
        lista_contexto AS (
            SELECT ch.id_arquivo,
                   string_agg(ch.parte, chr(13)) AS lista_partes
            FROM (
                SELECT ap.id_arquivo, ap.parte
                FROM chatbot.arquivo_parte ap
                JOIN chatbot.arquivo ar ON ap.id_arquivo = ar.id_arquivo
                JOIN modelo_embed me ON ap.id_tenacidade = :p_id_tenacidade
                WHERE ar.selecionar = 1 OR (:p_id_arquivo <> 0 AND ap.id_arquivo = :p_id_arquivo)
                ORDER BY pgml.embed(me.modelo, :p_question)::vector <=> ap.embed::vector
                LIMIT 20
            ) ch
            GROUP BY ch.id_arquivo
        ),
        historico AS (
            SELECT di.id_sessao,
                   string_agg(di.mensagem, ' ' ORDER BY di.ordem) AS mensagens
            FROM chatbot.dialogo di
            WHERE di.id_sessao = :p_id_sessao
              AND di.id_tenacidade = :p_id_tenacidade
            GROUP BY di.id_sessao
        ),
        questao_usuario AS (
            SELECT replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', ''), 
                           '{$question}', :p_question)::text AS user_question,
                   se.ultima_ordem
            FROM chatbot.sessao se
            JOIN chatbot.agente ag ON se.id_agente_inferencia = ag.id_agente
            WHERE se.id_sessao = :p_id_sessao
              AND se.id_tenacidade = :p_id_tenacidade
        ) -- ,
        -- inferencia AS (
            SELECT 
            -- pgml.transform(
            --           task => replace(replace('{ "task" : "{tarefa}", "model" : "{modelo}" }',
            --                                   '{tarefa}', ag.tarefa), 
            --                           '{modelo}', ag.modelo)::JSONB,
            --           inputs => ARRAY[
                           his.mensagens, 
                           	replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', 'considerando o contexto a seguir:' || chr(13) || lc.lista_partes), 
                                                 '{$question}', 
                                                 :p_question)::text as answer,
            --           ], 
            --           args   => '{ "max_new_tokens": 1000 }'::JSONB)::text AS answer,
                   se.ultima_ordem,
                   ag.modelo_prompt_dialogo_a AS prompt_assistente
            FROM lista_contexto lc,
                 chatbot.sessao se,
                 chatbot.agente ag,
                 historico his
            WHERE se.id_sessao = :p_id_sessao
              AND se.id_tenacidade = :p_id_tenacidade
              AND se.id_agente_inferencia = ag.id_agente