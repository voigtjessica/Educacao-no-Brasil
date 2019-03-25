library(dplyr)
library(data.table)

setwd("C:/Users/coliv/Documents/brazilian_funds_db/dbs/Repasses PNAE")
arq <- list.files()
nome_arq <- gsub(".csv", "", arq)

for(i in 1:length(arq)){
  
  x <- fread(arq[i])
  assign(nome_arq[i], x)

}

for(i in 1:length(nome_arq)){
  save(list = (nome_arq[i]),
       file = paste(nome_arq[i],".RData", sep = ""))
}

