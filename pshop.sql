CREATE DATABASE petshop_db;
USE petshop_db;

CREATE TABLE cliente (
  id_cliente INT AUTO_INCREMENT PRIMARY KEY,
  nome_cliente VARCHAR(120) NOT NULL,
  cpf_cliente VARCHAR(14) NOT NULL UNIQUE,
  telefone_cliente VARCHAR(20),
  email_cliente VARCHAR(120)
);

CREATE TABLE servico (
  id_servico INT AUTO_INCREMENT PRIMARY KEY,
  nome_servico VARCHAR(80) NOT NULL UNIQUE,
  preco_servico DECIMAL(8,2) NOT NULL CHECK (preco >= 0),
  duracao_servico INT NOT NULL CHECK (duracao_min > 0)
);

CREATE TABLE pet (
  id_pet INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  nome_pet VARCHAR(80) NOT NULL,
  especie_pet ENUM('canino','felino','outro') NOT NULL,
  porte_pet ENUM('pequeno','medio','grande') NOT NULL,
  nascimento_pet DATE,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE agendamento (
  id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
  id_pet INT NOT NULL,
  id_servico INT NOT NULL,
  dataehora_agendamento DATETIME NOT NULL,
  status_agendamento ENUM('agendado','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  observacoes_agendamento TEXT,
  FOREIGN KEY (id_pet) REFERENCES pet(id_pet),
  FOREIGN KEY (id_servico) REFERENCES servico(id_servico),
  INDEX (data_hora)
);

INSERT INTO servico (nome_servico, preco_servico, duracao_servico) VALUES
('Banho', 50.00, 45),
('Tosa', 80.00, 60),
('Vacina', 120.00, 15),
('Consulta', 90.00, 30);

INSERT INTO cliente (nome_cliente,cpf_cliente, telefone_cliente, email_cliente) VALUES
('Pérola', '123.456.789-00', '11 99999-0001', 'perola@email.com'),
('Maria', '987.654.321-00', '11 98888-0002', 'maria@email.com'),
('Lila', '111.222.333-44', '11 97777-0003', 'lila@email.com');

INSERT INTO pet (id_cliente, nome_pet, especie_pet, porte_pet, nascimento_pet) VALUES
(1, 'Toby', 'canino', 'grande', '2018-05-12'),
(1, 'Lili', 'felino', 'pequeno', '2020-11-02'),
(2, 'Tobias', 'canino', 'medio', '2019-07-20'),
(3, 'Nina', 'felino', 'pequeno', '2021-03-15');

INSERT INTO agendamento (id_pet, id_servico, dataehora_agendamento, status_agendamento, observacoes_agendamento) VALUES
(1, 1, '2025-09-05 10:00:00', 'agendado', 'Banho completo com hidratação'),
(2, 4, '2025-09-06 14:30:00', 'agendado', 'Consulta vacinal anual'),
(3, 2, '2025-09-10 09:00:00', 'agendado', 'Tosa higiênica'),
(4, 3, '2025-09-12 16:00:00', 'agendado', 'Vacina de reforço');