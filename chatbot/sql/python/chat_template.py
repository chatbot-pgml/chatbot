import psycopg2
import gradio as gr

# Função para conectar ao banco de dados e chamar a função process_dialogue
def process_dialogue(p_id_tenacidade, p_id_sessao, p_id_usuario, p_question):
    try:
        # Conectar ao banco de dados PostgreSQL
        conn = psycopg2.connect(
            dbname="pgml_imfxtouybeo5jgu",
            user="u_znz1rkducdgumst",
            password="ng1chlr88ap1bse",
            host="437a9d42-c398-4c00-9906-c9b5fc2e7d61.gcp.db.postgresml.org",
            port="6432"
        )
        cur = conn.cursor()
        
        # Chamar a função process_dialogue
        cur.execute("""
            SELECT chatbot.process_dialogue(%s, %s, %s, %s);
        """, (p_id_tenacidade, p_id_sessao, p_id_usuario, p_question))
        
        # Obter o resultado
        result = cur.fetchone()[0]
        
        # Fechar a conexão
        cur.close()
        conn.close()
        
        return result
    except Exception as e:
        return str(e)

# Função para a interface do Gradio
def chatbot_interface(user_question, history):
    p_id_tenacidade = 1  # Exemplo de valor, altere conforme necessário
    p_id_sessao = 1      # Exemplo de valor, altere conforme necessário
    p_id_usuario = 1     # Exemplo de valor, altere conforme necessário
    
    response = process_dialogue(p_id_tenacidade, p_id_sessao, p_id_usuario, user_question)
    #history.append((user_question, response))
    return response

# Configurar a interface do Gradio
iface = gr.ChatInterface(
    fn=chatbot_interface,
    title="Chatbot Interface",
    description="Insira sua pergunta para o chatbot."
)

# Executar a interface do Gradio
if __name__ == "__main__":
    iface.launch()

