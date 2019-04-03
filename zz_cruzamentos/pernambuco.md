# Pernambuco

Cruzamentos PE em .rdm (para ter acesso aos gráficos plotados): [http://rpubs.com/voigtjessica/edu_pe](http://rpubs.com/voigtjessica/edu_pe)

1. Qual foi a população de pernambuco matriculada no ensino básico em 2018?

Para ver a população do censo escolar, vou pegar os arquivos Rdata que eu já havia extraído da base. Para ver como eu extraí a base [acesse a pasta do censo escolar no meu Github](https://github.com/voigtjessica/Educacao-no-Brasil/blob/master/censo_escolar/abrindo_arquivos.R)

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


Carregando os bancos do censo escolar:

```{r, echo=T, eval=TRUE, warning=FALSE}

library(dplyr)
library(ggplot2)

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/docentes_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/escolas_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/matriculas_pe.Rdata")

load("C:/Users/coliv/Documents/brazilian_funds_db/dbs/microdados_educacao_basica_2018/microdados_ed_basica_2018/DADOS/Pernambuco/turmas_pe.Rdata")

#retirando alunos que não são do ensino básico (Técnico não integrado, supletivo e EJA)
not_basico <- c(29,34,39,40,68,65,67,69,70,71,72,73,74)


#criando um objeto para ajustar alunos que estão no fundamental de 8 e de 9 anos.
ajuste_etapa <- data.frame(TP_ETAPA_ENSINO = c(1,2,4,5,6,7,8,9,10,11,14,15,16,17,18,19,20,21,
                                               41,25,26,27,28,30,31,32,33,35,36,37,38),
                           ETAPA_AJUSTADA = c(1001,1002,1004,1005,1006,1007,1008,1009,1010,1011,1003,
                                              1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,
                                              1015,1012,1013,1014,1015,1012,1013,1014,1015))


matriculas_pe_basico <- matriculas_pe %>%
  filter(!TP_ETAPA_ENSINO %in% not_basico) %>%
  left_join(ajuste_etapa, by=c("TP_ETAPA_ENSINO")) %>%
  mutate(TIPO_FUNDAMENTAL = ifelse(TP_ETAPA_ENSINO %in% c(4:11), "8 anos",
                                   ifelse(TP_ETAPA_ENSINO %in% c(14, 15, 16, 17, 18, 19, 20, 21, 41), "9 anos", NA)))


```


Distribuição dos alunos:
```{r, echo = T, eval = TRUE, warning=FALSE}

matriculas_pe_basico %>% 
  group_by(ETAPA_AJUSTADA) %>%
  summarize(alunos_mil = n()/1000, na.rm=TRUE) %>%
  arrange(ETAPA_AJUSTADA) %>%
  ggplot() +
  geom_col(aes(x=ETAPA_AJUSTADA,y=alunos_mil))

```
