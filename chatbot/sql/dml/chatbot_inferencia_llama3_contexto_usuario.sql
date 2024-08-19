insert into
	chatbot.dialogo
(
	id_tenacidade,
	id_sessao, 
	id_usuario,
	data_hora_mensagem,
	direcao,
	endereco_ip_auditoria,
	nome_aplicacao_auditoria,
	mensagem,
	mensagem_embbed,
	ordem)
	
with modelo_embed as (
select ag.modelo
from chatbot.sessao as se, 
	 chatbot.agente as ag
where se.id_sessao = :ses
and se.id_agente_embed = ag.id_agente
and ag.id_tenacidade = :ten
and se.id_tenacidade = :ten), 
lista_contexto as 
(SELECT ch.id_arquivo, 
	   string_agg(ch.parte, chr(13)) as lista_partes   
FROM (select ap.id_arquivo, ap.parte
	  FROM chatbot.arquivo_parte as ap, 
	  	   modelo_embed as me
	  where ap.id_tenacidade = :ten
	  ORDER BY pgml.embed(me.modelo,:question)::vector <=> ap.embed::vector
	  LIMIT 10) as ch 
GROUP by ch.id_arquivo),
lista_contexto_usuario as 
(SELECT ch.id_arquivo_usuario, 
	   string_agg(ch.parte, chr(13)) as lista_partes_usuario   
FROM (
	  select sm.id_arquivo_usuario, sm.parte 
	  from (
	  		select ap.id_arquivo_usuario, ap.parte,
		    	   ap.embed::vector <=> (select pgml.embed(me.modelo,:question)::vector)
		    FROM chatbot.arquivo_parte_usuario as ap, 
		    	 chatbot.arquivo_usuario as au,
		    	   modelo_embed as me
		    where ap.id_tenacidade = :ten
		      and ap.id_arquivo_usuario = au.id_arquivo_usuario
		      and au.id_usuario = :us
		    union 
		    select 0, ' ', 1
		    where not exists (select 1 
							  from chatbot.arquivo_usuario as au
							  where au.id_usuario=:us 
  					  		    and au.id_tenacidade=:ten)
		    order by 3
	        limit 10
	       ) as sm
	 ) as ch 
GROUP by ch.id_arquivo_usuario),
historico as 
(SELECT di.id_sessao, 
       string_agg(di.mensagem, ' ' ORDER BY di.ordem) as mensagens
FROM chatbot.dialogo di
WHERE di.id_sessao = :ses
and di.id_tenacidade = :ten
GROUP BY di.id_sessao),
questao_usuario as (
SELECT replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', ' '), 
          '{$question}', 
           :question)::text as user_question,
           se.ultima_ordem
FROM 
	chatbot.sessao as se,
	chatbot.agente as ag
where
	se.id_sessao = :ses
	and se.id_tenacidade = :ten
and se.id_agente_inferencia = ag.id_agente),
inferencia as (
SELECT 
replace(
	replace(pgml.transform(
  	          task => replace(
					  replace('{ "task" : "{tarefa}", "model" : "{modelo}" }',
				  		'{tarefa}', ag.tarefa), 
				  		'{modelo}', ag.modelo)::JSONB,
  
			  inputs => ARRAY
			  [
			   his.mensagens||replace(replace(ag.modelo_prompt_dialogo_u, '{$context}', 'considerando o contexto a seguir:' || chr(13) || lc.lista_partes || chr(13) || lu.lista_partes_usuario), 
			          '{$question}', 
			           :question)::text
			  ], 
			  args   => '{
			    "max_new_tokens": 500 
			  }'::JSONB)::TEXT,
			'["<|start_header_id|>assistant<|end_header_id|>', ' '),'"]', '') as answer,
se.ultima_ordem,
ag.modelo_prompt_dialogo_a as prompt_assistente
from 
lista_contexto as lc,
lista_contexto_usuario as lu,
	chatbot.sessao as se,
	chatbot.agente as ag,
	historico as his
where
	se.id_sessao = :ses
	and se.id_tenacidade = :ten
and se.id_agente_inferencia = ag.id_agente)
select 
	:ten,
	:ses,
	:us,
	now(),
	'U',
	'127.0.0.1',
	'chatbot',
	qu.user_question,
	pgml.embed(me.modelo, :question)::vector, 
	qu.ultima_ordem+1
from questao_usuario as qu, modelo_embed as me
union
select
	:ten,
	:ses,
	:us,
	now(),
	'A',
	'127.0.0.1',
	'chatbot',
   	replace(inf.prompt_assistente, '{$answer}',
   	        replace(inf.answer, '\n', chr(13))),
	pgml.embed(me.modelo, replace(inf.answer,'\n', chr(13)))::vector,
	inf.ultima_ordem+2
from inferencia as inf, modelo_embed as me;

update chatbot.sessao
set ultima_ordem= ultima_ordem+2
where id_sessao = :ses
and id_tenacidade = :ten;
	


