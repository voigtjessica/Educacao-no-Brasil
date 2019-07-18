# Montando as tabelas SQL do projeto Tinker RS

library(tidyverse)
library(data.table)
library(readr)
library(janitor)

ano <- c("2017", "2018", "2019")

# Funções
fix_nomes <- function(x){
  
  x <- ifelse(grepl("De", x), gsub("De","de", x), x)
  x <- ifelse(grepl("Da", x), gsub("Da","da", x), x)
  x <- ifelse(grepl("Do", x), gsub("Do","do", x), x)
  
}

#Diretório
setwd("C:/Users/coliv/Documents/brazilian_funds_db/banco_final/merenda/rs")

#1. Info estados:
# vão usar os códigos do ibge

info_estados <- data.frame(id_estado = c(11:17, 21:29, 31:33,35, 41:43, 50:53),
                           nm_estado = c("Rondônia", "Acre", "Amazonas", "Roraima", "Pará","Amapá", "Tocantins",
                                         "Maranhão", "Piauí", "Ceará", "Rio Grande do Norte", "Paraíba", "Pernambuco", "Alagoas", "Sergipe", "Bahia", 
                                         "Minas Gerais",  "Espírito Santo", "Rio de Janeiro","São Paulo", 
                                         "Paraná", "Santa Catarina", "Rio Grande do Sul", 
                                         "Mato Grosso do Sul", "Mato Grosso", "Goiás", "Distrito Federal"),
                              sg_estado = c("RO", "AC", "AM", "RR", "PA", "AP", "TO", "MA", "PI", "CE", "RN", "PB", 
                                            "PE", "AL", "SE", "BA" , "MG",
                                            "ES" , "RJ", "SP", "PR", "SC", "RS" , "MS", "MT", "GO", "DF"))
info_estados <- info_estados %>%
  mutate_all(as.character)

#Salvando
fwrite(info_estados, file="info_estados.csv")

# Info municipios

info_municipios <- nomes_orgaos %>%
  rename(id_orgao = CD_ORGAO,
         nm_orgao = NM_ORGAO) %>%
  mutate(id_estado = "43",
         nm_municipio = gsub("PM DE ", "", nm_orgao),
         nm_municipio = tolower(nm_municipio),
         nm_municipio = tools::toTitleCase(nm_municipio),
         nm_municipio = fix_nomes(nm_municipio),
         nm_municipio = ifelse(grepl("CONS. PÚBL. INTERM.", nm_orgao), "Bacia do rio Jaraguão", nm_municipio))

#Salvando
fwrite(info_municipios, file="info_municipios.csv")

#Info licitações

# Licitações de merenda adjudicadas

licitacoes <- data.frame()

for (i in 1:length(ano)){
  
  a <- fread(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_licitacoes/licitacao.csv"), encoding = "UTF-8", colClasses=list(character=1:61))
  
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP",
           CD_TIPO_FASE_ATUAL == "ADH")
  
  licitacoes <- rbind(licitacoes, a)  
  rm(a)
}

# tp_licitacao

tipo_licitacao <- data.frame(tp_licitacao = c("MCA", "MDE", "MLO", "MOO", 
                                              "MOP", "MOQ", "MOT", "MPP",
                                              "MPR", "MRE", "MTC", "MTX", "MTO",
                                              "MTT", "MVT", "NSA", "TPR"),
                             tipo_licitacao = c("Melhor Conteúdo Artístico", "Maior Desconto", "Maior Lance ou Oferta" , "Maior Oferta de Outorga", 
                                                "Maior Oferta de Preço", "Maior Oferta de Outorga após Qualificação das Propostas Técnicas", 
                                                "Maior Oferta de Outorga e Melhor Técnica" , "Melhor Proposta Técnica com Preço fixado no Edital",
                                                "Menor Preço" , "Maior Retorno Econômico" , "Melhor Técnica" , "Menor Taxa" , 
                                                "Menor Valor da Tarifa e Maior Oferta de Outorga" , "Menor Valor da Tarifa e Melhor Técnica",
                                                "Menor Valor da Tarifa", "Não se Aplica" , "Técnica e Preço"))


concorrentes <- data.frame()

#concorrentes
for (i in 1:length(ano)){
  
  a <- fread(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_licitacoes/licitante.csv"), encoding = "UTF-8", colClasses=list(character=1:11))
  
  names(a) <- c("CD_ORGAO", "NR_LICITACAO", "ANO_LICITACAO",
                "CD_TIPO_MODALIDADE", "TP_DOCUMENTO_LICITANTE" , "NR_DOCUMENTO_LICITANTE",
                "TP_DOCUMENTO_REPRES" , "NR_DOCUMENTO_REPRES" , "TP_CONDICAO",
                "TP_RESULTADO_HABILITACAO", "BL_BENEFICIO_MICRO_EPP")
  
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP")
  
  concorrentes <- rbind(concorrentes, a)  
  rm(a)
}

concorrentes_por_lic <- concorrentes %>%
  filter(CD_TIPO_MODALIDADE == "CPP") %>%
  group_by(CD_ORGAO, ANO_LICITACAO, CD_TIPO_MODALIDADE, NR_LICITACAO ) %>%
  summarise(total_concorrentes = n()) %>%
  mutate(id_estado = "43")


info_licitacoes <- licitacoes %>%
  clean_names() %>%
  mutate(id_estado = "43",
         tp_fornecimento = ifelse(tp_fornecimento == "I" , "Integral", 
                                  ifelse(tp_fornecimento == "P", "Parcelado", NA)),
         vl_homologado = ifelse( vl_homologado == "", NA, vl_homologado),
         dt_adjudicacao = as.Date(dt_adjudicacao, format="%Y-%m-%d"),
         vl_homologado = as.numeric(vl_homologado),
         vl_licitacao = as.numeric(vl_licitacao)) %>%
  rename(id_orgao = cd_orgao,
         vl_estimado_licitacao = vl_licitacao,
         permite_subcontratacao = bl_permite_subcontratacao,
         descricao_objeto = ds_objeto,
         data_adjudicacao = dt_adjudicacao) %>%
  left_join(tipo_licitacao, by=c("tp_licitacao")) %>%
  left_join(concorrentes_por_lic, by=c("id_estado" = "id_estado", "id_orgao" = "CD_ORGAO",
                                       "ano_licitacao" = "ANO_LICITACAO", "nr_licitacao" = "NR_LICITACAO")) %>%
  select(id_estado, id_orgao, nr_licitacao, ano_licitacao, tipo_licitacao, permite_subcontratacao,
         tp_fornecimento, descricao_objeto, vl_estimado_licitacao, data_adjudicacao, vl_homologado, total_concorrentes)

#Salvando
fwrite(info_licitacoes, file="info_licitacoes.csv")

#Info contratos

# Contratos de merenda

contratos <- data.frame()

for (i in 1:length(ano)){
  
  a <- fread(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_contratos/contrato.csv"), encoding = "UTF-8", colClasses=list(character=1:26))
  
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP")
  
  contratos <- rbind(contratos, a)  
  rm(a)
}

#tp_instrumento_contrato

tipo_instrumento_contrato <- data.frame(tp_instrumento_contrato = c("A", "C", "F", "P", "R", "T", "O", "U" ),
                                        tipo_instrumento_contrato = c("Termo de adesão", "Contrato", "Termo de fomento", 
                                                                      "Termo de parceria", "Termo de credenciamento", "Termo de colaboração", 
                                                                      "Acordo de Cooperação", "Termo de Permissão de Uso"))

info_contratos <- contratos %>%
  clean_names() %>%
  mutate(id_estado = "43") %>%
  rename(id_orgao = cd_orgao,
         tp_instrumento_contrato = tp_instrumento,
         tp_documento_contratado = tp_documento,
         nr_documento_contratado = nr_documento,
         contrato_possui_garantia = bl_garantia,
         vigencia_original_do_contrato = nr_dias_prazo,
         descricao_objeto_contrato = ds_objeto,
         justificativa_contratacao = ds_justificativa,
         obs_contrato = ds_observacao) %>%
  left_join(tipo_instrumento_contrato, by=c("tp_instrumento_contrato")) %>%
  select(id_estado, id_orgao, nr_licitacao, ano_licitacao, nr_contrato, ano_contrato,
         tipo_instrumento_contrato, nr_processo, ano_processo, tp_documento_contratado, nr_documento_contratado,
         dt_inicio_vigencia, dt_final_vigencia, vl_contrato, contrato_possui_garantia, vigencia_original_do_contrato,
         descricao_objeto_contrato, justificativa_contratacao, obs_contrato) 

#Salvando
fwrite(info_contratos, file="info_contratos.csv")
#vou olhar as alterações de contrato - elas constam apenas para tudo que envolve dinheiro ou 
# aumento de vigência de contrato

alteracoes_contrato <- data.frame()

for(i in 1:length(ano)){
  
  print(ano[i])
  a <- read_excel(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_contratos/alteracao.xlsx"), 
                  col_types = c("text", "text", "text", 
                                "text", "text", "text", "text", 
                                "text", "text", "text", "text", 
                                "text", "text", "text", 
                                "text", "text", "text", "text", 
                                "text", "text", "text", 
                                "text"))
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP")
  
  alteracoes_contrato <- rbind(alteracoes_contrato, a)
  rm(a)
}


tipo_operacao_alteracao <- data.frame( cd_tipo_operacao = c("ACA", "ACC", "ADO", "AGF", "ANR",
                                                                "AVI", "MFP", "MMF", "MPE", "MRE",
                                                                "OUT", "PPC", "REF", "REN", "RJP",
                                                                "RVP", "RVS", "SGE"),
                                         tipo_operacao_alteracao = c( "Acréscimo de Valor por Aumento de Quantitativo",
                                                                        "Alteração ou cessão de contratado", 
                                                                        "Alteração de Dotação Orçamentária",
                                                                        "Alteração do gestor / fiscal",
                                                                        "Alteração da Natureza ou da Razão Social do Fornecedor",
                                                                        "Acréscimo de valor por inclusão de Itens novos",
                                                                        "Modificação da Forma de Pagamento",
                                                                        "Modificação do Modo de Fornecimento",
                                                                        "Modificação do Projeto ou das Especificações Técnicas",
                                                                        "Modificação do Regime de Execução",
                                                                        "Outros",
                                                                        "Prorrogação Prazo Contratual",
                                                                        "Reequilíbrio Econômico-Financeiro",
                                                                        "Renovação Contratual",
                                                                        "Reajustamento de Preços",
                                                                        "Redução de Valor por Supressão de Itens",
                                                                        "Redução de Valor por Supressão de Quantitativo",
                                                                        "Substituição de garantia de execução"))


info_alteracoes_contrato <- alteracoes_contrato %>%
  clean_names() %>%
  select(cd_orgao, ano_licitacao, nr_licitacao, nr_contrato, ano_contrato, 
         sq_evento, cd_tipo_operacao, nr_dias_novo_prazo,vl_acrescimo, vl_reducao, pc_acrescimo, 
         pc_reducao, ds_justificativa ) %>%
  left_join(tipo_operacao_alteracao, by=c("cd_tipo_operacao")) %>%
  rename(id_orgao = cd_orgao,
         id_evento_contrato = sq_evento,
         vigencia_novo_contrato = nr_dias_novo_prazo,
         motivo_alteracao_contrato = tipo_operacao_alteracao) %>%
  select(-c(cd_tipo_operacao))

#Salvando
fwrite(info_alteracoes_contrato, file="info_alteracoes_contrato.csv")


#RAIS

# ## Já fiz o cruzamento das empresas com contratos e a RAIS. vou deixar como eu fiz e o arquivo final:
# #Aqui vou filtrar os dados das rais apenas para as empresas que têm contrato para fornecimento de merenda
# 
# load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/RAIS/RAIS ESTABELECIMENTO 2017/rais2017.Rdata")
# 
# rais <- rais2017 %>%
#   mutate(cnpj = gsub("\\.", "", cnpj_cei),
#          cnpj = gsub("/", "", cnpj),
#          cnpj = gsub("-", "", cnpj))
# 
# c <- contratos %>%
#   filter(TP_DOCUMENTO == "J") %>%
#   distinct(NR_DOCUMENTO)
# 
# #Aqui são apenas os dados da RAIS para as empresas. As empresas tem mais de um contrato, por isso o n 
# # deu tão baixo
# rais_contratos_rs <- c %>%
#   left_join(rais, by=c("NR_DOCUMENTO" = "cnpj"))
# 
# setwd("C:/Users/coliv/licitacoes_merenda_rs/dbs/cruzamentos_contratos")
# save(rais_contratos_rs, file="rais_contratos_rs.Rdata")

#Cruzamento empresas com contratos e RAIS

load("C:/Users/coliv/licitacoes_merenda_rs/dbs/cruzamentos_contratos/rais_contratos_rs.Rdata")

info_rais <- rais_contratos_rs %>%
  mutate(razao_social = gsub("\\.", "", razao_social)) %>%
  rename(nr_documento_contratado = NR_DOCUMENTO)

fwrite(info_rais, file="info_rais.csv")

#Cruzamentos itens por contrato

# Lista de Itens da licitação
# chave: NR_LICITACAO, ANO_LICITACAO, CD_TIPO_MODALIDADE, NR_LOTE e NR_ITEM

item_lic <- data.frame()

for (i in 1:length(ano)){
  
  a <- fread(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_licitacoes/item.csv"), 
             encoding = "UTF-8", colClasses=list(character=1:32))
  
  names(a) <- c("CD_ORGAO", "NR_LICITACAO", "ANO_LICITACAO", "CD_TIPO_MODALIDADE", "NR_LOTE", "NR_ITEM", 
                "NR_ITEM_ORIGINAL", "DS_ITEM", "QT_ITENS_LICITACAO", "SG_UNIDADE_MEDIDA", "VL_UNITARIO_ESTIMADO", 
                "VL_TOTAL_ESTIMADO", "DT_REF_VALOR_ESTIMADO", "PC_BDI_ESTIMADO", "PC_ENCARGOS_SOCIAIS_ESTIMADO", 
                "CD_FONTE_REFERENCIA", "DS_FONTE_REFERENCIA", "TP_RESULTADO_ITEM", "VL_UNITARIO_HOMOLOGADO", 
                "VL_TOTAL_HOMOLOGADO", "PC_BDI_HOMOLOGADO", "PC_ENCARGOS_SOCIAIS_HOMOLOGADO", 
                "TP_ORCAMENTO", "CD_TIPO_FAMILIA", "CD_TIPO_SUBFAMILIA", "TP_DOCUMENTO_VENCEDOR", 
                "NR_DOCUMENTO_VENCEDOR", "TP_DOCUMENTO_FORNECEDOR", "NR_DOCUMENTO_FORNECEDOR",
                "TP_BENEFICIO_MICRO_EPP", "PC_TX_ESTIMADA", "PC_TX_HOMOLOGADA")
  
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP")
  
  item_lic<- rbind(item_lic, a)  
  rm(a)
}

info_item_licitacao <- item_lic %>%
  distinct() %>%
  clean_names() %>%
  select(cd_orgao, ano_licitacao, nr_licitacao, nr_item, ds_item, qt_itens_licitacao, sg_unidade_medida,
         vl_unitario_homologado, vl_total_homologado) %>%
  rename(id_orgao = cd_orgao)

glimpse(info_item_licitacao)

#Salvando
fwrite(info_item_licitacao, file="info_item_licitacao.csv")

#Itens contrato

item_con <- data.frame()

for (i in 1:length(ano)){
  
  a <- fread(paste0("C:/Users/coliv/licitacoes_merenda_rs/dbs/", ano[i], "_contratos/item_con.csv"), 
             encoding = "UTF-8")
  
  a <- a %>%
    filter(CD_TIPO_MODALIDADE == "CPP")
  
  item_con<- rbind(item_con, a)  
  rm(a)
}

info_item_contrato <- item_con %>%
  distinct(NR_LICITACAO, ANO_LICITACAO, CD_TIPO_MODALIDADE, NR_CONTRATO, ANO_CONTRATO, TP_INSTRUMENTO, NR_LOTE, NR_ITEM,
           .keep_all=TRUE) %>%
  rename(QT_ITENS_CONTRATO = QT_ITENS,
         VL_ITEM_CONTRATO = VL_ITEM,
         VL_TOTAL_ITEM_CONTRATO = VL_TOTAL_ITEM) %>%
  select(-c(PC_BDI, PC_ENCARGOS_SOCIAIS)) %>%
  mutate_all(as.character) %>%
  clean_names() %>%
  select(cd_orgao, nr_licitacao, ano_licitacao, nr_contrato, ano_contrato, nr_item, qt_itens_contrato, vl_item_contrato, vl_total_item_contrato)

#Salvando
fwrite(info_item_contrato, file="info_item_contrato.csv")

#Enviando tudo para o Gsheets:

library(googlesheets)

#autenticação // responder 2
gs_ls() 

sheet <- gs_title("MVP - Dados RS", verbose = TRUE)

sheet <- sheet %>%
  gs_ws_new(ws_title = "info_alteracoes_contrato", input = info_alteracoes_contrato,
            trim = TRUE, verbose = FALSE) #ok

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

sheet <- sheet %>%
  gs_ws_new(ws_title = "info_contratos", input = info_contratos,
            trim = TRUE, verbose = FALSE)

  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_estados", input = info_estados,
              trim = TRUE, verbose = FALSE)
  
  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_item_contrato", input = info_item_contrato,
              trim = TRUE, verbose = FALSE)
  
  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_item_licitacao", input = info_item_licitacao,
              trim = TRUE, verbose = FALSE)
  
  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_licitacoes", input = info_licitacoes,
              trim = TRUE, verbose = FALSE)
  
  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_municipios", input = info_municipios,
              trim = TRUE, verbose = FALSE)
  
  sheet <- sheet %>%
    gs_ws_new(ws_title = "info_rais", input = info_rais,
              trim = TRUE, verbose = FALSE)



