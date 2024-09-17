CREATE SCHEMA Fly4Life_2;

USE Fly4Life_2;

-- Tabela de Aeronaves
CREATE TABLE Aeronave (
    Matricula VARCHAR(10) PRIMARY KEY,
    Fabricante VARCHAR(50),
    Modelo VARCHAR(50),
    Nome VARCHAR(50),
    AnoFabrico INT,
    DataOperacao DATE,
    Estado ENUM('Operacional', 'Inoperacional'),
    Disponibilidade BOOLEAN
);

-- Tabela de Pilotos
CREATE TABLE Piloto (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50),
    Categoria ENUM('Comandante', 'Copiloto'),
    ComandanteId INT,
    Inicio_Carreira YEAR,
    Licenca VARCHAR(20),
    Validade DATE,
    FOREIGN KEY (ComandanteId) REFERENCES Piloto(Id)
);

-- Tabela de Locais
CREATE TABLE Local (
    COD CHAR(3) PRIMARY KEY,
    Pais VARCHAR(50),
    Localidade VARCHAR(50)
);

-- Tabela de Missões
CREATE TABLE Missao (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50),
    DataInicio DATE,
    LocalidadeDestino CHAR(3),
    MatriculaAeronave VARCHAR(10),
    ComandanteId INT,
    Relatorio TEXT,
    FOREIGN KEY (LocalidadeDestino) REFERENCES Local(COD),
    FOREIGN KEY (MatriculaAeronave) REFERENCES Aeronave(Matricula),
    FOREIGN KEY (ComandanteId) REFERENCES Piloto(Id)
);

-- Tabela de Equipa
CREATE TABLE Equipa (
    MissaoId INT,
    CopilotoId INT,
    PRIMARY KEY (MissaoId, CopilotoId),
    FOREIGN KEY (MissaoId) REFERENCES Missao(Id),
    FOREIGN KEY (CopilotoId) REFERENCES Piloto(Id)
);

-- Tabela de Manutenção
CREATE TABLE Manutencao (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    MatriculaAeronave VARCHAR(10),
    Data DATE,
    Descricao TEXT,
    FOREIGN KEY (MatriculaAeronave) REFERENCES Aeronave(Matricula)
);

-- Inserção de Dados de Exemplo
INSERT INTO Aeronave (Matricula, Fabricante, Modelo, Nome, AnoFabrico, DataOperacao, Estado, Disponibilidade)
VALUES 
('FL-332', 'Cessena', 'CS-E 37', 'Falcão', 1993, '2003-12-02', 'Operacional', TRUE),
('FL-345', 'Embraer', 'E-12', 'Cegonha', 1999, '2005-03-12', 'Operacional', False),
('FL-532', 'Focker', '100', 'Albatroz', 2002, '2008-10-23', 'Operacional', TRUE),
('FL-023', 'Douglas', 'DC-3', 'Aguia', 1968, '1999-03-14', 'Operacional', TRUE),
('FL-022', 'Cessena', 'CS-Caravan', 'Gaivota', 1998, '1999-05-21', 'Operacional', TRUE);

INSERT INTO Piloto (Nome, Categoria, ComandanteId, Inicio_Carreira, Licenca, Validade)
VALUES 
('Gago Coutinho', 'Comandante', NULL, 1983, 'PT-33224', '2025-01-01'),
('Alberto Castro', 'Comandante', NULL, 1992, 'US-5544332', '2027-01-01'),
('Sacadura Cabral', 'Copiloto', 1, 2008, 'JP-425533263', '2024-07-01'), -- 
('António Maya', 'Copiloto', 2, 1991, 'FR-2235543', '2026-01-01');

INSERT INTO Local (COD, Pais, Localidade)
VALUES 
('LIS', 'Portugal', 'Lisboa'),
('OPO', 'Portugal', 'Porto'),
('MPT', 'Moçambique', 'Maputo'),
('GOA', 'Índia', 'Goa'),
('DLO', 'Costa do Marfim', 'Daloa'),
('KNM', 'Serra Leoa', 'Kenema'),
('BMD', 'Camarões', 'Bamenda');

INSERT INTO Missao (Nome, DataInicio, LocalidadeDestino, MatriculaAeronave, ComandanteId, Relatorio)
VALUES 
('Maputo Aid', '2015-06-09', 'MPT', 'FL-023', 3, 'Missão completada com sucesso. Nenhum problema encontrado.'),
('Sarampo Daloa', '2015-02-12', 'DLO', 'FL-532', 1, 'Relatório da missão: Entrega bem-sucedida. Verificar o motor.'),
('Fome Kenema', '2015-03-06', 'KNM', 'FL-532', 1, 'Relatório da missão: Entrega bem-sucedida. Sem problemas.'),
('Fome Kenema', '2024-06-01', 'KNM', 'FL-532', 4,  'Relatório da missão: Entrega bem-sucedida. Alguns problemas.');


INSERT INTO Equipa (MissaoId, CopilotoId)
VALUES 
(1, 2),
(2, 4),
(3, 2), 
(4, 2);
-- (5, 2); -- Não deixa porque não foi criada uma missão 5

SELECT Nome, Categoria FROM Piloto WHERE Id = 1;
SELECT Nome, Categoria FROM Piloto WHERE Id = 2;
SELECT Nome, Categoria FROM Piloto WHERE Id = 3;
SELECT Nome, Categoria FROM Piloto WHERE Id = 4;

INSERT INTO Manutencao (MatriculaAeronave, Data, Descricao)
VALUES 
('FL-532', '2015-02-13', 'Verificação do motor realizada e reparação concluída.'),
('FL-023', '2015-06-10', 'Inspeção geral pós-missão. Nenhum problema encontrado.');

USE fly4life_2;

select * from aeronave;
select * from equipa;
select * from local;
select * from manutencao;
select * from missao;
select * from piloto;


-- 1. Obter a lista de todos os comandantes e missões em que eventualmente participaram
-- Acabado

SELECT p.Nome as Comandante, p.Categoria, m.Nome as missão, l.Localidade, l.COD, m.DataInicio
FROM Piloto p
LEFT JOIN Missao m ON p.Id = m.ComandanteId
LEFT JOIN Local l ON m.LocalidadeDestino = l.COD
WHERE p.Categoria = 'Comandante';

-- 2. Obter a lista de todas as missões indicando o nome e matrícula do avião e o Comandante, ordenado ascendentemente por nome do avião
-- Acabado

SELECT m.Nome, l.Localidade, l.Pais, a.Nome, a.Matricula, p.Nome
FROM Missao m
LEFT JOIN Aeronave a ON m.MatriculaAeronave = a.Matricula
LEFT JOIN Piloto p ON m.ComandanteId = p.Id
LEFT JOIN Local l ON m.LocalidadeDestino = l.COD
ORDER BY a.Nome ASC;

-- 3. Quantas missões foram executadas por um piloto ou copiloto num período?
-- Acabado

SELECT p.Nome AS Piloto, COUNT(m.Id) AS NumeroDeMissoes
FROM Piloto p
LEFT JOIN Missao m ON p.Id = m.ComandanteId  OR p.Id IN (SELECT CopilotoId FROM Equipa WHERE MissaoId = m.Id)
WHERE m.DataInicio BETWEEN '2015-01-01' AND '2015-12-31' -- DATE(Now())
GROUP BY p.Nome;

-- 4. Qual é o comandante de um dado primeiro oficial?
-- Acabado

SELECT p2.Nome AS Comandante, p1.Nome AS Copiloto
FROM Piloto p1
JOIN Piloto p2 ON p1.ComandanteId = p2.Id
WHERE p1.Categoria = 'Copiloto';

-- 5. Fazer a promoção de um copiloto a comandante
-- Acabado
-- Não sabemos se é preciso criar/associar um novo copiloto quando fazemos uma promoção, 
-- ou se ele continuará a atuar como copiloto mesmo depois de ser promovido até ter um copiloto para ele.

-- Promoção do copiloto Sacadura Cabral (Id = 3) 

update piloto set categoria = 'Comandante', comandanteId = NULL
where piloto.nome = 'Sacadura Cabral';

-- 6. Propor um avião e equipa de pilotos disponíveis para uma missão
-- Acabado

-- Supondo que a missão será numa data específica, por exemplo '2024-06-01'
SELECT a.Matricula, a.Nome AS NomeAviao, p1.Nome AS Comandante, p2.Nome AS Copiloto
FROM Aeronave a
JOIN Piloto p1 ON p1.Categoria = 'Comandante'
JOIN Piloto p2 ON p2.ComandanteId = p1.Id
WHERE a.Disponibilidade = TRUE
AND p1.Id NOT IN (SELECT ComandanteId FROM Missao WHERE DataInicio = '2024-06-01')
AND p2.Id NOT IN (SELECT CopilotoId FROM Equipa JOIN Missao ON Equipa.MissaoId = Missao.Id WHERE Missao.DataInicio = '2024-06-01');
-- LIMIT 1;

-- 7. Saber se um piloto está disponível para uma missão, considerando se estará noutra missão nessa data e se tem a licença válida
-- Acabado

-- Supondo que queremos verificar a disponibilidade do piloto com Id 1 (Gago Coutinho) para uma missão em '2024-06-01'
SELECT p.Id, p.Nome AS Piloto, p.Categoria, p.Licenca, p.Validade FROM Piloto p
WHERE p.Validade >= '2024-06-01' 
AND p.Id NOT IN (SELECT m.ComandanteId FROM Missao m 
WHERE m.DataInicio = '2024-06-01')
AND p.Id NOT IN (SELECT e.CopilotoId FROM Equipa e 
JOIN Missao m ON e.MissaoId = m.Id 
WHERE m.DataInicio = '2024-06-01');

-- 8. Uma consulta para informar os pilotos que deverão revalidar a sua licença com 2 meses antes do final da validade
-- Acabado

SELECT p.Id, p.Nome, p.Licenca, p.Validade 
FROM Piloto p
WHERE p.Validade <= CURDATE() OR p.Validade <= DATE_ADD(CURDATE(), INTERVAL 2 MONTH);

-- ------------------------
SELECT Nome, MIN(Validade) AS ValidadeMaisProxima FROM piloto
WHERE Validade >= CURDATE()
GROUP BY Nome;


