## Arquivos QSAs por uf.

Essa pasta contém arquivos dos Quadros Societários e de Administradores das Pessoas Jurídicas (QSA), separados por UF. 

*Fonte:* [http://dados.gov.br/dataset/qsa](http://dados.gov.br/dataset/qsa)

*Órgão responsável:* Receita Federal

*Abrangência:* nacional

*Atualização:* semestral

*Primeira atualização:* Não tenho informações sobre a primeira atualização desta base. A base atual foi atualizada no portal [dados](http://dados.gov.br/dataset/qsa) dia 03/08/2018 e coletada pela Tbrasil dia 19/03/2019.

*Descrição:* Guia com as informações dos quadros societários e de administradores das Pessoas Jurídicas: tipo (PF ou PJ) CNPJ e nome. 

*O que podemos fazer com a base? :*

* Cruzar os dados dos estabelecimentos RAIS com os cnpj e descobrir quem integra o quadro societário
* Cruzar dados dos estabelecimentos com dados das compras públicas em transparência ativa nos estados e municípios
* Cruzar informações dos estabelecimentos com as DAP para saber se, de fato, as empresas que contém a DAP estão de acordo com os pré-requisitos.

*Problemas:*

* A base não possui os CPFs. 

*Descrição das variáveis:*

Todos os arquivos contém a mesma estrutura:

Nome variável | Descrição|
|:---:|:----|
|dado_original| Dado como foi coletado a partir da área de transparência da Receita Federal|
|TIPO| 01 = "informação da empresa", 02 = "informação do sócio" |
|NM_TIPO|descrição do tipo|
|CNPJ| CNPJ da empresa, somente números|                    
|NOME_EMPRESARIAL| Nome da empresa |
|INDICADOR_CPF_CNPJ| Indica a natureza do sócio|       
|NM_INDICADOR_CPF_CNPJ| Descrição da natureza do sócio|    
|CPF_CNPJ_SOCIO| Caso o sócio seja pessoa física, o campo será preenchido com 0. Caso o sócio seja PJ, será preenchido com o CNPJ da empresa pertencente ao QSA|          
|QUALIFICACAO_DO_SOCIO| Código da qualificação do sócio|  
|NM_QUALIFICACAO_DO_SOCIO| Descrição da qualificação do sócio|
|NOME_DO_SOCIO| Nome da pessoa|
|ATUALIZACAO*| Data da atualização desse dado, de acordo com a Receita Federal|
|UF*| Unidade federativa do dado| 

*Dados não originais, inseridos pela Tbrasil.
