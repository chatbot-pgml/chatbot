import asyncio
import asyncpg

async def main():
    # Connection parameters
    conn_params = {
        'user': 'u_znz1rkducdgumst',
        'password': 'ng1chlr88ap1bse',
        'database': 'pgml_imfxtouybeo5jgu',
        'host': '437a9d42-c398-4c00-9906-c9b5fc2e7d61.gcp.db.postgresml.org',
        'port': 6432
    }

    # Connect to the database
    conn = await asyncpg.connect(**conn_params)

    try:
        # Call the PL/pgSQL function
        result = await conn.fetchval('SELECT add_numbers($1, $2)', 3, 5)
        print(f'Result of add_numbers(3, 5): {result}')
    finally:
        # Close the connection
        await conn.close()

# Run the async main function
asyncio.run(main())
