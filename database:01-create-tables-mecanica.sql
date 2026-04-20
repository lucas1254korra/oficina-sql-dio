CREATE DATABASE IF NOT EXISTS oficina_db;

USE oficina_db;



-- 1. Cliente

CREATE TABLE Cliente (

    idCliente INT AUTO_INCREMENT PRIMARY KEY,

    nome VARCHAR(150) NOT NULL,

    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,

    telefone VARCHAR(20),

    email VARCHAR(150),

    endereco VARCHAR(255),

    tipoCliente ENUM('PF', 'PJ') NOT NULL,

    dataCadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);



-- 2. Veiculo

CREATE TABLE Veiculo (

    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,

    idCliente INT NOT NULL,

    placa VARCHAR(10) UNIQUE NOT NULL,

    marca VARCHAR(50) NOT NULL,

    modelo VARCHAR(50) NOT NULL,

    anoModelo INT NOT NULL,

    cor VARCHAR(30),

    quilometragem INT,

    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente) ON DELETE CASCADE

);



-- 3. Equipe

CREATE TABLE Equipe (

    idEquipe INT AUTO_INCREMENT PRIMARY KEY,

    nomeEquipe VARCHAR(100) NOT NULL,

    especialidade VARCHAR(100),

    status ENUM('Ativa', 'Inativa') DEFAULT 'Ativa'

);



-- 4. Mecanico

CREATE TABLE Mecanico (

    idMecanico INT AUTO_INCREMENT PRIMARY KEY,

    idEquipe INT NOT NULL,

    nome VARCHAR(150) NOT NULL,

    endereco VARCHAR(255),

    telefone VARCHAR(20),

    dataAdmissao DATE NOT NULL,

    especialidade VARCHAR(100),

    status ENUM('Ativo', 'Férias', 'Inativo') DEFAULT 'Ativo',

    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)

);



-- 5. Referencia (Tabela de preços base)

CREATE TABLE Referencia (

    idReferencia INT AUTO_INCREMENT PRIMARY KEY,

    descricao VARCHAR(100) NOT NULL,

    valorHora DECIMAL(10,2) NOT NULL,

    complexidade ENUM('Baixa', 'Média', 'Alta') NOT NULL,

    dataVigencia DATE NOT NULL

);



-- 6. Servico

CREATE TABLE Servico (

    idServico INT AUTO_INCREMENT PRIMARY KEY,

    idReferencia INT,

    descricao VARCHAR(150) NOT NULL,

    categoria VARCHAR(100),

    tempoEstimado DECIMAL(5,2) COMMENT 'Tempo em horas',

    valorPadrao DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (idReferencia) REFERENCES Referencia(idReferencia)

);



-- 7. Peca

CREATE TABLE Peca (

    idPeca INT AUTO_INCREMENT PRIMARY KEY,

    codigoPeca VARCHAR(50) UNIQUE NOT NULL,

    nomePeca VARCHAR(150) NOT NULL,

    fabricante VARCHAR(100),

    valorUnitario DECIMAL(10,2) NOT NULL,

    estoqueAtual INT NOT NULL DEFAULT 0,

    estoqueMinimo INT NOT NULL DEFAULT 5

);



-- 8. Ordem de Servico (OS)

CREATE TABLE Ordem_Servico (

    idOrdemServico INT AUTO_INCREMENT PRIMARY KEY,

    idVeiculo INT NOT NULL,

    idEquipe INT NOT NULL,

    numeroOs VARCHAR(20) UNIQUE NOT NULL,

    dataAbertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    dataPrevistaConclusao DATE,

    dataConclusao DATE,

    status ENUM('Aguardando Avaliação', 'Aprovada', 'Em Andamento', 'Concluída', 'Cancelada') NOT NULL,

    tipoAtendimento ENUM('Revisão', 'Conserto', 'Sinistro') NOT NULL,

    valorTotal DECIMAL(10,2) DEFAULT 0.00,

    observacoes TEXT,

    FOREIGN KEY (idVeiculo) REFERENCES Veiculo(idVeiculo),

    FOREIGN KEY (idEquipe) REFERENCES Equipe(idEquipe)

);



-- 9. Tabela Associativa: Itens da OS (Servicos)

CREATE TABLE ItemOS_Servico (

    idOrdemServico INT NOT NULL,

    idServico INT NOT NULL,

    quantidade INT NOT NULL DEFAULT 1,

    valorAplicado DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (idOrdemServico, idServico),

    FOREIGN KEY (idOrdemServico) REFERENCES Ordem_Servico(idOrdemServico) ON DELETE CASCADE,

    FOREIGN KEY (idServico) REFERENCES Servico(idServico)

);



-- 10. Tabela Associativa: Itens da OS (Pecas)

CREATE TABLE ItemOS_Peca (

    idOrdemServico INT NOT NULL,

    idPeca INT NOT NULL,

    quantidade INT NOT NULL,

    valorAplicado DECIMAL(10,2) NOT NULL,

    PRIMARY KEY (idOrdemServico, idPeca),

    FOREIGN KEY (idOrdemServico) REFERENCES Ordem_Servico(idOrdemServico) ON DELETE CASCADE,

    FOREIGN KEY (idPeca) REFERENCES Peca(idPeca)

);