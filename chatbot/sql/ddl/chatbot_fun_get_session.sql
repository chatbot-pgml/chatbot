-- DROP FUNCTION chatbot.get_session(int4, int8);

CREATE OR REPLACE FUNCTION chatbot.get_session(par_tenacidade integer, par_sessao bigint)
 RETURNS text
 LANGUAGE plpgsql
AS $function$
DECLARE
    msg text := '';
    rec RECORD;
BEGIN
    FOR rec IN
        SELECT di.data_hora_mensagem, di.direcao, di.ordem, di.mensagem_texto
        FROM chatbot.dialogo as di
        WHERE di.id_sessao = par_sessao
            AND di.id_tenacidade = par_tenacidade
        ORDER BY di.ordem
    LOOP
        msg := msg || '<b><i>' || 'Data/Hora: ' || rec.data_hora_mensagem || ' - '
                   || 'Direção: ' || rec.direcao || ' - '
                   || 'Ordem: ' || rec.ordem || '</b></i>' || CHR(13) || CHR(10)
                   || 'Mensagem: ' || rec.mensagem_texto || CHR(13) || CHR(10) || CHR(13) || CHR(10);
    END LOOP;

    -- Retorna a mensagem concatenada
    RETURN msg;
END;
$function$
;
