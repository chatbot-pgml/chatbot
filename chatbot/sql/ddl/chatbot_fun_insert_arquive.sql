-- DROP FUNCTION chatbot.insert_arquivo_parte(int4, int4, int4);

CREATE OR REPLACE FUNCTION chatbot.insert_arquivo_parte(p_id_tenacidade integer, p_id_arquivo integer, p_id_agente integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
begin
	delete from arquivo_parte 
	where id_tenacidade = p_id_tenacidade
	and id_arquivo = p_id_arquivo;

    INSERT INTO chatbot.arquivo_parte 
        (id_tenacidade, id_arquivo, sequencial, parte, embed, endereco_ip_auditoria, nome_aplicacao_auditoria)
    WITH text_chunks AS (
        SELECT id_tenacidade,
               id_arquivo, 
               (pgml.chunk('recursive_character', d.texto, '{"chunk_size": 200, "chunk_overlap": 40}')).* AS chk
        FROM chatbot.arquivo AS d
        WHERE id_tenacidade = p_id_tenacidade
          AND id_arquivo = p_id_arquivo
    ), 
    text_embeds AS (
        SELECT tc.id_tenacidade, 
               tc.id_arquivo, 
               tc.chunk_index, 
               tc.chunk, 
               pgml.embed(ag.modelo, chunk) AS embed, 
               '127.0.0.1' AS endereco_ip_auditoria,
               'chatbot' AS nome_aplicacao_auditoria
        FROM text_chunks AS tc
        JOIN chatbot.agente AS ag ON ag.id_agente = p_id_agente
    )
    SELECT * FROM text_embeds;
END;
$function$
;