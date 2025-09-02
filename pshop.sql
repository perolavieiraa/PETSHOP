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
  cliente_id INT NOT NULL,
  nome_pet VARCHAR(80) NOT NULL,
  especie_pet ENUM('canino','felino','outro') NOT NULL,
  porte_pet ENUM('pequeno','medio','grande') NOT NULL,
  nascimento_pet DATE,
  FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

CREATE TABLE agendamento (
  id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
  pet_id INT NOT NULL,
  servico_id INT NOT NULL,
  dataehora_agendamento DATETIME NOT NULL,
  status_agendamento ENUM('agendado','concluido','cancelado') NOT NULL DEFAULT 'agendado',
  observacoes_agendamento TEXT,
  FOREIGN KEY (id_pet) REFERENCES pet(id_pet),
  FOREIGN KEY (id_servico) REFERENCES servico(id_servico),
  INDEX (data_hora)
);