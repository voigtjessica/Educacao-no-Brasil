# Dados do SIOPE

### O que é SIOPE?
O Sistema de Informações sobre Orçamentos Públicos em Educação (SIOPE) é uma ferramenta eletrônica de coleta, processamento e acesso público às informações dos orçamentos de educação da União, dos estados, do Distrito Federal e dos municípios. Ela é mantida pelo FNDE.

*Arquivo : Receita Total*

|Nome da Coluna| Descrição do Dado|
|--|--|
|AN_EXERCICIO| Ano base da declaração|
|TP_PERIODO |Tipo do período ( A-anual, S-semestral, B-bimestral)|
|NU_PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF |Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF |Nome da unidade federativa|
|CO_ MUNICIPIO |Código do município. É o código completo usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.|
|ESF_ADM |Esfera administrativa (Estadual, Municipal)|
|CO_ CONTA_CONTABIL |Código de exibição do item de despesa, conta contábil|
|NO_ CONTA_CONTABIL |Nome da conta contábil|
|VL_RECEITA_ PREVISAO_ATUALIZADA |Valor de receita prevista|
|VL_RECEITA_REALIZADA| Valor de receita realizada|
|VL_RECEITA_ORCACADA |Valor de receita orçada|

*Aquivo: Despesa Total* 

|Nome da Coluna| Descrição do Dado|
|--|--|
|NA_EXERCICIO| Ano base da declaração|
|TP_ PERIODO| Tipo do periodo ( A-anual, S-semestral, B-bimestral)|
|NU_ PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF |Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF |Nome da unidade federativa|
|CO_MUNICIPIO |Código do município. É o código completo usado pelo IBGE.|
|NO_ MUNICIPIO| Nome do município.|
|NO_GRUPO_DESPESA| Nome do Grupo de Despesa, podendo ser Fundeb, Própria, Vinculada ou Outros|
|CODIGO_SUBF_PASTA| Código da Subfunção, que são:|
|CODIGO_EXIBICAO_PASTA_PAI| Código da pasta|
|CO_EXIBICAO_PASTA| Código de exibição|
|NO_PASTA| Nome da pasta|
|NO_PASTA _PAI |Nome da pasta|
|NO_CRECHE_PRE_ESCOLA| Desdobramento da Educação Infantil em Creche ou Pré-Escola|
|CO_CONTA_CONTABIL| Código de exibição do item de despesa, conta contábil|
|NO_CONTA_CONTABIL| Nome do item de despesa conta contábil.|
|DS_PROFISSIONAIS| Discriminação entre profissionais do magistério, outros profissionais da educação e outros itens|
|TIPO_CONTA| Discriminação das contas em analíticas (dados brutos) ou sintéticas (somatório de outras contas)|
|VL_DESPESA_DOTACAO_ATUALIZADA| Valor de despesa|
|VL_DESPESA_EMPENHADA| Valor de despesa|
|VL_DESPESA_LIQUIDA| Valor de despesa|
|VL_DESPESA_PAGA| Valor de despesa|
|VL_DESPESA_ORCADA| Valor de despesa|

*Arquivo: Informações Complementares*

|Nome da Coluna| Descrição do dado|
|--|--|
|AN_EXERCICIO| Ano base da declaração|
|TP_PERIODO| Tipo do período ( A-anual, S-semestral, B-bimestral)|
|NU_PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF| Código do município.É o código completo usado pelo IBGE.|
|NO_UF| Nome da unidade federativa|
|CO_MUNICIPIO| Código do município. E o mesmo código usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.|
|ESF_ADM| Esfera administrativa (Estadual, Municipal)|
|CO_CONTA_CONTABIL| Código de exibição do item de despesa, conta contábil|
|NO_CONTA_CONTABIL| Nome do item de despesa conta contábil.|
|VL_DECLARADO| Valor declarado para o item.|

*Arquivo: Remuneração dos Profissionais de Educação*

|Nome da Coluna| Descrição do Dado|
|--|--|
|AN_EXERCICIO| Ano base da declaração|
|NU_PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|ME_EXERCICIO| Mês do ano em que foram pagos os vencimentos para o profissional de educação (1 a 12)|
|CO_UF| Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF| Nome da unidade federativa|
|CO_MUNICIPIO| Código do município.É o código completo usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.|
|NU_REMUNERACAO| Sequencial de remuneração|
|NO_PROFISSIONAL| Nome do profissional do magistério/Educação.|
|LOCAL_ EXERCICIO| Escola onde o profissional exerce sua função / Entidade|
|CARGA_HORARIA| Carga Horária de trabalho do profissional|
|TP_CATEGORIA| Código do tipo de categoria do profissional: 1 - Profissionais do magistério; 2 - Outros profissionais da educação.|
|CATEG_PROFISSIONAL| Número sequencial da categoria do profissional do magistério/Educação.|
|VL_SALARIO| Salário ou Vencimento Básico do profissional da educação|
|VL_PARC_MINIMA_FUNDEB| Vencimento Bruto da Remuneração - Com Parcela mínima de 60% do FUNDEB|
|VL_PARC_MAXIMA_FUNDEB| Valor Bruto da Remuneração - Com parcela máxima de 40% do FUNDEB|
|VL_OUTRAS_RECEITAS| Valor Bruto da Remuneração - Com outros recursos|
|VL_TOTAL| VL_PARC_MINIMA_FUNDEB + VL_PARC_MAXIMA_FUNDEB + VL_OUTRAS_RECEITAS|

*Arquivo: Dados Gerais – Responsáveis*

|Nome da Coluna| Descrição do Dado|
|--|--|
|AN_EXERCICIO| Ano base da declaração|
|TP_PERIODO| Tipo do período ( A-anual, S-semestral, B-bimestral)|
|NU_ PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF| Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF| Nome da unidade federativa|
|CO_MUNICIPIO| Código do município.É o código completo usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.|
|ESF_ADM| Esfera administrativa (Estadual, MunicipalP = Governador, C = Contador Geral,
S = Secretário de Educação, F = Secretário de Fazenda.|
|NO_RESPONSAVEL| Nome do responsável que responde pela declaração|
|END_RESPONSAVEL| Endereço do responsável|
|END_COMPLEMENTO| Complemento do endereço do responsável|
|END_NUMERO| Número do endereço do responsável|
|SG_UF_RESPONSAVEL| Sigla da UF do responsável|
|BAIRRO_RESPONSAVEL| Bairro do responsável|
|CEP_PRESPONSAVEL| CEP do responsável|
|TEL_RESPONSAVEL| Telefone de contato do responsável|
|EMAIL_RESPONSAVEL| Endereço de e-mail do responsável|

*Arquivo: Dados Consolidados*

|Nome da Coluna| Descrição do Dado|
|AN_EXERCICIO| Ano base da declaração|
|TP_PERIODO| Tipo do período ( A-anual, S-semestral, B-bimestral)|
|NU_PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF| Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF| Nome da unidade federativa|
|CO_MUNICIPIO| Código do município.É o código completo usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.ESF_ADM Esfera administrativa (Estadual, Municipal)|
|VL_RECEITA_PREVISAO_ATUALIZADA| Valor de receita prevista atualizada|
|VL_RECEITA_REALIZADA |Valor de receita realizada|
|VL_RECEITA_ORCACADA| Valor de receita orçada|
|VL_DESPESA_DOTACAO_ATUALIZADA| Valor de despesa dotada atualizada|
|VL_DESPESA_EMPENHADA| Valor de despesa empenhada|
|VL_DESPESA_LIQUIDADA| Valor de despesa liquidada|
|VL_DESPESA_PAGA| Valor de despesa paga|
|VL_DESPESA_ORCADA| Valor de despesa orçada|
|VL_DOTACAO_ATUALIZADA EDUCACAO| Valor de despesa dotada atualizada com educação|
|VL_DESPESA_EMPENHADA EDUCACAO| Valor de despesa empenhada com educação|
|VL_DESPESA_ LIQUIDADA_EDUCACAO| Valor de despesa liquidada com educação|
|VL_DESPESA_PAGA_EDUCACAO| Valor de despesa paga com educação|
|VL_DESPESA_ORCADA_EDUCACAO| Valor de despesa orçada com educação|

*Arquivo: Indicadores*

|Nome da Coluna| Descrição do Dado|
|AN_EXERCICIO| Ano base da declaração|
|TP_PERIODO| Tipo do período ( A-anual, S-semestral, B-bimestral)|
|NU_PERIODO| Período do ano base a que se refere a declaração (1,2,3,4,5,6). De 2008 a 2016, o período 1 refere-se à declaração anual. A
partir de 2017, os dados passaram a ser bimestrais, sendo o período 6 a consolidação anual|
|CO_UF| Código da UF. Mesmo código usado pelo IBGE.|
|NO_UF| Nome da unidade federativa|
|CO_MUNICIPIO| Código do município.É o código completo usado pelo IBGE.|
|NO_MUNICIPIO| Nome do município.|
|ESF_ADM| Esfera administrativa (Estadual, Municipal)|
|CO_INDICADOR| Código do indicador|
|NO_INDICADOR| Descrição do indicador|
|VL_DECLARADO| Valor do indicador|

