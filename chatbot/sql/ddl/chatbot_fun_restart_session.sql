-- DROP FUNCTION chatbot.restart_session(int4, int8);

CREATE OR REPLACE FUNCTION chatbot.restart_session(p_tenacidade integer, p_sessao bigint)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    nova_sessao_id BIGINT;
begin
	delete from chatbot.dialogo 
	where id_tenacidade = p_tenacidade
	and id_sessao = p_sessao;

	update chatbot.sessao
	set ultima_ordem = 1
	where id_sessao = p_sessao
	and id_tenacidade = p_tenacidade;
	
	nova_sessao_id := init_session(p_tenacidade, p_sessao);
end;
$function$
;