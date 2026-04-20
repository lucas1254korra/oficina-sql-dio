USE oficina_db;



-- ==============================================================================

-- 1. Recuperações simples com SELECT Statement

-- Pergunta: Quais são os nomes, fabricantes e valores das peças cadastradas no sistema?

-- ==============================================================================

SELECT 

    nomePeca, 

    fabricante, 

    valorUnitario 

FROM Peca;





-- ==============================================================================

-- 2. Filtros com WHERE Statement e Ordenações dos dados com ORDER BY

-- Pergunta: Quais são os veículos cadastrados do ano 2020 em diante, ordenados do mais novo para o mais antigo?

-- ==============================================================================

SELECT 

    placa, 

    marca, 

    modelo, 

    anoModelo 

FROM Veiculo 

WHERE anoModelo >= 2020

ORDER BY anoModelo DESC;





-- ==============================================================================

-- 3. Crie expressões para gerar atributos derivados

-- Pergunta: Qual é o custo total projetado para o estoque atual de cada peça na oficina?

-- (Expressão matemática: valorUnitario * estoqueAtual)

-- ==============================================================================

SELECT 

    codigoPeca,

    nomePeca,

    estoqueAtual,

    valorUnitario,

    (estoqueAtual * valorUnitario) AS ValorTotalEmEstoque

FROM Peca

ORDER BY ValorTotalEmEstoque DESC;





-- ==============================================================================

-- 4. Junções entre tabelas (JOIN) para perspectiva complexa

-- Pergunta: Qual é o relatório detalhado de todas as Ordens de Serviço, mostrando o nome do cliente, 

-- a placa do carro, a equipe responsável e o status do serviço?

-- ==============================================================================

SELECT 

    os.numeroOs,

    c.nome AS Cliente,

    v.placa AS Veiculo,

    e.nomeEquipe AS Equipe,

    os.status,

    os.tipoAtendimento

FROM Ordem_Servico os

INNER JOIN Veiculo v ON os.idVeiculo = v.idVeiculo

INNER JOIN Cliente c ON v.idCliente = c.idCliente

INNER JOIN Equipe e ON os.idEquipe = e.idEquipe;





-- ==============================================================================

-- 5. Condições de filtros aos grupos – HAVING Statement (com JOIN e Agregação)

-- Pergunta: Quais equipes possuem mais de 1 mecânico alocado atualmente?

-- ==============================================================================

SELECT 

    e.nomeEquipe,

    COUNT(m.idMecanico) AS TotalMecanicos

FROM Equipe e

INNER JOIN Mecanico m ON e.idEquipe = m.idEquipe

WHERE m.status = 'Ativo'

GROUP BY e.nomeEquipe

HAVING COUNT(m.idMecanico) > 1;





-- ==============================================================================

-- 6. QUERY BÔNUS (Análise Avançada com Múltiplos Joins e Expressões Derivadas)

-- Pergunta: O valor gravado na Ordem de Serviço condiz com a soma real das peças 

-- e serviços executados? (Auditoria de faturamento / Prevenção a divergências)

-- ==============================================================================

SELECT 

    os.numeroOs,

    os.valorTotal AS ValorRegistradoNaOS,

    COALESCE(SUM(srv.quantidade * srv.valorAplicado), 0) AS TotalServicos,

    COALESCE(SUM(pec.quantidade * pec.valorAplicado), 0) AS TotalPecas,

    -- Expressão derivada somando tabelas filhas:

    (COALESCE(SUM(srv.quantidade * srv.valorAplicado), 0) + COALESCE(SUM(pec.quantidade * pec.valorAplicado), 0)) AS ValorCalculadoReal,

    -- Validação lógica:

    CASE 

        WHEN os.valorTotal = (COALESCE(SUM(srv.quantidade * srv.valorAplicado), 0) + COALESCE(SUM(pec.quantidade * pec.valorAplicado), 0)) 

        THEN 'OK - Valores Batem'

        ELSE 'DIVERGÊNCIA IDENTIFICADA'

    END AS StatusAuditoria

FROM Ordem_Servico os

LEFT JOIN ItemOS_Servico srv ON os.idOrdemServico = srv.idOrdemServico

LEFT JOIN ItemOS_Peca pec ON os.idOrdemServico = pec.idOrdemServico

GROUP BY os.idOrdemServico, os.numeroOs, os.valorTotal;