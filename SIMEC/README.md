# SIMEC

**Descrição:** Contém as informações sobre o andamento das obras pactuadas no âmbito do programa [PROINFÂNCIA](http://www.fnde.gov.br/programas/proinfancia/sobre-o-plano-ou-programa/sobre-o-proinfancia) . Essa informação é inserida periodicamente pelos entes executores para a garantia dos repasses para a execução da obra.

**Fonte:** [http://simec.mec.gov.br/painelObras/index.php](http://simec.mec.gov.br/painelObras/index.php) 

**Órgão responsável:** FNDE

**Abrangência:** nacional

**Atualização:** diária (é esperado que cada ente atualize o campo relativo às suas obras em um intervalo aproximado de dois meses, na prática não temos como garantir que todas as obras serão atualizadas nesse período).

**Última atualização:** Planilhas atual é de 24/04/2019. 

**Problemas encontrados:** Dados disponíveis sobre as etapas de execução das obras, valores dos repasses, endereços das construções, datas de assinatura de contrato e previsão de entrega são muitas vezes imprecisos ou estão ausentes. Como esses dados também embasam o projeto "Tá de Pé", já realizamos dois estudos sobre esses dados, o primeiro 2m 2017 mais focado nas [inconsistências dos dados do SIMEC](https://www.transparencia.org.br/downloads/publicacoes/RelatorioTadePe23082017.pdf) e outro em 2018 que tratou das [obras com problemas](https://www.transparencia.org.br/downloads/publicacoes/Relat%C3%B3rio_campanha%20TdP_final.pdf) (obras não iniciadas, paralisadas, atrasadas e sem endereço).

**O que podemos fazer com ela?** Podemos verificar atrasos e problemas de entrega nas obras financiadas pelo PROINFÂNCIA e identificar fraudes.


### Codebook:

| Nome variável      | Descrição   |
| :-------------: |:-------------:|
| ID    | Id da obra, gerado pelo FNDE |
| Nome| Nome da obra, de acordo com o acordo firmado com o FNDE (pode ser que a escola / creche tenha adotado um outro nome ) |
| Situação | Situação oficial da obra, de acordo com o FNDE (ver abaixo) |
| Município | Município onde se localiza a obra |
| UF | UF onde se localiza a obra |
| CEP | CEP onde se localiza a obra, de acordo com ente executor |
| Logradouro | Logradouro onde se localiza a obra , de acordo com ente executor |
| Bairro | Bairro onde se localiza a obra , de acordo com ente executor |
|Termo/Convênio| Termo ou convênio que pactuou a obra. Um convênio pode conter mais de uma obra|
|Fim da Vigência Termo/Convênio| Data para fim da vigência do termo/convênio|
|Situação do Termo/Convênio| Assume dois valores: "Vigente" e "Vencido"|
|Percentual de Execução| Percentual de execução da obra, de acordo com o ente executor
| Data Prevista de Conclusão da Obra | Data prevista de conclusão da obra oficial |
|Tipo de ensino / Modalidade| Tipo de ensino que a obra vai atender|
| Tipo do Projeto | Projeto arquitetônico da obra |                   
|Tipo da Obra | Categoria mais geral da obra, assume os seguintes valores "Construção", "Ampliação", "Ampliação/Reforma", "Reforma", "Instalações"|
| Classificação da Obra | A qual região a obra atende, assume os valores "Urbana", "Rural", "Indigena" e "Quilombo"|
|Valor Pactuado pelo FNDE| Valor (corrente) pactuado com o FNDE para essa obra. Percebemos que esse valor às vezes representa o valor para todo o convênio, e não apenas para a obra descrita naquela linha |
|Rede de Ensino Público| Rede de ensino público para a qual aquela obra vai atender|
|CNPJ| CNPJ do ente executor|
|Inscrição Estadual | Inscrição Estadual do ente executor|
|Nome da Entidade| Nome do ente executor|
|Razão Social| Razão Social do ente executor|
|Email| Email do ente executor|
|Sigla| Sigla do ente executor |
|Telefone Comercial| Telefone Comercial do ente executor|
|Fax| Fax do ente executor|
|CEP Entidade| CEP do ente executor|
|Logradouro Entidade| Logradouro do ente executor|
|Complemento Entidade| Complemento do endereço do ente executor|
|Número Entidade| Número do endereço do ente executor|
|Bairro Entidade| Bairro do endereço do ente executor|
|UF Entidade| UF do ente executor|
|Munícipio Entidade| Município ente executor|
|Modalidade de Licitação| Modalidade da licitação da obra. Assume os valores: "Tomada de Preço", "Convite", "Concorrência", "Pregão", "Dispensa", "RDC", "Inexigibilidade"|
|Número da Licitação| Número da Licitação|
|Homologação da Licitação| Data da homologação da licitação|
|Empresa Contratada| Nome da empresa contratada|
|Data de Assinatura do Contrato| Data em que o contrato com a empresa foi assinado|
|Prazo de Vigência| Prazo de vigência do contrato entre o ente executor e a empresa|
|Data de Término do Contrato| Data de término do contrato entre o ente executor e a empresa|
|Valor do Contrato| Valor do contrato entre o ente executor e a empresa. Assim como no valor pactuado, não está claro se o valor contempla uma ou mais obras|
|Valor Pactuado com o FNDE| Aparentemente é uma coluna repetida|
|Data da Última Vistoria do Estado ou Município| Informação inserida pelo engenheiro que faz a vistoria|
|Situação da Vistoria| Em tese, essa coluna deve ser igual a coluna situação|
|OBS| Observações feitas pelo técnico responsável pela vistoria ou ente executor|
|Total Pago| Total pago do FNDE para o ente executor, também não está claro se diz respeito ao valor por obra ou por convênio|
|Percentual Pago| Percentual do valor total pactuado|
|Banco| Banco em que foi depoistado o pagto|
|Agência| |
|Conta| |
|Data| Não está claro se é a data do último depósito ou a data da última atualização|
|Saldo da Conta| |
|Saldo Fundos| |
|Saldo da Poupança| |
|Saldo CDB| | |
|Saldo TOTAL| |

### Observações

#### Situação

Pode assumir os seguintes valores:

* Concluída
* Inacabada : obra iniciada que não será mais executada (abandonada)
* Obra Cancelada: obra não iniciada que não será mais executada (pode ter tido transferência mas não houve uso do dinheiro) 
* Planejamento pelo proponente: fase pré-licitação, de elaboração / escolha do projeto
* Execução: obra com execução normal
* Paralisada: obra iniciada, paralisada e que deverá ser retomada pelo ente executor                  
* Licitação: Obra está sendo licitada
* Contratação: Licitação já foi realizada e o contrato está sendo feito
* Em Reformulação: Quando há interrupção do contrato. Nunca ficou claro se as obras com esse status já teriam sido iniciadas ou se obras não iniciadas também poderiam ter esse status.

É importante frisar que essa classificação é oficial e apenas no caso "em reformulação" admite a existência de um segundo contrato para uma mesma obra. Isso foi abordado no [relatório da Transparência Brasil em 2017](https://www.transparencia.org.br/downloads/publicacoes/RelatorioTadePe23082017.pdf) :

*"A Transparência Brasil constatou, entretanto, que das 2.477 obras em reformulação, licitação ou planejamento pelo proponente, 756 (31%) são obras que já foram iniciadas no passado, tiveram que ser interrompidas e voltaram para fases iniciais pré-construção. Portanto, seria mais preciso que essas obras fossem classificadas como inacabadas ou paralisadas e que estão para serem retomadas."*

