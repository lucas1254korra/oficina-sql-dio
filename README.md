# Sistema de Gestão para Oficina Mecânica - SQL Project

Este projeto contém a modelagem lógica e física de um banco de dados relacional para o contexto de uma Oficina Mecânica, construído como parte de um desafio de projeto de modelagem de BD.

## 🎯 Objetivo
Transformar um esquema conceitual (Diagrama ER) em um esquema lógico rigoroso e, em seguida, implementá-lo através de scripts SQL (DDL e DML). O projeto resolve as complexidades de relacionamentos N:M entre Ordens de Serviço (OS), Peças e Serviços executados.

## 🗄️ Estrutura do Banco de Dados
A modelagem contempla as seguintes entidades e suas interações:
- **Gestão de Clientes e Veículos:** Relação 1:N garantindo o histórico de carros por proprietário.
- **Operacional:** Controle de Equipes e Mecânicos (1:N).
- **Catálogo:** Tabelas de Serviços, Valores de Referência e Inventário de Peças.
- **Transacional (Core):** A Ordem de Serviço (OS) atua como a entidade central, ligando-se a Peças e Serviços através de tabelas associativas para garantir a integridade financeira e de estoque.

## 📊 Consultas Desenvolvidas (Queries)
O repositório contém um script focado em responder perguntas de negócio complexas utilizando:
- Junções de múltiplas tabelas (`JOIN`).
- Filtros rigorosos (`WHERE`).
- Expressões e atributos derivados para cálculos financeiros.
- Agrupamentos e filtros sobre grupos (`GROUP BY` e `HAVING`).
- Ordenações detalhadas (`ORDER BY`).
