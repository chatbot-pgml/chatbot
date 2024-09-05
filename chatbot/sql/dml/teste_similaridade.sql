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
                   ch.parte,
                   ch.cosine_distance
            FROM (
                SELECT ap.id_arquivo, ap.parte, pgml.cosine_similarity(pgml.embed(me.modelo, :p_question)::vector, ap.embed::vector) AS cosine_distance
                FROM chatbot.arquivo_parte ap                
                JOIN chatbot.arquivo ar ON ap.id_arquivo = ar.id_arquivo
                JOIN modelo_embed me ON ap.id_tenacidade = :p_id_tenacidade
                WHERE (ar.selecionar = 1 OR (:p_id_arquivo <> 0 AND ap.id_arquivo = :p_id_arquivo))
                AND ((ar.id_pessoa IS NOT NULL AND ar.id_pessoa = :p_id_usuario) OR ar.id_pessoa IS NULL)
                ORDER BY pgml.embed(me.modelo, :p_question)::vector <=> ap.embed::vector
                LIMIT 20
            ) ch
        )
        select * from lista_contexto