PGDMP                      }            ecommerce_db    16.0 (Debian 16.0-1.pgdg120+1)    17.1     5           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            6           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            7           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            8           1262    57621    ecommerce_db    DATABASE     w   CREATE DATABASE ecommerce_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
    DROP DATABASE ecommerce_db;
                     dsa    false                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     pg_database_owner    false            9           0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                        pg_database_owner    false    4            �            1259    57676    clientes    TABLE     �   CREATE TABLE public.clientes (
    cliente_id integer NOT NULL,
    nome character varying,
    sexo character(1),
    idade integer,
    cidade character varying,
    estado character(2),
    data_cadastro date
);
    DROP TABLE public.clientes;
       public         heap r       dsa    false    4            �            1259    57702    itens_pedido    TABLE     �   CREATE TABLE public.itens_pedido (
    pedido_id integer,
    produto_id integer,
    quantidade integer,
    preco_unitario numeric
);
     DROP TABLE public.itens_pedido;
       public         heap r       dsa    false    4            �            1259    57717 
   pagamentos    TABLE     }   CREATE TABLE public.pagamentos (
    pedido_id integer NOT NULL,
    forma_pagamento character varying,
    valor numeric
);
    DROP TABLE public.pagamentos;
       public         heap r       dsa    false    4            �            1259    57690    pedidos    TABLE     �   CREATE TABLE public.pedidos (
    pedido_id integer NOT NULL,
    cliente_id integer,
    data_pedido date,
    status character varying
);
    DROP TABLE public.pedidos;
       public         heap r       dsa    false    4            �            1259    57683    produtos    TABLE     �   CREATE TABLE public.produtos (
    produto_id integer NOT NULL,
    nome character varying,
    categoria character varying,
    preco numeric
);
    DROP TABLE public.produtos;
       public         heap r       dsa    false    4            .          0    57676    clientes 
   TABLE DATA           `   COPY public.clientes (cliente_id, nome, sexo, idade, cidade, estado, data_cadastro) FROM stdin;
    public               dsa    false    216   �       1          0    57702    itens_pedido 
   TABLE DATA           Y   COPY public.itens_pedido (pedido_id, produto_id, quantidade, preco_unitario) FROM stdin;
    public               dsa    false    219          2          0    57717 
   pagamentos 
   TABLE DATA           G   COPY public.pagamentos (pedido_id, forma_pagamento, valor) FROM stdin;
    public               dsa    false    220   $       0          0    57690    pedidos 
   TABLE DATA           M   COPY public.pedidos (pedido_id, cliente_id, data_pedido, status) FROM stdin;
    public               dsa    false    218   A       /          0    57683    produtos 
   TABLE DATA           F   COPY public.produtos (produto_id, nome, categoria, preco) FROM stdin;
    public               dsa    false    217   ^       �           2606    57682    clientes clientes_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.clientes
    ADD CONSTRAINT clientes_pkey PRIMARY KEY (cliente_id);
 @   ALTER TABLE ONLY public.clientes DROP CONSTRAINT clientes_pkey;
       public                 dsa    false    216            �           2606    57723    pagamentos pagamentos_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_pkey PRIMARY KEY (pedido_id);
 D   ALTER TABLE ONLY public.pagamentos DROP CONSTRAINT pagamentos_pkey;
       public                 dsa    false    220            �           2606    57696    pedidos pedidos_pkey 
   CONSTRAINT     Y   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_pkey PRIMARY KEY (pedido_id);
 >   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_pkey;
       public                 dsa    false    218            �           2606    57689    produtos produtos_pkey 
   CONSTRAINT     \   ALTER TABLE ONLY public.produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (produto_id);
 @   ALTER TABLE ONLY public.produtos DROP CONSTRAINT produtos_pkey;
       public                 dsa    false    217            �           2606    57707 (   itens_pedido itens_pedido_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(pedido_id);
 R   ALTER TABLE ONLY public.itens_pedido DROP CONSTRAINT itens_pedido_pedido_id_fkey;
       public               dsa    false    219    3224    218            �           2606    57712 )   itens_pedido itens_pedido_produto_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.itens_pedido
    ADD CONSTRAINT itens_pedido_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES public.produtos(produto_id);
 S   ALTER TABLE ONLY public.itens_pedido DROP CONSTRAINT itens_pedido_produto_id_fkey;
       public               dsa    false    219    217    3222            �           2606    57724 $   pagamentos pagamentos_pedido_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pagamentos
    ADD CONSTRAINT pagamentos_pedido_id_fkey FOREIGN KEY (pedido_id) REFERENCES public.pedidos(pedido_id);
 N   ALTER TABLE ONLY public.pagamentos DROP CONSTRAINT pagamentos_pedido_id_fkey;
       public               dsa    false    218    220    3224            �           2606    57697    pedidos pedidos_cliente_id_fkey    FK CONSTRAINT     �   ALTER TABLE ONLY public.pedidos
    ADD CONSTRAINT pedidos_cliente_id_fkey FOREIGN KEY (cliente_id) REFERENCES public.clientes(cliente_id);
 I   ALTER TABLE ONLY public.pedidos DROP CONSTRAINT pedidos_cliente_id_fkey;
       public               dsa    false    218    216    3220            .      x������ � �      1      x������ � �      2      x������ � �      0      x������ � �      /      x������ � �     