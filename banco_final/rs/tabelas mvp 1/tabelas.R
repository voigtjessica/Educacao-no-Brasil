library(tidyverse)
library(data.table)
library(readr)
library(janitor)
library(xlsx)
library(stringr)


ano <- c("2017", "2018", "2019")


#Diretório
setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs")

#

lista <- c("info_contratos.csv","info_estados.csv","info_alteracoes_contrato.csv", 
           "info_item_contrato.csv","info_item_licitacao.csv","info_licitacoes.csv" ,
           "info_municipios.csv","info_rais.csv")

for(i in 1: length(lista)){
  
  print(lista[i])
  
  a <- fread(lista[i], encoding = "UTF-8" )
  l <- gsub(".csv", "", lista)
  n <- l[i]
  
  
  assign(paste0(n), a) 
  
}

info_municipios <- info_municipios %>%
  mutate_all(as.character)

# Contratos vigentes

rs <- info_rais %>%
  mutate_all(as.character) %>%
  distinct(nr_documento_contratado, razao_social)

tb1 <- info_contratos %>%
  left_join(info_municipios, by=c("id_estado", "id_orgao")) %>%
  left_join(info_licitacoes, by=c("id_estado", "id_orgao", "nr_licitacao", "ano_licitacao")) %>%
  left_join(rs, by=c("nr_documento_contratado")) %>%
  mutate(contratos = paste(nr_contrato, ano_contrato, sep="/"),
         c1 = substr(nr_documento_contratado, 0, 2),
         c2 = substr(nr_documento_contratado, 3, 5),
         c3 = substr(nr_documento_contratado, 6, 8),
         c4 = substr(nr_documento_contratado, 9, 12),
         c5 = substr(nr_documento_contratado, 13, 14),
         p1 = substr(nr_documento_contratado, 0, 3),
         p2 = substr(nr_documento_contratado, 4, 6),
         p3 = substr(nr_documento_contratado, 7, 9),
         p4 = substr(nr_documento_contratado, 10, 11),
         nr_documento_contratado = ifelse(tp_documento_contratado == "J", paste0(c1, ".", c2, ".", c3, "/", c4, "-", c5),
                                          paste0(p1, ".", p2, ".", p3, "-", p4)),
         tp_documento_contratado = ifelse(tp_documento_contratado == "F", "Física", 
                                          ifelse(tp_documento_contratado == "J", "Jurídica", "Estrangeiro"))) %>%
         select(id_estado, nm_municipio, contratos, descricao_objeto_contrato, dt_inicio_vigencia, dt_final_vigencia, vl_contrato,
                tp_documento_contratado, nr_documento_contratado, razao_social)


setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs/tabelas_do_spreadsheet")

fwrite(tb1, file="tb1.csv")
write.xlsx(tb1, file="tb1.xlsx", row.names=FALSE, showNA = FALSE)

## Info da empresa 

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/QSA/RS_qsa.Rdata") #x
load("C:/Users/coliv/licitacoes_merenda_rs/dbs/cruzamentos_contratos/rais_contratos_rs.Rdata")

munic_contrato <- info_contratos %>%
  filter(tp_documento_contratado == "J") %>%
  mutate(dt_final_vigencia = as.Date(dt_final_vigencia, format = "%Y-%m-%d"),
    vig = ifelse(dt_final_vigencia < "2019-07-01", "vigente", "expirado")) %>%
  left_join(info_municipios, by=c("id_estado","id_orgao")) %>%
  distinct(id_estado, id_orgao, nr_documento_contratado, vig, nm_municipio) 

munic_contrato <- aggregate(munic_contrato$nm_municipio, list(munic_contrato$nr_documento_contratado, munic_contrato$vig), paste, collapse=", ")
names(munic_contrato) <- c("nr_documento_contratado", "vig", "municipios")

munic_contrato <- munic_contrato %>%
  spread(vig, municipios)

cnpjs_rs <- unique(rais_contratos_rs$NR_DOCUMENTO)

qsa_rs <- x %>%
  filter(TIPO == "02",
         CNPJ %in% cnpjs_rs) %>%
  select(CNPJ ,NM_QUALIFICACAO_DO_SOCIO , NOME_DO_SOCIO )

socios <- aggregate(qsa_rs$NOME_DO_SOCIO, list(qsa_rs$CNPJ), paste, collapse=", ") 
names(socios) <- c("CNPJ", "nome_socio")
qualificacao <- aggregate(qsa_rs$NM_QUALIFICACAO_DO_SOCIO, list(qsa_rs$CNPJ), paste, collapse=", ") 
names(qualificacao) <- c("CNPJ", "qualificacao_socio")

qsa_rs <- socios %>%
  left_join(qualificacao) %>%
  mutate(nome_socio = tolower(nome_socio),
         nome_socio = str_to_title(nome_socio))
  


tb2 <- rais_contratos_rs %>%
  mutate_all(as.character) %>%
  mutate(razao_social = gsub("\\.", "", razao_social),
         cep_estab = gsub("\\.", "", cep_estab),
         cep1 = substr(cep_estab, 0, 5),
         cep2 = substr(cep_estab, 6, 8),
         cep_estab = paste0(cep1, "-", cep2)) %>%
  rename(nr_documento_contratado = NR_DOCUMENTO) %>%
  left_join(qsa_rs, by=c("nr_documento_contratado" = "CNPJ") ) %>%
  left_join(munic_contrato, by=c("nr_documento_contratado")) %>%
  rename(munic_contrato_vigente = vigente,
         munic_contrato_expirado = expirado) %>%
  select(cnpj_cei, razao_social, natureza_juridica, cnae_2_0_classe_2, cep_estab, porte_estabelecimento, 
         tamanho_estabelecimento, qtd_vinculos_ativos, nome_socio, qualificacao_socio,
         munic_contrato_vigente, munic_contrato_expirado) 

setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs/tabelas_do_spreadsheet")

fwrite(tb2, file="tb2.csv")
write.xlsx(tb2, file="tb2.xlsx", row.names=FALSE, showNA = FALSE)


#TB3 - licitações

c <- info_contratos %>%
  select(id_estado, id_orgao, nr_licitacao, ano_licitacao, nr_contrato, ano_contrato, vl_contrato)

tb3 <- info_licitacoes  %>%
  left_join(c, by=c("id_estado", "id_orgao", "nr_licitacao", "ano_licitacao")) %>%
  mutate(tipo_licitacao = ifelse(grepl("Aplica", tipo_licitacao), "Não se aplica", tipo_licitacao)) %>%
  rename(vl_estimado_licitacao_total = vl_estimado_licitacao,
         vl_contrato_com_fornecedor = vl_contrato) %>%
  mutate(licitacao_ano = paste0(nr_licitacao, "/", ano_licitacao ),
         contrato_ano = paste0(nr_contrato, "/", ano_contrato),
         permite_subcontratacao = ifelse(permite_subcontratacao == "S", "Sim", "Não")) %>%
  left_join(info_municipios, by=c("id_estado", "id_orgao")) %>%
  select(id_estado, nm_municipio, licitacao_ano, descricao_objeto,
         tipo_licitacao, permite_subcontratacao, tp_fornecimento, vl_estimado_licitacao_total,total_concorrentes,
         contrato_ano, vl_contrato_com_fornecedor)


setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs/tabelas_do_spreadsheet")

fwrite(tb3, file="tb3.csv")
write.xlsx(tb3, file="tb3.xlsx", row.names=FALSE, showNA = FALSE)  


# TB4 Itens licitação

tb4 <- info_item_licitacao %>%
  inner_join(info_item_contrato, by=c("id_orgao" = "cd_orgao", "ano_licitacao", "nr_lote", "nr_licitacao",
                                     "nr_item")) %>%
  left_join(info_municipios, by=c("id_orgao")) %>%
  mutate(vl_unitario_estimado = round(as.numeric(vl_unitario_estimado),2),
         vl_total_estimado = round(as.numeric(vl_total_estimado),2),
         qt_itens_licitacao = round(as.numeric(qt_itens_licitacao),0),
         qt_itens_contrato = round(as.numeric(qt_itens_contrato),0),
         vl_item_contrato = round(as.numeric(vl_item_contrato),2),
         vl_total_item_contrato = round(as.numeric(vl_total_item_contrato),2),
         licitacao_ano = paste0(nr_licitacao, "/", ano_licitacao ),
         contrato_ano = paste0(nr_contrato, "/", ano_contrato ),
         ds_item = tolower(ds_item),
         ds_item = str_to_sentence(ds_item),
         qt_itens_licitacao = paste0(qt_itens_licitacao, " ", sg_unidade_medida),
         qt_itens_contrato = paste0(qt_itens_contrato, " ", sg_unidade_medida)) %>%
  select(id_estado.x, nm_municipio, licitacao_ano, nr_item, ds_item, qt_itens_licitacao,  
         vl_unitario_estimado, vl_total_estimado, contrato_ano, qt_itens_contrato , vl_item_contrato,
         vl_total_item_contrato) %>%
  rename(id_estado = id_estado.x)

setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs/tabelas_do_spreadsheet")

fwrite(tb4, file="tb4.csv")
write.xlsx(tb4, file="tb4.xlsx", row.names=FALSE, showNA = FALSE)  
