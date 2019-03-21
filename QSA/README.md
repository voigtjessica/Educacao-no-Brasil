## Arquivos QSAs por uf.

Essa pasta contém arquivos dos Quadros Societários e de Administradores das Pessoas Jurídicas (QSA), separados por UF. Eles foram atualizados no portal [dados](http://dados.gov.br/dataset/qsa) dia 03/08/2018 e coletados pela Tbrasil dia 19/03/2019.

Todos eles contém a mesma estrutura:

Nome variável | Descrição|
|:---:|:----|
|dado_original| Dado como foi coletado a partir da área de transparência do Ministério da Fazenda|
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
|ATUALIZACAO*| Data da atualização desse dado, de acordo com o Ministério da Fazenda|
|UF*| Unidade federativa do dado| 

*Dados não originais, inseridos pela Tbrasil.
