insert
	into
	chatbot.dialogo
(
	id_tenacidade,
	id_sessao, 
	id_usuario,
	data_hora_mensagem,
	direcao,
	mensagem,
	mensagem_texto, 
	ordem,
	endereco_ip_auditoria,
	nome_aplicacao_auditoria)
select
:ten,
:ses,
se.id_usuario,
now(),
'S', 
replace(ag.prompt_modelo_sistema, '{$system_prompt}', ag.prompt_modelo || replace(us.perfil, '{$nome}', us.nome)) as msg,
ag.prompt_modelo,
1,
'127.0.0.1',
'chatbot'
from chatbot.sessao as se, 
	 chatbot.agente as ag,
	 chatbot.usuario as us
where se.id_sessao = :ses
  and se.id_agente_inferencia = ag.id_agente
  and se.id_usuario = us.id_usuario;
 
 
 
