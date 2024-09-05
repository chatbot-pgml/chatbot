set search_path= chatbot, public, pgml;
SELECT chatbot.process_dialogue(:p_id_tenacidade, :p_id_sessao, :p_id_usuario, :p_question, :p_id_arquivo);