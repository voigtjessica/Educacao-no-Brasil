# Relação Anual de Informações Sociais - RAIS ESTABELECIMENTOS


*Fonte:* [ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/](ftp://ftp.mtps.gov.br/pdet/microdados/RAIS/) . No entanto, para obter os CNPJs solicitamos a base via Lei de Acesso à Informação. Dessa forma, ela contém menos variáveis que as bases disponíveis nesse link.

*Órgão responsável:* O Ministério do Trabalho e da Previdência Social (MTPS) gerencia essa base, mas os dados são fornecidos anualmente pelos próprios empregadores.

*Abrangência:* nacional

*Atualização:* anual

*Primeira atualização:* Os dados que solicitamos via LAI (que contém o CNPJ dos estabelecimentos) se iniciam em 2015. No entanto, as bases fornecidas pelo MTPS (vide fonte) constam desde 1985.

*Descrição:* A RAIS consiste em uma relação fornecida sobre os estabelecimentos e porte da empresa / quantidade de empregados. Trata-se de uma espécie de "Censo" do trabalho formal. Mais informações estão disponíveis no [Manual da RAIS](http://www.rais.gov.br/sitio/rais_ftp/ManualRAIS2018.pdf)

*O que podemos fazer com a base? :*

* Cruzar os dados dos estabelecimentos com informações sobre os quadros societários pelo CNPJ;
* Cruzar dados dos estabelecimentos com dados das compras públicas em transparência ativa nos estados e municípios
* Cruzar informações dos estabelecimentos com as DAP para saber se, de fato, as empresas que contém a DAP estão de acordo com os pré-requisitos.

*Problemas:*

* Base não veio com o codebook completo. Algumas das variáveis do banco que recebemos via LAI foram deduzidas pela cientista de dados (veja em Conteúdo dos Arquivos);
* Para obter os CNPJS, teremos que atualizar a base anualmente por meio de pedidos de acesso à informação.

## Conteúdo dos Arquivos

|Variável|Descrição|
|:---:|:---:|
|Ano| Ano em que o dado foi coletado|
|CEP Estab| CEP do estabelecimento, número e pontos|
|CNAE 2.0 Classe| Código Classificação Nacional de Atividades Econômicas|
|CNAE 2.0 Classe| Descrição Classificação Nacional de Atividades Econômicas|
|CNPJ / CEI| CNPJ números, pontos e barras|
|Natureza Jurídica| NAT JURIDICA Natureza Jurídica (CONCLA/2002) - a partir da RAIS2008|
|Porte Estabelecimento| Porte do estabelecimento|
|Qtd Estoque Aprendiz Ativo| Quantidade de funcionário aprendiz |
|Qtd Estoque CLT Defic Ativo| Quantidade de funcionários CLT com deficiência ativos * | 
|Qtd Estoque Estat Defic Ativo| Quantidade de funcionários estatutários com deficiencia ativos * |
|Qtd Portador Defic| Quantidade de portadores de deficiência|
|Qtd Vínculos Ativos|Estoque de vínculos ativos em 31/12 (quando acumulada representa a soma dos vinculos ativos)|   
|Qtd Vínculos CLT| Estoque de vínculos, sob o regime CLT e Outros, ativos em 31/12 (quando acumulada representa a soma dos vinculos ativos)|
|Qtd Vínculos Estatutários|Estoque de vínculos, sob o regime estatutário, ativos em 31/12 (quando acumulada representa a soma dos vinculos ativos)|
|Razão Social| Razão social do estabelecimento|
|Tamanho Estabelecimento| Tamanho do estabelecimento - empregados ativos em 31/12 (10 categorias) |
|UF|Unidade da Federação do estabelecimento|

 |* Variáveis não constavam no Codebook fornecido pelo Ministério do Trabalho e Emprego e foram deduzidos pela cientista de dados.
