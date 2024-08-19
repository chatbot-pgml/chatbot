-- FUNCTION: chatbot.get_session(integer, bigint)

-- DROP FUNCTION IF EXISTS chatbot.get_session(integer, bigint);

CREATE OR REPLACE FUNCTION chatbot.get_session(
	tenacidade integer,
	sessao bigint)
    RETURNS text
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE PARALLEL UNSAFE
AS $BODY$
DECLARE
	msg text;
BEGIN
    SELECT
		id_sessao, 
        string_agg(di.mensagem_texto, chr(13))
    into msg
    FROM
        chatbot.dialogo as di
    WHERE
        di.id_sessao = sessao
		and di.tenacidade = tenacidade
	group by di.id_sessao
	order by di.data_hora_mensagem;

    -- Retorna o id da nova sessão
    RETURN msg;
END;
$BODY$;

ALTER FUNCTION chatbot.get_session(integer, bigint)
    OWNER TO u_znz1rkducdgumst;
