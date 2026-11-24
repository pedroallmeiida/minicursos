

library(DBI)
library(RSQLite)

con <- dbConnect(RSQLite::SQLite(), "hospital.db")

dbExecute(con,
  "
  CREATE TABLE paciente (
  id_paciente INTEGER PRIMARY KEY, 
  nome TEXT, 
  idade INTEGER, 
  cidade TEXT)
  "
)

dbExecute(con,
  "
  CREATE TABLE consulta (
  id_consulta INTEGER PRIMARY KEY, 
  id_paciente INTEGER, 
  especialidade TEXT, 
  data TEXT)
  "
)
dbExecute(
  con,
  "
  INSERT INTO paciente (id_paciente, nome, idade, cidade) 
  VALUES 
    (1,'Maria',39,'Fortaleza'),
    (2,'João',52,'Recife'),
    (3,'Ana',27,'Natal'),
    (4,'Carlos',45,'João Pessoa'),
    (5,'Beatriz',63,'Sobral'),
    (6,'Lucas',31,'Campina Grande')
  "
)

dbExecute(
  con,
  "
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
    (20,6,'Nutrição','2025-08-20')
 "
)


### Analise descritiva das espcialidades
  

consulta <- dbGetQuery(
  con,
  "
  SELECT especialidade, COUNT(*) AS total
  FROM consulta
  GROUP BY especialidade
  ORDER BY total DESC
"
)


barplot(
  consulta$total,
  names.arg = consulta$especialidade,
  main = "Consultas por especialidade",
  ylab = "Total",
  col = "#4DABB8",
  cex.names = 1.2,
  cex.axis = 1.2,
  cex.main = 1.4
)


### Conexao com MySQL 

#install.packages("RMariaDB")

library(DBI)
library(RMariaDB)

## carregar as variaveis de ambiente
readRenviron(".Renviron")


## Conectando com o banco de dados do MySQL 
con_mysql <- dbConnect(
  RMariaDB::MariaDB(),
  host = "localhost",
  port = 3306,
  user = "pedroallmeiida",
  password = Sys.getenv("MYSQL_PASSWORD"),
  dbname = "hospital"
)


### Analise descritiva das especialidades


consulta <- dbGetQuery(
  con_mysql,
  "
  SELECT especialidade, COUNT(*) AS total
  FROM hospital.consulta
  GROUP BY especialidade
  ORDER BY total DESC
"
)

consulta$total <- as.numeric(consulta$total)

barplot(
  consulta$total,
  names.arg = consulta$especialidade,
  main = "Consultas por especialidade",
  ylab = "Total",
  col = "#4DABB8",
  cex.names = 1.2,
  cex.axis = 1.2,
  cex.main = 1.4
)






