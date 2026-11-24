-- Criando o Banco de dados
CREATE DATABASE hospital;
USE hospital; 
  
  
-- Criando a tabela paciente 
  
CREATE TABLE paciente (
id_paciente INTEGER PRIMARY KEY, 
nome TEXT, 
idade INTEGER, 
cidade TEXT);

CREATE TABLE consulta (
id_consulta INTEGER PRIMARY KEY, 
id_paciente INTEGER, 
especialidade TEXT, 
data TEXT);
  
INSERT INTO paciente (id_paciente, nome, idade, cidade) 
  VALUES 
	(1,'Maria',39,'Fortaleza'),
	(2,'João',52,'Recife'),
    (3,'Ana',27,'Natal'),
    (4,'Carlos',45,'João Pessoa'),
    (5,'Beatriz',63,'Sobral'),
    (6,'Lucas',31,'Campina Grande');

INSERT INTO consulta (id_consulta, id_paciente, especialidade, data) 
  VALUES 
    (10,1,'Cardiologia','2025-08-12'),
    (11,2,'Ortopedia','2025-08-13'),
    (12,3,'Dermatologia','2025-08-13'),
    (13,5,'Cardiologia','2025-08-14'),
    (14,2,'Cardiologia','2025-08-15'),
    (15,6,'Ortopedia','2025-08-15'),
    (16,1,'Nutrição','2025-08-15'),
    (17,4,'Ortopedia','2025-08-18'),
    (18,3,'Cardiologia','2025-08-19'),
    (19,5,'Dermatologia','2025-08-19'),
    (20,6,'Nutrição','2025-08-20');
    
    
-- Consultar os dados 
SELECT *
FROM hospital.paciente;

SELECT *
FROM hospital.consulta;
 
 
 -- Analise descritiva com GROUP BY
 
SELECT especialidade, COUNT(*) AS total
FROM consulta
GROUP BY especialidade
ORDER BY total DESC;


-- INTEGRIDADE 

-- criando tabelas com controle de integridade 
 CREATE TABLE paciente2 (
    id_paciente INTEGER PRIMARY KEY, 
    nome TEXT NOT NULL, 
    idade INTEGER CHECK (idade BETWEEN 0 AND 120), 
    cidade TEXT NOT NULL
);
  
  
CREATE TABLE consulta2 (
    id_consulta INTEGER PRIMARY KEY, 
    id_paciente INTEGER NOT NULL, 
    especialidade TEXT NOT NULL, 
    data TEXT NOT NULL,
    FOREIGN KEY (id_paciente) REFERENCES paciente2(id_paciente)
);


INSERT INTO paciente2 (id_paciente, nome, idade, cidade) 
  VALUES 
	(1,'Maria',39,'Fortaleza'),
	(2,'João',52,'Recife'),
    (3,'Ana',27,'Natal'),
    (4,'Carlos',45,'João Pessoa'),
    (5,'Beatriz',63,'Sobral'),
    (6,'Lucas',31,'Campina Grande');

INSERT INTO consulta2 (id_consulta, id_paciente, especialidade, data) 
  VALUES 
    (10,1,'Cardiologia','2025-08-12'),
    (11,2,'Ortopedia','2025-08-13'),
    (12,3,'Dermatologia','2025-08-13'),
    (13,5,'Cardiologia','2025-08-14'),
    (14,2,'Cardiologia','2025-08-15'),
    (15,6,'Ortopedia','2025-08-15'),
    (16,1,'Nutrição','2025-08-15'),
    (17,4,'Ortopedia','2025-08-18'),
    (18,3,'Cardiologia','2025-08-19'),
    (19,5,'Dermatologia','2025-08-19'),
    (20,6,'Nutrição','2025-08-20');


INSERT INTO consulta2 (id_consulta, id_paciente, especialidade, data) 
  VALUES 
    (10,1,'Cardiologia','2025-08-13');
