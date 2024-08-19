INSERT INTO chatbot.arquivo_parte  (id_tenacidade ,id_arquivo, sequencial, parte , embed, endereco_ip_auditoria, nome_aplicacao_auditoria)
WITH text_chunks AS (
	SELECT id_tenacidade,
		   id_arquivo, 
		   (pgml.chunk('recursive_character',
		               d.texto, 
		   			   '{"chunk_size": 200, "chunk_overlap": 40}')).* AS chk
	FROM chatbot.arquivo AS d
	where id_tenacidade=:ten
	and id_arquivo = :arq), 
text_embeds AS (
	 SELECT tc.id_tenacidade, 
			tc.id_arquivo, 
			tc.chunk_index, 
			tc.chunk, 
			pgml.embed(ag.modelo, chunk) AS embed, 
			'127.0.0.1',
			'chatbot'
	 FROM text_chunks as tc, chatbot.agente AS ag 
	 WHERE ag.id_agente= :agt
	)	
SELECT *  
FROM text_embeds;


