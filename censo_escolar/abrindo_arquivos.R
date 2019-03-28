# Mostrando como eu abri os arquivos como tabelas de um banco de dados SQL lite no R

library(sqldf)

db <- dbConnect(SQLite(), dbname="microdados1")

# The connection to the database is given the name db. The name will be used later in this section and in the sections to follow. Strictly, the database does not yet exist, but it will do so as soon as some data has been entered.
# Similarly, creating a database using sqldf is just as simple. The following sqldf command creates Test1.sqlite in R’s working directory.

setwd("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS")

read.csv.sql("ESCOLAS.csv", sql = "CREATE TABLE ESCOLAS AS SELECT * FROM file",
             sep = "|", eol = "\n",
              dbname = "microdados1")

read.csv.sql("MATRICULA_CO.csv", sql = "CREATE TABLE MATRICULAS_CO AS SELECT * FROM file",
             sep = "|", eol = "\n",
             dbname = "microdados1")

read.csv.sql("MATRICULA_NORDESTE.csv", sql = "CREATE TABLE MATRICULAS_NE AS SELECT * FROM file",
             sep = "|", eol = "\n",
             dbname = "microdados1")

read.csv.sql("DOCENTES_NORDESTE.csv", sql = "CREATE TABLE DOCENTES_NE AS SELECT * FROM file",
             sep = "|", eol = "\n",
             dbname = "microdados1")
read.csv.sql("TURMAS.csv", sql = "CREATE TABLE TURMAS AS SELECT * FROM file",
             sep = "|", eol = "\n",
             dbname = "microdados1")

docentes_pe <- sqldf("SELECT * FROM DOCENTES_NE WHERE CO_UF = '26' ", dbname = "microdados1") 

x <- sqldf("SELECT * FROM MATRICULAS_NE 
           WHERE CO_MUNICIPIO = '2611606' ", dbname = "microdados1")   

matriculas_pe <- sqldf("SELECT * FROM MATRICULAS_NE 
           WHERE CO_UF = '26' ", dbname = "microdados1")   

save(matriculas_pe, file="matriculas_pe.Rdata")

escolas_pe <-  sqldf("SELECT * FROM ESCOLAS WHERE CO_UF = '26' ", dbname = "microdados1") 
turmas_pe <-  sqldf("SELECT * FROM TURMAS WHERE CO_UF = '26' ", dbname = "microdados1") 

setwd("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco")

save(escolas_pe, file="escolas_pe.Rdata")
save(docentes_pe, file="docentes_pe.Rdata")
save(turmas_pe, file="turmas_pe.Rdata")
