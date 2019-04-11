---
title: "Pernambuco"
author: "Jessica Voigt"
date: "2 de abril de 2019"
output: html_document
---

Versão HTML: [http://rpubs.com/voigtjessica/483008](http://rpubs.com/voigtjessica/483008)

Essa é uma primeira versão dos cruzamentos de bases de dados levantadas até o momento para o projeto Tá de Pé Educação.

Até o momento, consegui aproveitar as seguintes bases: 
* Censo Escolar (tabelas escolas e matrículas);
* Repasses PNAE;
* Parâmetros CAQi (não estava listada, coloquei a partir de uma conversa com o Manoel que poderíamos avaliar a infraestrutura das escolas com base nisso); 
* DAPs ativas 

Não consegui ainda aproveitar as bases:

* Nutricionistas do PNAE: recebi via LAI uma tabela com os nutricionistas vinculados em 2019, dado que não estava disponível em transparência ativa. Como essa tabela veio em formato PDF eu preciso importar e criar um dataframe no R. Entendi que esse não era o cruzamento mais interessante e deixei por último (vou atualizar esse documento com essa informação) ;
* QSA: cruzei os nomes titulares das DAP com os quadros societários e não encontrei nenhum match. Já verifiquei meu script e não encontrei nenhum erro, mas vou verificar novamente.
* RAIS: como não consigo cruzar o QSA com as DAPs, não consigo associar os CNPJs aos agricultores familiares. Consequentemente, não consigo verificar as informações das empresas nesse banco.

**Minha conclusão:** caso queremos avançar na investigação sobre compra da merenda, precisamos investir na coleta de informações de compras. Com as informações atuais não é possível avançar mais.

Uma observação: para não deixar o documento muito longo, cortei apenas as primeiras 20 linhas das tabelas que listam municípios.

Atualizarei o documento caso consiga fazer qualquer avanço.

--- 


## Dados sobre alunos e repasses feitos pelo PNAE (PE)

### 1. Qual foi a população de pernambuco matriculada no ensino básico em 2018?

* Censo escolar (matrículas)


```{r, echo=FALSE, eval=TRUE, warning=FALSE}

library(dplyr)
library(ggplot2)
library(tidyr)
library(stringi)
library(knitr)

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/docentes_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/escolas_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/matriculas_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/turmas_pe.Rdata")

#retirando alunos que não são do ensino básico (Técnico não integrado, supletivo , EJA e infantil e fundamental multietapa)
not_basico <- c(0,56,29,34,39,40,68,65,67,69,70,71,72,73,74)


#criando um objeto para ajustar alunos que estão no fundamental de 8 e de 9 anos.
load("~/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/ajuste_etapa.Rdata")


matriculas_pe_basico <- matriculas_pe %>%
  filter(!TP_ETAPA_ENSINO %in% not_basico,
         TP_OUTRO_LOCAL_AULA == 3,       # apenas alunos que têm aulas na escola
         TP_DEPENDENCIA != 4) %>%        # apenas escolas da rede pública
  left_join(ajuste_etapa, by=c("TP_ETAPA_ENSINO")) %>%
  mutate(TIPO_FUNDAMENTAL = ifelse(TP_ETAPA_ENSINO %in% c(4:11), "8 anos",
                                   ifelse(TP_ETAPA_ENSINO %in% c(14, 15, 16, 17, 18, 19, 20, 21, 41), "9 anos", NA)))


```

Vendo as proporções:
```{r, echo=FALSE, eval=TRUE, warning=FALSE}

basico_total <- matriculas_pe %>%
    filter(!TP_ETAPA_ENSINO %in% not_basico)

print(paste0("Cerca de ", (round(nrow(matriculas_pe_basico)/nrow(basico_total),2))*100, "% das matriculas do ensino básico em Pernambuco são de alunos da rede municipal"))
```


### Distribuição dos alunos da rede pública:

* Censo escolar (matrículas)

```{r, echo = F, eval = TRUE, warning=FALSE}

matriculas_pe_basico %>% 
  group_by(NOME_ETAPA) %>%
  summarize(alunos_mil = n()/1000) %>%
  arrange(NOME_ETAPA)  %>%
  ggplot() +
  geom_col(aes(x=NOME_ETAPA ,y=alunos_mil, fill=NOME_ETAPA)) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) + 
  theme(legend.position="none") +
  ggtitle("Distribuição dos alunos da rede pública (PE)") 

```

### 2. Se existe uma estrutura mínima:

```{r, echo = F, eval = TRUE, warning=FALSE}

agua_escolas_pe <- escolas_pe %>%
  filter(TP_DEPENDENCIA != 4,
         IN_AGUA_INEXISTENTE == 1) %>%
  summarise(n())

energia_escolas_pe <- escolas_pe %>%
  filter(TP_DEPENDENCIA != 4,
         IN_ENERGIA_INEXISTENTE == 1)%>%
  summarise(n())

esgoto_escolas_pe <- escolas_pe %>%
  filter(TP_DEPENDENCIA != 4,
         IN_ESGOTO_INEXISTENTE == 1) %>%
  summarise(n())

print(paste0("Cerca de ", round(agua_escolas_pe/nrow(escolas_pe), 4)*100, "% escolas de Pernambuco não têm nenhum tipo de abastecimento de água, cerca de ", round(energia_escolas_pe/nrow(escolas_pe), 4)*100, "% não possuem nenhuma fonte de energia elétrica e cerca de ", round(esgoto_escolas_pe/nrow(escolas_pe), 4)*100, "% das escolas não possuem nenhuma estrutura de esgoto sanitário"))
```


### 3. Se existe uma estrutura mínima para atender aos parâmetros do CAQi?

* Censo Escolar X Parâmetros CAQi

O Custo Aluno Qualidade inicial (CAQi) é um indicador que mostra quanto deve ser investido ao ano por aluno de cada etapa e modalidade da educação básica. Considera os custos de manutenção das creches, pré-escolas e escolas para que estes equipamentos garantam um padrão mínimo de qualidade para a educação básica.

Obs: aqui testei apenas para a creche, mas é possível também fazer para outras unidades escolares.

```{r, echo = F, eval = TRUE, warning=FALSE}

# Estrutura da escola e CAQi

escolas_pe_caqi <- escolas_pe %>%                
  filter(TP_DEPENDENCIA != 4) %>%            #apenas escolas da rede pública
  select(IN_COMUM_CRECHE, IN_COMUM_PRE, IN_COMUM_FUND_AI, IN_COMUM_FUND_AF, IN_COMUM_MEDIO_MEDIO,
         IN_COMUM_MEDIO_INTEGRADO, IN_COMUM_MEDIO_NORMAL, IN_SALA_DIRETORIA, IN_SALA_PROFESSOR,
         IN_LABORATORIO_INFORMATICA, IN_LABORATORIO_CIENCIAS, IN_QUADRA_ESPORTES_COBERTA, IN_COZINHA, 
         IN_BIBLIOTECA, IN_PARQUE_INFANTIL, IN_BERCARIO, IN_BANHEIRO_EI) %>%
  mutate_all(as.numeric)

escolas_pe_caqi %>%
  filter(IN_COMUM_CRECHE == 1) %>%                   #apenas creches
  select(IN_SALA_DIRETORIA, IN_SALA_PROFESSOR,
         IN_COZINHA, IN_BIBLIOTECA, IN_PARQUE_INFANTIL, IN_BERCARIO, IN_BANHEIRO_EI) %>%
  mutate(num = 1) %>%
  summarise(tem_sala_diretoria = sum(num[IN_SALA_DIRETORIA == 1]),
            nao_sala_diretoria = sum(num[IN_SALA_DIRETORIA == 0]),
            na_sala_diretoria = n() - tem_sala_diretoria - nao_sala_diretoria,
            #
            tem_sala_professor = sum(num[IN_SALA_PROFESSOR == 1]),
            nao_sala_professor = sum(num[IN_SALA_PROFESSOR == 0]),
            na_sala_professor =  n() - tem_sala_professor - nao_sala_professor,
            #
            tem_cozinha = sum(num[IN_COZINHA == 1]),
            nao_cozinha = sum(num[IN_COZINHA == 0]),
            na_cozinha = n() - tem_cozinha - nao_cozinha,
            #
            tem_biblioteca = sum(num[IN_BIBLIOTECA == 1]),
            nao_biblioteca = sum(num[IN_BIBLIOTECA ==0]),
            na_biblioteca = n() - tem_biblioteca - nao_biblioteca,
            #
            tem_parquinho = sum(num[IN_PARQUE_INFANTIL ==1]),
            nao_parquinho = sum(num[IN_PARQUE_INFANTIL ==0]),
            na_parquinho = n() - tem_parquinho - nao_parquinho,
            #
            tem_bercario = sum(num[IN_BERCARIO == 1]),
            nao_bercario = sum(num[IN_BERCARIO == 0]),
            na_bercario = n() - tem_bercario - nao_bercario,
            #
            tem_banheiro_infantil = sum(num[IN_BANHEIRO_EI == 1]),
            nao_banheiro_infantil = sum(num[IN_BANHEIRO_EI == 0]),
            na_banheiro_infantil = n() - tem_banheiro_infantil - nao_banheiro_infantil) %>%
  gather(situacao,num_escolas, tem_sala_diretoria,nao_sala_diretoria,na_sala_diretoria,
         na_sala_professor, tem_sala_professor, nao_sala_professor, tem_cozinha, nao_cozinha,
         na_cozinha, na_biblioteca, tem_biblioteca , nao_biblioteca,na_parquinho , tem_parquinho ,
         nao_parquinho,na_bercario , tem_bercario , nao_bercario, na_banheiro_infantil,
         tem_banheiro_infantil , nao_banheiro_infantil) %>%
  mutate(equipamento = ifelse(grepl("diretoria", situacao), "Sala Diretoria",
                              ifelse(grepl("professor", situacao), "Sala de professores",
                                     ifelse(grepl("cozinha", situacao), "Cozinha",
                                            ifelse(grepl("biblioteca", situacao), "Biblioteca",
                                                   ifelse(grepl("parquinho", situacao), "Parquinho",
                                                          ifelse(grepl("bercario", situacao), "Berçário", "Banheiro Infantil")))))),
         situacao = ifelse(grepl("nao", situacao), "Não Possui",
                           ifelse(grepl("tem", situacao), "Possui", "Não Respondeu"))) %>%
  group_by(equipamento) %>%
  mutate(perc = round(num_escolas/sum(num_escolas),2)) %>%
  ungroup() %>%
  ggplot() +
  geom_col(aes(x=equipamento ,y=perc, fill=situacao)) +
  ggtitle("Percentual de creches que atendem aos parâmetros do CAQi") + 
  theme_bw() + theme(axis.text.x = element_text(angle = 45, hjust = 1))


```


### 4. Escola oferece alimentação? 

* Censo escolar (Matrículas)

```{r, echo = FALSE}
escolas_pe %>%                
  filter(TP_DEPENDENCIA != 4) %>% 
  mutate(IN_ALIMENTACAO = ifelse(IN_ALIMENTACAO == 1, "Oferece alimentação",
                                 ifelse(IN_ALIMENTACAO == 0, "Não oferece alimentação", "Sem informação "))) %>%
  group_by(IN_ALIMENTACAO) %>%
  summarise(escolas = n()) %>%
  ungroup() %>%
  mutate(percentual = round(escolas/10557 , 2)) %>%
  rename(situacao = IN_ALIMENTACAO) %>%
  kable()

```

### 5. Quais foram os repasses do PNAE feitos para o estado de Pernambuco em 2018?

* Repasses do PNAE (2018)

```{r, echo = FALSE}

# Recursos PNAE
load("~/brazilian_funds_db/dbs/Repasses PNAE/PNAE_RECURSOS_REPASSADOS_2018.RData")


PNAE_RECURSOS_REPASSADOS_2018 %>%
  mutate(valor_total_escolas = gsub(",", ".", VALOR_TOTAL_ESCOLAS_PNAE),
         valor_total_escolas = as.numeric(valor_total_escolas)) %>%
  filter(ESTADO == "PE") %>%
  group_by(ESFERA_GOVERNO) %>%
  summarise(total_repassado_valores_correntes = sum(valor_total_escolas)) %>%
  ungroup() %>%
  mutate(perc = round(total_repassado_valores_correntes/sum(total_repassado_valores_correntes),2)) %>%
  kable()


```

### 6. Quanto foi repassado para cada município em cada modalidade?

* Repasses_PNAE X Censo escolar (Matrículas) X Informações site FNDE (VALORES IDEAIS)

Observações:

    * Constam apenas as primeiras 20 linhas;
    * Nos dados sobre as escolas dentro da base de *matrícula*, não há uma variável específica que defina se aquela escola fornece educação quilombola ou não. Como isso é um dos critérios dos repasses do PNAE, estimei as escolas quilombolas a partir das escolas que se localizam em áreas quilombolas. Já as escolas indígenas possuem uma variável específica (cuja quantidade coincide com as escolas localizadas em áreas indígenas);
    * Segundo o PNAE, existe um valor de repasse para ensino integral (1.07) e ensino médio integral (2.00). No entanto, os dados de repasses do PNAE não mencionavam repasses para ensino fundamental integral.

```{r, echo = FALSE}

load("~/brazilian_funds_db/dbs/municipios_ibge.RData")

matriculas_penae <- matriculas_pe_basico %>%
  select(CO_MUNICIPIO, ETAPA_AJUSTADA, NU_DURACAO_TURMA, TP_LOCALIZACAO_DIFERENCIADA, IN_EDUCACAO_INDIGENA) %>%
  mutate(MODALIDADE_ENSINO = ifelse(ETAPA_AJUSTADA == 1001, "CRECHE",
                                    ifelse(ETAPA_AJUSTADA == 1002, "PRÉ-ESCOLA",
                                           ifelse(ETAPA_AJUSTADA %in% c(1003, 1004, 1005, 1006, 1007, 1008, 1009, 1010, 1011), "ENSINO FUNDAMENTAL",
                                                  ifelse(ETAPA_AJUSTADA %in% c(1012,1013,1014, 1015), "ENSINO MÉDIO", "Erro")))),
         MODALIDADE_ENSINO = ifelse(NU_DURACAO_TURMA > 540 & MODALIDADE_ENSINO == "ENSINO MÉDIO", "ENSINO MÉDIO INTEGRAL",
                                    ifelse(TP_LOCALIZACAO_DIFERENCIADA %in% c(3,6), "QUILOMBOLA",
                                                  ifelse(IN_EDUCACAO_INDIGENA == 1 |TP_LOCALIZACAO_DIFERENCIADA %in% c(2,5), "INDÍGENA", MODALIDADE_ENSINO ))),
         CO_MUNICIPIO = as.character(CO_MUNICIPIO),
         VALOR_IDEAL = ifelse(MODALIDADE_ENSINO == "CRECHE", 1.07,
                              ifelse(MODALIDADE_ENSINO == "PRÉ-ESCOLA", 0.53,
                                     ifelse(MODALIDADE_ENSINO == "ENSINO FUNDAMENTAL", 0.36,
                                            ifelse(MODALIDADE_ENSINO == "ENSINO MÉDIO", 0.36,
                                                   ifelse(MODALIDADE_ENSINO == "ENSINO MÉDIO INTEGRAL", 2,
                                                          ifelse(MODALIDADE_ENSINO == "QUILOMBOLA", 0.64,
                                                                 ifelse(MODALIDADE_ENSINO == "INDÍGENA", 0.64, 999)))))))) %>%
  group_by(CO_MUNICIPIO, MODALIDADE_ENSINO, VALOR_IDEAL) %>%
  summarise(matriculas = n()) %>%
  ungroup() %>%
  left_join(municipios_ibge, by=c("CO_MUNICIPIO" = "CD_GEOCODI")) %>%
  mutate(MUNICIPIO = tolower(stri_trans_general(nome_mun, "Latin-ASCII"))) %>%
  select(MUNICIPIO, MODALIDADE_ENSINO, matriculas, VALOR_IDEAL)


repasse_pnae_por_aluno <- PNAE_RECURSOS_REPASSADOS_2018 %>%
  filter(ESTADO == "PE", 
         MODALIDADE_ENSINO != "EJA",
         MODALIDADE_ENSINO != "ATENDIMENTO EDUCACIONAL ESPECIALIZADO (AEE)") %>%
  mutate(MODALIDADE_ENSINO = ifelse(grepl("FUNDAMENTAL", MODALIDADE_ENSINO), "ENSINO FUNDAMENTAL",
                                    ifelse(grepl("INDÍGENA", MODALIDADE_ENSINO), "INDÍGENA",
                                           ifelse(grepl("QUILOMBOLA", MODALIDADE_ENSINO), "QUILOMBOLA", MODALIDADE_ENSINO))),
         VALOR_TOTAL_ESCOLAS_PNAE = gsub(",", ".", VALOR_TOTAL_ESCOLAS_PNAE),
         VALOR_TOTAL_ESCOLAS_PNAE = as.numeric(VALOR_TOTAL_ESCOLAS_PNAE),
         MUNICIPIO = tolower(stri_trans_general(MUNICIPIO, "Latin-ASCII"))) %>%
  group_by(MUNICIPIO, MODALIDADE_ENSINO) %>%
  summarise(valor_repassado = sum(VALOR_TOTAL_ESCOLAS_PNAE)) %>%
  ungroup() %>%
  left_join(matriculas_penae, by=c("MUNICIPIO","MODALIDADE_ENSINO")) %>%
  mutate(valor_repassado_por_aluno_por_dia_letivo = round((valor_repassado/matriculas)/200,2))
  
repasse_pnae_por_aluno %>%
  slice(1:20) %>%
  kable()

```

---

## Empresas que atendem ao PNAE

Aqui apresento alguns cruzamentos que foram possíveis de se fazer com as bases CEIS, QSA e RAIS.

Importante lembrar que ainda não possuímos dados de contrato, então não podemos dizer exatamente quem forneceu alimentos para as escolas públicas de Pernambuco.

### 7. Quantas micro e pequenas empresas estão autorizadas a vender como "agricultura familiar" em PE ?

* Repasses PNAE X DAP

Importante: 

    * Constam apenas as primeiras 20 linhas;
    * A base das DAPs ativas não possui o CNPJ da microempresa dos agricultores, apenas o nome dos titulares;
    * A existência de uma DAP não significa que, naquele período (no caso 2018) o produtor tenha fornecido alimentos para o ente executor;
    * O Valor de 30% mínimo destinado à agricultura familiar é um pouco frouxo, de acordo com informações dos anos de 2011 a 2016 municípios utilizaram mais e menos do que 30% para compra de alimentos vindos da agricultura familiar. Fonte: [https://www.fnde.gov.br/programas/pnae/pnae-consultas/pnae-dados-da-agricultura-familiar](https://www.fnde.gov.br/programas/pnae/pnae-consultas/pnae-dados-da-agricultura-familiar)  .


```{r, echo=FALSE, warning=FALSE}

dap_2019 <- load("~/brazilian_funds_db/dbs/DAP Pessoas Físicas Ativas/20190101-dap_pessoa_fisica.RData")

dap_pe <- `20190101-dap_pessoa_fisica` %>%
  filter(UF == "PE") %>%
  mutate(MUNICIPIO = tolower(stri_trans_general(MUNICIPIO, "Latin-ASCII"))) %>%
  group_by(MUNICIPIO) %>%
  summarise(daps_ativas = n()) %>%
  ungroup()

valores_pnae_dap <- repasse_pnae_por_aluno %>%
  group_by(MUNICIPIO) %>%
  mutate(valor_repassado = as.numeric(valor_repassado)) %>%
  summarise(valor_repassado = sum(valor_repassado, na.rm=TRUE),
            valor_min_agricultura_familiar = 0.30*valor_repassado) %>%
   ungroup() %>%
   left_join(dap_pe)
 
valores_pnae_dap %>%
  slice(1:20) %>%
  kable()

```


### 8. Titulares de DAP x QSA

* Titulares das DAP em Pernambuco X QSA

Aparentemente nenhum nome que consta como titular da DAP em Pernambuco está no quadro societário de uma empresa do mesmo estado.

```{r, echo = FALSE, warning=FALSE}

#Abrindo o QSA de Pernambuco, nome do objeto é x
load("~/brazilian_funds_db/dbs/QSA/PE_qsa.rData")

qsa_pe <- x %>%
  filter(TIPO == 2) %>%
  select(CNPJ, QUALIFICACAO_DO_SOCIO, NOME_DO_SOCIO) %>%
  mutate(NOME_AJUSTADO = tolower(stri_trans_general(NOME_DO_SOCIO, "Latin-ASCII" )))

titulares_dap_pe <- `20190101-dap_pessoa_fisica` %>%
  filter(UF == "PE") %>%
  select(DAP, ENQUADRAMENTO, NOME_T1, NOME_T2, MUNICIPIO) %>%
  gather(tipo_titular, nome_titular, NOME_T1, NOME_T2) %>%
  filter(nome_titular != "") %>%
  mutate(NOME_AJUSTADO = tolower(stri_trans_general(nome_titular, "Latin-ASCII" )),
         NOME_AJUSTADO = gsub("0", "o", NOME_AJUSTADO),
         NOME_AJUSTADO = gsub("\\* ", "", NOME_AJUSTADO),
         NOME_AJUSTADO = gsub("'", "", NOME_AJUSTADO)) %>%
  left_join(qsa_pe, by=c("NOME_AJUSTADO"))

```


### 9. Titulares de DAP x RAIS

* Titulares das DAP (obtidos pelo cruzamento com QSA) em Pernambuco X RAIS

Como não tivemos nenhum match entre Quadros societários e DAPs ativas, não foi possível cruzar realizar cruzamentos com a RAIS

```{r, echo = F}

```



---

## Anexo 1

### Tabela do ajuste das etapas do ensino básico:

|TP_ETAPA_ENSINO|ETAPA_AJUSTADA|
|:--|:--|
|1 - Educação Infantil - Creche|	1001|
|2 - Educação Infantil - Pré-escola|	1002|
|4 - Ensino Fundamental de 8 anos - 1ª Série|	1004|
|5 - Ensino Fundamental de 8 anos - 2ª Série|	1005|
|6 - Ensino Fundamental de 8 anos - 3ª Série|	1006|
|7 - Ensino Fundamental de 8 anos - 4ª Série |	1007|
|8 - Ensino Fundamental de 8 anos - 5ª Série	|1008|
|9 - Ensino Fundamental de 8 anos - 6ª Série	|1009|
|10 - Ensino Fundamental de 8 anos - 7ª Série	|1010|
|11 - Ensino Fundamental de 8 anos - 8ª Série	|1011|
|14 - Ensino Fundamental de 9 anos - 1º Ano	|1003|
|15 - Ensino Fundamental de 9 anos - 2º Ano	|1004|
|16 - Ensino Fundamental de 9 anos - 3º Ano	|1005|
|17 - Ensino Fundamental de 9 anos - 4º Ano	|1006|
|18 - Ensino Fundamental de 9 anos - 5º Ano	|1007|
|19 - Ensino Fundamental de 9 anos - 6º Ano	|1008|
|20 - Ensino Fundamental de 9 anos - 7º Ano	|1009|
|21 - Ensino Fundamental de 9 anos - 8º Ano	|1010|
|41 - Ensino Fundamental de 9 anos - 9º Ano	|1011|
|25 - Ensino Médio - 1ª Série	|1012|
|26 - Ensino Médio - 2ª Série	|1013|
|27 - Ensino Médio - 3ª Série	|1014|
|28 - Ensino Médio - 4ª Série	|1015|
|30 - Curso Técnico Integrado (Ensino Médio Integrado) 1ª Série	|1012|
|31 - Curso Técnico Integrado (Ensino Médio Integrado) 2ª Série	|1013|
|32 - Curso Técnico Integrado (Ensino Médio Integrado) 3ª Série	|1014|
|33 - Curso Técnico Integrado (Ensino Médio Integrado) 4ª Série	|1015|
|35 - Ensino Médio - Normal/Magistério 1ª Série	|1012|
|36 - Ensino Médio - Normal/Magistério 2ª Série	|1013|
|37 - Ensino Médio - Normal/Magistério 3ª Série	|1014|
|38 - Ensino Médio - Normal/Magistério 4ª Série	|1015|

OBSERVAÇÃO: Existem 123.925 entradas como "0". Esse valor não consta no dicionário de dados do INEP. Enquanto eu aguardo o pedido de acesso à informação, vou retira-lo da análise inserindo "0" no objeto not_basico (veja abaixo)

