
-- Tabela de Endereços
CREATE TABLE endereco (
    id SERIAL PRIMARY KEY,
    cep VARCHAR(9) NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(20) NOT NULL,
    complemento VARCHAR(100),
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Clientes (Remetente e Destinatário)
CREATE TABLE cliente (
    id SERIAL PRIMARY KEY,
    tipo_documento VARCHAR(4) NOT NULL CHECK (tipo_documento IN ('CPF', 'CNPJ')),
    documento VARCHAR(18) NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    endereco_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (endereco_id) REFERENCES endereco(id) ON DELETE RESTRICT
);

-- Índice para busca rápida por documento
CREATE INDEX idx_cliente_documento ON cliente(documento);

-- Tabela de Produtos
CREATE TABLE produto (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    peso_kg DECIMAL(10, 2) NOT NULL CHECK (peso_kg > 0),
    volume_m3 DECIMAL(10, 3) NOT NULL CHECK (volume_m3 > 0),
    valor_unitario DECIMAL(10, 2) NOT NULL CHECK (valor_unitario >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de Entregas
CREATE TABLE entrega (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    remetente_id INTEGER NOT NULL,
    destinatario_id INTEGER NOT NULL,
    endereco_origem_id INTEGER NOT NULL,
    endereco_destino_id INTEGER NOT NULL,
    data_coleta DATE NOT NULL,
    data_entrega_prevista DATE NOT NULL,
    data_entrega_realizada DATE,
    status VARCHAR(20) NOT NULL DEFAULT 'PENDENTE' CHECK (status IN ('PENDENTE', 'EM_TRANSITO', 'REALIZADA', 'CANCELADA')),
    valor_frete DECIMAL(10, 2) NOT NULL CHECK (valor_frete >= 0),
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (remetente_id) REFERENCES cliente(id) ON DELETE RESTRICT,
    FOREIGN KEY (destinatario_id) REFERENCES cliente(id) ON DELETE RESTRICT,
    FOREIGN KEY (endereco_origem_id) REFERENCES endereco(id) ON DELETE RESTRICT,
    FOREIGN KEY (endereco_destino_id) REFERENCES endereco(id) ON DELETE RESTRICT
);

-- Índice para busca rápida por código
CREATE INDEX idx_entrega_codigo ON entrega(codigo);

-- Índice para busca por status
CREATE INDEX idx_entrega_status ON entrega(status);

-- Tabela de Itens da Entrega (Relacionamento Entrega-Produto)
CREATE TABLE item_entrega (
    id SERIAL PRIMARY KEY,
    entrega_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL CHECK (quantidade > 0),
    valor_total DECIMAL(10, 2) NOT NULL CHECK (valor_total >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (entrega_id) REFERENCES entrega(id) ON DELETE CASCADE,
    FOREIGN KEY (produto_id) REFERENCES produto(id) ON DELETE RESTRICT
);

-- Índice para busca de itens por entrega
CREATE INDEX idx_item_entrega_entrega_id ON item_entrega(entrega_id);

-- Função para atualizar o campo updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para atualizar updated_at na tabela entrega
CREATE TRIGGER update_entrega_updated_at
BEFORE UPDATE ON entrega
FOR EACH ROW
EXECUTE FUNCTION update_updated_at_column();



-- Inserir alguns endereços de exemplo
INSERT INTO endereco (cep, logradouro, numero, complemento, bairro, cidade, estado) VALUES
('01310-100', 'Avenida Paulista', '1578', NULL, 'Bela Vista', 'São Paulo', 'SP'),
('22250-040', 'Avenida Atlântica', '1702', 'Apto 501', 'Copacabana', 'Rio de Janeiro', 'RJ'),
('30130-010', 'Avenida Afonso Pena', '867', NULL, 'Centro', 'Belo Horizonte', 'MG');

-- Inserir alguns clientes de exemplo
INSERT INTO cliente (tipo_documento, documento, nome, telefone, email, endereco_id) VALUES
('CNPJ', '12.345.678/0001-90', 'Empresa ABC Ltda', '(11) 3456-7890', 'contato@empresaabc.com.br', 1),
('CPF', '123.456.789-00', 'João da Silva', '(21) 98765-4321', 'joao.silva@email.com', 2),
('CNPJ', '98.765.432/0001-10', 'Comércio XYZ S.A.', '(31) 2345-6789', 'vendas@comercioxyz.com.br', 3);

-- Inserir alguns produtos de exemplo
INSERT INTO produto (nome, descricao, peso_kg, volume_m3, valor_unitario) VALUES
('Caixa de Eletrônicos', 'Caixa contendo equipamentos eletrônicos diversos', 15.50, 0.125, 2500.00),
('Documentos Importantes', 'Envelope com documentos contratuais', 0.50, 0.005, 0.00),
('Móveis Desmontados', 'Conjunto de móveis desmontados para escritório', 85.00, 1.500, 3500.00);