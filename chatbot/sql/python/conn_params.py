import asyncio
import asyncpg
import gradio as gr

async def create_session(message):

    # Connection parameters
    conn_params = {
        'user': 'u_znz1rkducdgumst',
        'password': 'ng1chlr88ap1bse',
        'database': 'pgml_imfxtouybeo5jgu',
        'host': '437a9d42-c398-4c00-9906-c9b5fc2e7d61.gcp.db.postgresml.org',
        'port': 6432,
        'max_pool_size': '2',
        'max_queries': '10'
    }
    pool = await asyncpg.create_pool(**conn_params)

    # Connect to the database
    async with pool.acquire() as conn:
        try:
            # Call the PL/pgSQL function
            params_session={
                'ten' : '1',
                'ag_inf' : '7',
                'us' : '2',
                'ag_sum' : '7',
                'ag_emb' : '1'
            }
            result = await conn.fetchval('PERFORM chatbot.create_session($1, $2, $3, $4, $5, $6)', params_session['ten'], params_session['ag_inf'],
                                        params_session['us'], params_session['ag_sum'], params_session['ag_emb']
                                        )
            print(f'Result of params_session($1, $2, $3, $4, $5, $6) : {result}')
            return result
        finally:
            # Close the connection
            await conn.close()

    # Run the async main function

async def main():
    result= await create_session(message='uma mensagem')
    print(result)
    
main()