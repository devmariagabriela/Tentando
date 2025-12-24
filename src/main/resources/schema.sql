CREATE DATABASE tartarugacometa;
\c tartarugacometa;

CREATE TABLE endereco(
    id SERIAL PRIMARY KEY,
    logradouro VARCHAR(200) NOT NULL,
	numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep VARCHAR(9) NOT NULL
);

CREATE TABLE cliente(
    id SERIAL PRIMARY KEY,
    documento VARCHAR(14) NOT NULL UNIQUE,
    nome VARCHAR(200) NOT NULL,
    tipo CHAR(1) NOT NULL CHECK (tipo IN ('F', 'J')),
    telefone VARCHAR(20),
    email VARCHAR(100),
    endereco_id INTEGER REFERENCES endereco(id)
);

CREATE TABLE produto(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
	descricao TEXT,
    peso_kg DECIMAL(10,2) NOT NULL CHECK (peso_kg > 0),
    volume_m3 DECIMAL(10,3) NOT NULL CHECK (volume_m3 > 0),
    valor_unitario DECIMAL(10,2) NOT NULL CHECK (valor_unitario >= 0),
    quantidade_estoque INTEGER NOT NULL DEFAULT 0 CHECK (quantidade_estoque >= 0), -- NOVO CAMPO
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE entrega(
    id SERIAL PRIMARY KEY,
    codigo_rastreio VARCHAR(20) UNIQUE NOT NULL,
    data_criacao DATE DEFAULT CURRENT_DATE,
    data_coleta DATE, -- ESTA LINHA DEVE ESTAR AQUI
    data_prevista_entrega DATE NOT NULL,
    data_entrega_realizada DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE',
    valor_frete DECIMAL(10,2) NOT NULL,
    observacoes TEXT,
    remetente_id INTEGER REFERENCES cliente(id) NOT NULL,
    destinatario_id INTEGER REFERENCES cliente(id) NOT NULL,
    endereco_origem_id INTEGER REFERENCES endereco(id),
    endereco_destino_id INTEGER REFERENCES endereco(id)
);


CREATE TABLE item_entrega(
    id SERIAL PRIMARY KEY,
    entrega_id INTEGER REFERENCES entrega(id) ON DELETE CASCADE,
    produto_id INTEGER REFERENCES produto(id),
	quantidade INTEGER NOT NULL CHECK (quantidade > 0)
);

INSERT INTO endereco (logradouro, numero, complemento, bairro, cidade, estado, cep) VALUES

('Rua das Flores', '123', 'Sala 101', 'Centro', 'São Paulo', 'SP', '01001-000'),
('Avenida Brasil', '456', 'Andar 5', 'Jardins', 'Rio de Janeiro', 'RJ', '20040-000'),
('Rua das Palmeiras', '789', 'Casa 2', 'Savassi', 'Belo Horizonte', 'MG', '30130-000'),
('Travessa dos Pinheiros', '321', NULL, 'Vila Mariana', 'São Paulo', 'SP', '04101-000'),
('Alameda Santos', '1000', 'Conjunto 304', 'Jardim Paulista', 'São Paulo', 'SP', '01418-000');

INSERT INTO cliente (documento, nome, tipo, telefone, email, endereco_id) VALUES
('12345678901', 'João Silva', 'F', '(11) 99999-8888', 'joao.silva@email.com', 1),
('98765432000198', 'Tech Solutions LTDA', 'J', '(11) 3333-4444', 'contato@techsolutions.com', 2),
('98765432109', 'Maria Oliveira', 'F', '(21) 98888-7777', 'maria.oliveira@email.com', 3),
('11122233344', 'Carlos Santos', 'F', '(31) 97777-6666', 'carlos.santos@email.com', 4),
('55667788000199', 'Logística Express', 'J', '(11) 2222-3333', 'vendas@logisticaexpress.com', 5);

INSERT INTO produto (nome, descricao, peso_kg, volume_m3, valor_unitario, quantidade_estoque) VALUES -- ALTERADO
('Notebook Dell Inspiron', 'Notebook para uso profissional', 2.3, 0.003, 3500.00, 100), -- ALTERADO
('Smartphone Samsung Galaxy', 'Smartphone Android', 0.25, 0.00015, 2200.00, 100), -- ALTERADO
('Monitor LG 24"', 'Monitor Full HD', 4.5, 0.012, 899.90, 100), -- ALTERADO
('Teclado Mecânico RGB', 'Teclado gamer com iluminação', 1.2, 0.002, 299.00, 100), -- ALTERADO
('Mouse Gamer', 'Mouse com sensor óptico', 0.15, 0.0003, 150.00, 100), -- ALTERADO
('Tablet Apple iPad', 'Tablet iOS', 0.48, 0.0008, 4200.00, 100), -- ALTERADO
('Impressora Multifuncional', 'Impressora, scanner e copiadora', 8.7, 0.025, 650.00, 100); -- ALTERADO

INSERT INTO entrega (codigo_rastreio, data_criacao, data_prevista_entrega, status, valor_frete, observacoes, remetente_id, destinatario_id) VALUES
('TC20240001', '2024-01-15', '2024-01-20', 'PENDENTE', 45.50, 'Fragil - Manuseio com cuidado', 2, 1),
('TC20240002', '2024-01-16', '2024-01-22', 'EM_TRANSITO', 60.00, 'Entregar apenas para o destinatário', 1, 3),
('TC20240003', '2024-01-10', '2024-01-12', 'ENTREGUE', 35.00, 'Já entregue - confirmar recebimento', 5, 4),
('TC20240004', '2024-01-17', '2024-01-25', 'PENDENTE', 75.00, 'Produto de alto valor', 3, 2),
('TC20240005', '2024-01-14', '2024-01-18', 'CANCELADA', 40.00, 'Cancelada a pedido do cliente', 4, 5);


INSERT INTO item_entrega (entrega_id, produto_id, quantidade) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(2, 4, 1),
(2, 5, 1),
(3, 6, 1),
(4, 7, 1),
(4, 1, 2),
(5, 2, 3);

CREATE INDEX idx_entrega_rastreio ON entrega(codigo_rastreio);
CREATE INDEX idx_cliente_documento ON cliente(documento);
CREATE INDEX idx_item_entrega_id ON item_entrega(entrega_id);

CREATE VIEW relatorio_entregas AS
SELECT 
    e.codigo_rastreio,
    e.data_criacao,
    e.data_prevista_entrega,
    e.status,
    e.valor_frete,
    r.nome as remetente,
    d.nome as destinatario,
    COUNT(ie.id) as quantidade_itens,
    SUM(ie.quantidade) as total_produtos
FROM entrega e
JOIN cliente r ON e.remetente_id = r.id
JOIN cliente d ON e.destinatario_id = d.id
LEFT JOIN item_entrega ie ON e.id = ie.entrega_id
GROUP BY e.id, e.codigo_rastreio, e.data_criacao, e.data_prevista_entrega, 
         e.status, e.valor_frete, r.nome, d.nome;

CREATE OR REPLACE FUNCTION gerar_codigo_rastreio()
RETURNS VARCHAR(20) AS $$
DECLARE
    novo_codigo VARCHAR(20);
    ano_atual VARCHAR(4);
    sequencia INTEGER;
BEGIN
    ano_atual := EXTRACT(YEAR FROM CURRENT_DATE)::VARCHAR;
    
    SELECT COALESCE(MAX(SUBSTRING(codigo_rastreio FROM 10 FOR 4)::INTEGER), 0) + 1
    INTO sequencia
    FROM entrega
    WHERE codigo_rastreio LIKE 'TC' || ano_atual || '%';
    
    novo_codigo := 'TC' || ano_atual || LPAD(sequencia::VARCHAR, 4, '0');
    
    RETURN novo_codigo;
END;
$$ LANGUAGE plpgsql;

SELECT 'Endereços: ' || COUNT(*) FROM endereco
UNION ALL
SELECT 'Clientes: ' || COUNT(*) FROM cliente
UNION ALL
SELECT 'Produtos: ' || COUNT(*) FROM produto
UNION ALL
SELECT 'Entregas: ' || COUNT(*) FROM entrega
UNION ALL
SELECT 'Itens de Entrega: ' || COUNT(*) FROM item_entrega;