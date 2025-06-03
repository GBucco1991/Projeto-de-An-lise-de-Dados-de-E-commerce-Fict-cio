#!/usr/bin/env python
# coding: utf-8

# In[ ]:


pip install psycopg2 pandas sqlalchemy


# In[18]:


import pandas as pd
import numpy as np
from faker import Faker
import random
from sqlalchemy import create_engine

# ========== CONEXÃO COM O POSTGRESQL ==========
usuario = 'dsa'
senha = 'dsa1010'
host = 'localhost'
porta = '5434'
banco = 'ecommerce_db'

engine = create_engine(f'postgresql+psycopg2://{usuario}:{senha}@{host}:{porta}/{banco}')
print("✅ Conectado ao banco PostgreSQL!")

# ========== GERAR DADOS ==========
fake = Faker('pt_BR')
random.seed(42)
np.random.seed(42)

# ----- Clientes -----
clientes = []
for i in range(1, 501):
    clientes.append({
        'cliente_id': i,
        'nome': fake.name(),
        'sexo': random.choice(['M', 'F']),
        'idade': random.randint(18, 70),
        'cidade': fake.city(),
        'estado': fake.estado_sigla(),
        'data_cadastro': fake.date_between(start_date='-2y', end_date='today')
    })
df_clientes = pd.DataFrame(clientes)

# ----- Produtos -----
categorias = ['Eletrônicos', 'Roupas', 'Casa', 'Livros', 'Beleza']
produtos = []
for i in range(1, 101):
    categoria = random.choice(categorias)
    produtos.append({
        'produto_id': i,
        'nome': f"{fake.word().capitalize()} {categoria[:-1]}",
        'categoria': categoria,
        'preco': round(random.uniform(20, 1500), 2)
    })
df_produtos = pd.DataFrame(produtos)

# ----- Pedidos -----
pedidos = []
for i in range(1, 1001):
    pedidos.append({
        'pedido_id': i,
        'cliente_id': random.randint(1, 500),
        'data_pedido': fake.date_between(start_date='-1y', end_date='today'),
        'status': random.choices(['entregue', 'cancelado'], weights=[0.9, 0.1])[0]
    })
df_pedidos = pd.DataFrame(pedidos)

# ----- Itens do Pedido -----
itens = []
for pedido_id in df_pedidos['pedido_id']:
    num_itens = random.randint(1, 5)
    produtos_escolhidos = random.sample(range(1, 101), num_itens)
    for produto_id in produtos_escolhidos:
        quantidade = random.randint(1, 3)
        preco_unit = df_produtos.loc[df_produtos['produto_id'] == produto_id, 'preco'].values[0]
        itens.append({
            'pedido_id': pedido_id,
            'produto_id': produto_id,
            'quantidade': quantidade,
            'preco_unitario': preco_unit
        })
df_itens = pd.DataFrame(itens)

# ----- Pagamentos -----
formas_pagamento = ['cartão de crédito', 'boleto', 'pix', 'cartão de débito']
pagamentos = []
for pedido_id in df_pedidos['pedido_id']:
    total = df_itens[df_itens['pedido_id'] == pedido_id]['quantidade'] * \
            df_itens[df_itens['pedido_id'] == pedido_id]['preco_unitario']
    pagamentos.append({
        'pedido_id': pedido_id,
        'forma_pagamento': random.choices(formas_pagamento, weights=[0.5, 0.2, 0.2, 0.1])[0],
        'valor': round(total.sum(), 2)
    })
df_pagamentos = pd.DataFrame(pagamentos)

# ========== ENVIAR PARA O POSTGRESQL ==========
df_clientes.to_sql('clientes', engine, index=False, if_exists='replace')
df_produtos.to_sql('produtos', engine, index=False, if_exists='replace')
df_pedidos.to_sql('pedidos', engine, index=False, if_exists='replace')
df_itens.to_sql('itens_pedido', engine, index=False, if_exists='replace')
df_pagamentos.to_sql('pagamentos', engine, index=False, if_exists='replace')

print("🎉 Dados gerados e inseridos com sucesso no PostgreSQL!")


# In[ ]:




