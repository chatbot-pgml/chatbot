CREATE OR REPLACE FUNCTION chatbot.restart_session(
	p_tenacidade integer,
	p_sessao bigint)
    returns void
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
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
end;
$BODY$;
