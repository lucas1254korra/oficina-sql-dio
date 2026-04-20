USE oficina_desafio_logico;



-- Inserindo Clientes

INSERT INTO Cliente (nome, cpf_cnpj, telefone, tipoCliente) VALUES 

('João Silva', '11122233344', '11988887777', 'PF'),

('Empresa Logística SA', '12345678000199', '1133334444', 'PJ');



-- Inserindo Veículos

INSERT INTO Veiculo (idCliente, placa, marca, modelo, anoModelo, cor, quilometragem) VALUES 

(1, 'ABC1D23', 'Honda', 'Civic', 2019, 'Prata', 45000),

(2, 'XYZ9W87', 'Fiat', 'Fiorino', 2021, 'Branca', 120000);



-- Inserindo Equipes

INSERT INTO Equipe (nomeEquipe, especialidade) VALUES 

('Equipe Alpha', 'Motor e Transmissão'),

('Equipe Beta', 'Suspensão e Freios');



-- Inserindo Mecânicos

INSERT INTO Mecanico (idEquipe, nome, dataAdmissao, especialidade) VALUES 

(1, 'Carlos Mendes', '2020-01-15', 'Motores Diesel'),

(1, 'Roberto Souza', '2021-05-20', 'Injeção Eletrônica'),

(2, 'Fernando Costa', '2019-11-10', 'Alinhamento e Freios');



-- Inserindo Referências e Serviços

INSERT INTO Referencia (descricao, valorHora, complexidade, dataVigencia) VALUES 

('Mão de Obra Mecânica Geral', 150.00, 'Média', '2023-01-01');



INSERT INTO Servico (idReferencia, descricao, categoria, tempoEstimado, valorPadrao) VALUES 

(1, 'Troca de Óleo e Filtros', 'Manutenção Preventiva', 1.00, 150.00),

(1, 'Retífica de Cabeçote', 'Motor', 8.00, 1200.00),

(1, 'Troca de Pastilhas de Freio', 'Freios', 2.00, 300.00);



-- Inserindo Peças

INSERT INTO Peca (codigoPeca, nomePeca, fabricante, valorUnitario, estoqueAtual) VALUES 

('OL-5W40', 'Óleo Sintético 5W40 1L', 'Castrol', 55.00, 100),

('FL-001', 'Filtro de Óleo', 'Fram', 35.00, 50),

('PF-909', 'Jogo de Pastilhas Dianteiras', 'Cobreq', 180.00, 20);



-- Inserindo Ordem de Serviço

INSERT INTO Ordem_Servico (idVeiculo, idEquipe, numeroOs, status, tipoAtendimento, valorTotal) VALUES 

(1, 1, 'OS-2023-0001', 'Concluída', 'Revisão', 350.00),

(2, 2, 'OS-2023-0002', 'Em Andamento', 'Conserto', 480.00);



-- Inserindo Itens na OS 1 (Revisão do Civic)

INSERT INTO ItemOS_Servico (idOrdemServico, idServico, quantidade, valorAplicado) VALUES 

(1, 1, 1, 150.00); -- Troca de óleo

INSERT INTO ItemOS_Peca (idOrdemServico, idPeca, quantidade, valorAplicado) VALUES 

(1, 1, 4, 55.00), -- 4 Litros de Óleo (220.00)

(1, 2, 1, 35.00); -- 1 Filtro (35.00)

-- Total Real OS 1: 150 + 220 + 35 = 405.00



-- Inserindo Itens na OS 2 (Freios da Fiorino)

INSERT INTO ItemOS_Servico (idOrdemServico, idServico, quantidade, valorAplicado) VALUES 

(2, 3, 1, 300.00); -- Troca de pastilhas

INSERT INTO ItemOS_Peca (idOrdemServico, idPeca, quantidade, valorAplicado) VALUES 

(2, 3, 1, 180.00); -- Pastilhas

-- Total Real OS 2: 300 + 180 = 480.00