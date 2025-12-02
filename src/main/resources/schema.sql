CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(200) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL
);
CREATE TABLE endereco(
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(200) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR (100),
    bairro VARCHAR (100) NOT NULL,
    cidade VARCHAR (100) NOT NULL,
    estado CHAR (2)
);
CREATE TABLE cliente(
    id SERIAL PRIMARY KEY ,
    documento VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR (200) NOT NULL,
    tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'F')),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco_id INTEGER REFERENCES endereco(id)
    );
CREATE TABLE produto(
    id SERIA PRIMARY KEY,
    nome VARCHAR(200) NOT NULL
    peso_kg DECIMAL(10,2) NOT NULL CHECK (peso_kg >0),
    volume_m3 DECIMAL(10,3) NOT NULL CHECK (volume_m3 >0),
    valor_unitario DECIMAL(10,2) NOT NULL CHECK (valor_unitario >=0)
);
CREATE TABLE entrega(
    id SERIAL PRIMARY KEY,
    codigo_rastreio VARCHAR(20) UNIQUE NOT NULL,
    data criacao DATE DEFAULT CURRET_DATE,
    data_prevista_entrega DATE NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
    valor_frete DECIMAL(10,2) NOT NULL,
    observacoes TEXT,
    remetente_id INTEGER REFERENCES cliente(id) NOT NULL,
    destinatario_id INTEGER REFERENCES cliente(id) NOT NULL
);

CREATE TABLE item_entrega (
    id SERIAL PRIMARY KEY ,
    entrega_id INTEGER REFERENCES entrega(id) ON DELETE CASCADE,
    produto_id INTEGER REFERENCES produto(id),
    quantidade INTEGER NOT NULL CHECK ( quantidade >0 )
);

--MEUS INSERT

-- ENDERECOS
INSERT INTO endereco(logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES
    ('Rua das Flores', '123', 'Sala 101', 'Centro', 'São Paulo', 'SP', '01001-000'),
    ('Avenida Brasil', '456', 'Andar 5', 'Jardins', 'Rio de Janeiro', 'RJ', '20040-000'),
    ('Rua das Palmeiras', '789', 'Casa 2', 'Savassi', 'Belo Horizonte', 'MG', '30130-000'),
    ('Travessa dos Pinheiros', '321', NULL, 'Vila Mariana', 'São Paulo', 'SP', '04101-000'),
    ('Alameda Santos', '1000', 'Conjunto 304', 'Jardim Paulista', 'São Paulo', 'SP', '01418-000');

--CLIENTES
INSERT INTO  cliente(documento, nome, tipo, telefone, email,endereco_id) VALUES
     ('12345678901', 'João Silva', 'F', '(11) 99999-8888', 'joao.silva@email.com', 1),
     ('98765432000198', 'Tech Solutions LTDA', 'J', '(11) 3333-4444', 'contato@techsolutions.com', 2),
     ('98765432109', 'Maria Oliveira', 'F', '(21) 98888-7777', 'maria.oliveira@email.com', 3),
     ('11122233344', 'Carlos Santos', 'F', '(31) 97777-6666', 'carlos.santos@email.com', 4),
     ('55667788000199', 'Logística Express', 'J', '(11) 2222-3333', 'vendas@logisticaexpress.com', 5);

--PRODUTOS
INSERT INTO produto(nome, peso_kg, volume_m3, valor_unitario) VALUES
     ('Notebook Dell Inspiron', 2.3, 0.003, 3500.00),
     ('Smartphone Samsung Galaxy', 0.25, 0.00015, 2200.00),
     ('Monitor LG 24"', 4.5, 0.012, 899.90),
     ('Teclado Mecânico RGB', 1.2, 0.002, 299.00),
     ('Mouse Gamer', 0.15, 0.0003, 150.00),
     ('Tablet Apple iPad', 0.48, 0.0008, 4200.00),
     ('Impressora Multifuncional', 8.7, 0.025, 650.00);

--ENTREGAS
INSERT INTO entrega(codigo_rastreio, data_criacao, data_prevista_entrega, status, valor-valor_frete, observacoes, remetente_id, destinatario_id) VALUES
    ('TC20240001', '2024-01-15', '2024-01-20', 'PENDENTE', 45.50, 'Fragil - Manuseio com cuidado', 2, 1),
    ('TC20240002', '2024-01-16', '2024-01-22', 'EM_TRANSITO', 60.00, 'Entregar apenas para o destinatário', 1, 3),
    ('TC20240003', '2024-01-10', '2024-01-12', 'ENTREGUE', 35.00, 'Já entregue - confirmar recebimento', 5, 4),
    ('TC20240004', '2024-01-17', '2024-01-25', 'PENDENTE', 75.00, 'Produto de alto valor', 3, 2),
    ('TC20240005', '2024-01-14', '2024-01-18', 'CANCELADA', 40.00, 'Cancelada a pedido do cliente', 4, 5);

-- ITENS DAS ENTREGAS
INSERT INTO item_entrega (entrega_id, produto_id, quantidade) VALUES
    (1, 1, 1),   -- Entrega 1: 1 Notebook
    (1, 2, 2),   -- Entrega 1: 2 Smartphones
    (2, 3, 1),   -- Entrega 2: 1 Monitor
    (2, 4, 1),   -- Entrega 2: 1 Teclado
    (2, 5, 1),   -- Entrega 2: 1 Mouse
    (3, 6, 1),   -- Entrega 3: 1 Tablet
    (4, 7, 1),   -- Entrega 4: 1 Impressora
    (4, 1, 2),   -- Entrega 4: 2 Notebooks
    (5, 2, 3);   -- Entrega 5: 3 Smartphones

-- MEUS SELECT PARA LISTAR NO ENTREGADAO
SELECT
    e.id,
    e.codigo_rastreio,
    e.data_criacao,
    e.data_prevista_entrega,
    e.status,
    e.valor_frete,
    e.observacoes,
-- Remetente
    r.id AS remetente_id,
    r.documento AS remetente_documento,
    r.nome AS remetente_nome,
    r.tipo AS remetente_tipo,
    r.telefone AS remetente_telefone,
    r.email AS remetente_email,
-- Endereço do remetente
    er.logradouro AS remetente_logradouro,
    er.numero AS remetente_numero,
    er.complemento AS remetente_complemento,
    er.bairro AS remetente_bairro,
    er.cidade AS remetente_cidade,
    er.estado AS remetente_estado,
    er.cep AS remetente_cep,
-- Destinatário
    d.id AS destinatario_id,
    d.documento AS destinatario_documento,
    d.nome AS destinatario_nome,
    d.tipo AS destinatario_tipo,
    d.telefone AS destinatario_telefone,
    d.email AS destinatario_email,
-- Endereço do destinatário
    ed.logradouro AS destinatario_logradouro,
    ed.numero AS destinatario_numero,
    ed.complemento AS destinatario_complemento,
    ed.bairro AS destinatario_bairro,
    ed.cidade AS destinatario_cidade,
    ed.estado AS destinatario_estado,
    ed.cep AS destinatario_cep

FROM entrega e
INNER JOIN cliente r ON e.remetente_id = r.id
INNER JOIN cliente d ON e.destinatario_id = d.id
LEFT JOIN endereco er ON r.endereco_id = er.id
LEFT JOIN endereco ed ON d.endereco_id = ed.id
ORDER BY e.data_criacao DESC;

-- MEU SELECT PARA LISTAR NO PRODUTODAOO UvU
SELECT * FROM produto ORDER BY nome;
-- MEU SELECT PARA VER AS MINHAS ENTREGAS COM SEUS PRODUTOS
SELECT
    e.codigo_rastreio,
    e.status,
    r.nome AS remetente,
    d.nome AS destinatario,
    p.nome AS produto,
    ie.quantidade,
    p.valor_unitario,
    (ie.quantidade * p.valor_unitario) AS valor_total_item
FROM entrega e
INNER JOIN cliente r ON e.remetente_id = r.id
INNER JOIN cliente d ON e.destinatario_id = d.id
INNER JOIN item_entrega ie ON e.id = ie.entrega_id
INNER JOIN produto p ON ie.produto_id = p.id
ORDER BY e.data_criacao DESC, p.nome;

-- MEU SELECT PARA BUSCAR MEUS CLIENTES NO CLIENTEDAO
SELECT
    c.*,
    e.logradouro,
    e.numero,
    e.complemento,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep
FROM cliente c
LEFT JOIN endereco e ON c.endereco_id = e.id
WHERE c.documento = '12345678901';

-- MEU SELECT PARA BUSCAR UM PRODUTO DE UMA ENTREGA EXPECIFICAA
SELECT
    p.nome,
    p.peso_kg,
    p.volume_m3,
    p.valor_unitario,
    ie.quantidade,
    (p.valor_unitario * ie.quantidade) AS valor_total
FROM item_entrega ie
INNER JOIN produto p ON ie.produto_id = p.id
WHERE ie.entrega_id = 1  -- Substitua pelo ID da entrega
ORDER BY p.nome;

-- AQUI EU POSSO RASTREIAR MINHA ENTREGA PELO CODIGO
SELECT
    e.*,
    r.nome AS remetente_nome,
    d.nome AS destinatario_nome
FROM entrega e
INNER JOIN cliente r ON e.remetente_id = r.id
INNER JOIN cliente d ON e.destinatario_id = d.id
WHERE e.codigo_rastreio = 'TC20240001';

-- FUNÇÃO PARA CALCULAR O VALOR DO FRETE
CREATE OR REPLACE FUNCTION calcular_valor_entrega(p_entrega_id INTEGER)
RETURNS DECIMAL AS $$
DECLARE
    valor_total DECIMAL;
BEGIN
    SELECT COALESCE(SUM(p.valor_unitario * ie.quantidade), 0) + e.valor_frete
    INTO valor_total
    FROM entrega e
    LEFT JOIN item_entrega ie ON e.id = ie.entrega_id
    LEFT JOIN produto p ON ie.produto_id = p.id
    WHERE e.id = p_entrega_id
    GROUP BY e.id, e.valor_frete;
RETURN valor_total;
END;
$$ LANGUAGE plpgsql;

