CREATE DATABASE MarinkeP2;
-- Criação do banco de dados
USE MarinkeP2;
-- Tabela cliente
CREATE TABLE cliente (
    idcliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45) NOT NULL
);

-- Tabela mesa
CREATE TABLE mesa (
    idmesa INT AUTO_INCREMENT PRIMARY KEY,
    status_mesa VARCHAR(45) NOT NULL
);

-- Tabela cliente_mesa (relaciona cliente e mesa)
CREATE TABLE cliente_mesa (
    idcliente_mesa INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_mesa INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(idcliente),
    FOREIGN KEY (id_mesa) REFERENCES mesa(idmesa)
);

-- Tabela pedido
CREATE TABLE pedido (
    idpedido INT AUTO_INCREMENT PRIMARY KEY,
    idmesa INT NOT NULL,
    data_pedido DATE NOT NULL,
    FOREIGN KEY (idmesa) REFERENCES mesa(idmesa)
);

-- Tabela produto
CREATE TABLE produto (
    idproduto INT AUTO_INCREMENT PRIMARY KEY,
    produtoscol VARCHAR(45) NOT NULL,
    codigo_produto INT NOT NULL,
    nome_produto VARCHAR(45) NOT NULL,
    quantidade_estoque_produto INT NOT NULL,
    estoque_minimo_produto INT NOT NULL,
    marca_produto VARCHAR(45) NOT NULL
);

-- Tabela produto_pedido (relaciona produto e pedido)
CREATE TABLE produto_pedido (
    idproduto_pedido INT AUTO_INCREMENT PRIMARY KEY,
    idpedido INT NOT NULL,
    idproduto INT NOT NULL,
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido),
    FOREIGN KEY (idproduto) REFERENCES produto(idproduto)
);

-- Tabela financeiro
CREATE TABLE financeiro (
    idfinanceiro INT AUTO_INCREMENT PRIMARY KEY,
    data_pagamento DATE NOT NULL,
    valor_total FLOAT NOT NULL,
    forma_pagamento VARCHAR(45) NOT NULL
);

-- Tabela pedido_financeiro (relaciona pedido e financeiro)
CREATE TABLE pedido_financeiro (
    idpedido_financeiro INT AUTO_INCREMENT PRIMARY KEY,
    idfinanceiro INT NOT NULL,
    idpedido INT NOT NULL,
    FOREIGN KEY (idfinanceiro) REFERENCES financeiro(idfinanceiro),
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido)
);

-- Tabela vendas_diarias (relaciona vendas por dia e pedido)
CREATE TABLE vendas_diarias (
    idvendas_diarias INT AUTO_INCREMENT PRIMARY KEY,
    data_dia DATE NOT NULL,
    idpedido INT NOT NULL,
    FOREIGN KEY (idpedido) REFERENCES pedido(idpedido)
);

-- Tabela funcionario
CREATE TABLE funcionario (
    idfuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome_funcionario VARCHAR(45) NOT NULL,
    cargo VARCHAR(45) NOT NULL
);

-- Tabela funcionario_mesa (relaciona funcionario e mesa - muitos para muitos)
CREATE TABLE funcionario_mesa (
    idfuncionario_mesa INT AUTO_INCREMENT PRIMARY KEY,
    idfuncionario INT NOT NULL,
    idmesa INT NOT NULL,
    FOREIGN KEY (idfuncionario) REFERENCES funcionario(idfuncionario),
    FOREIGN KEY (idmesa) REFERENCES mesa(idmesa)
);

-- Inserindo dados na tabela cliente
INSERT INTO cliente (nome) VALUES
('João Silva'),
('Maria Oliveira'),
('Carlos Santos'),
('Ana Paula'),
('Pedro Lima');

-- Inserindo dados na tabela mesa
INSERT INTO mesa (status_mesa) VALUES
('Disponível'),
('Ocupada'),
('Reservada'),
('Disponível'),
('Ocupada');

-- Inserindo dados na tabela cliente_mesa
INSERT INTO cliente_mesa (id_cliente, id_mesa) VALUES
(1, 2),
(2, 3),
(3, 4),
(4, 5),
(5, 1);

-- Inserindo dados na tabela pedido
INSERT INTO pedido (idmesa, data_pedido) VALUES
(2, '2024-11-26'),
(3, '2024-11-26'),
(4, '2024-11-27'),
(5, '2024-11-27'),
(1, '2024-11-27');

-- Inserindo dados na tabela produto
INSERT INTO produto (produtoscol, codigo_produto, nome_produto, quantidade_estoque_produto, estoque_minimo_produto, marca_produto) VALUES
('001', 1001, 'Hamburguer', 50, 5, 'FastFood Inc.'),
('002', 1002, 'Pizza', 20, 2, 'Italian Taste'),
('003', 1003, 'Refrigerante', 100, 10, 'Drink Co.'),
('004', 1004, 'Salada', 30, 3, 'Fresh Greens'),
('005', 1005, 'Sobremesa', 15, 2, 'Sweet Treats');

-- Inserindo dados na tabela produto_pedido
INSERT INTO produto_pedido (idpedido, idproduto) VALUES
(1, 1),
(1, 3),
(2, 2),
(2, 4),
(3, 1),
(3, 5),
(4, 2),
(5, 3);

-- Inserindo dados na tabela financeiro
INSERT INTO financeiro (data_pagamento, valor_total, forma_pagamento) VALUES
('2024-11-26', 45.50, 'Cartão de Crédito'),
('2024-11-26', 30.00, 'Dinheiro'),
('2024-11-27', 60.00, 'Cartão de Débito'),
('2024-11-27', 25.00, 'Pix'),
('2024-11-27', 50.00, 'Dinheiro');

-- Inserindo dados na tabela pedido_financeiro
INSERT INTO pedido_financeiro (idfinanceiro, idpedido) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserindo dados na tabela vendas_diarias
INSERT INTO vendas_diarias (data_dia, idpedido) VALUES
('2024-11-26', 1),
('2024-11-26', 2),
('2024-11-27', 3),
('2024-11-27', 4),
('2024-11-27', 5);

-- Inserindo dados na tabela funcionario
INSERT INTO funcionario (nome_funcionario, cargo) VALUES
('Carlos Pereira', 'Garçom'),
('Mariana Souza', 'Garçonete'),
('Fernanda Lima', 'Supervisora'),
('João Mendes', 'Garçom'),
('Juliana Costa', 'Atendente');

-- Inserindo dados na tabela funcionario_mesa
INSERT INTO funcionario_mesa (idfuncionario, idmesa) VALUES
(1, 2),
(1, 3),
(2, 3),
(2, 4),
(3, 5),
(4, 1),
(5, 2),
(5, 4);

DELIMITER $$

CREATE PROCEDURE redefinir_status_livre(IN p_idmesa INT)
BEGIN
    UPDATE mesa
    SET status_mesa = 'Livre'
    WHERE idmesa = p_idmesa;
END $$

DELIMITER ;
