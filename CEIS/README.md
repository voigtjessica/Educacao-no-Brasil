# Cadastro de Empresas Inidôneas e Suspensas (CEIS)


*Fonte:* [http://www.portaltransparencia.gov.br/sancoes/ceis?ordenarPor=nome&direcao=asc](http://www.portaltransparencia.gov.br/sancoes/ceis?ordenarPor=nome&direcao=asc)

*Órgão responsável:* A Controladoria-Geral da União é responsável pelo Sistema Integrado de REgistro CEIS/CNEP, no entanto a Lei 12.846/2013 (Lei Anticorrupção) trouxe a obrigatoriedade para os entes públicos, de todos os Poderes e esferas de governo, de manter o cadastro atualizado. 

*Abrangência:* nacional 

*Atualização:* diária (prazo legal de cinco dias úteis, a contar da publicação da sanção)

*Primeira atualização:* Penalidades vigentes, coletadas a partir de 2008.

*Descrição:* O Cadastro Nacional de Empresas Inidôneas e Suspensas (CEIS) apresenta a relação de empresas e pessoas físicas que sofreram sanções que implicaram a restrição de participar de licitações ou de celebrar contratos com a Administração Pública. Diz respeito à todos os órgãos da administração pública. Contém apenas as penalidades vigentes.

Metodologia/Fontes de Informação

    1. Registro, pelos órgãos e entidades do Poder Executivo Federal, das respectivas penalidades no Sistema CGU-PJ; 
    2. Extração das penalidades decorrentes de improbidade administrativa via importação de dados do Cadastro Nacional de Condenações por Improbidade Administrativa e Inelegibilidade (CNCIAI), mantido pelo Conselho Nacional de Justiça;
    3. Extração das penalidades decorrentes de decisão do Tribunal de Contas da União via importação de dados do Sistema Inabilitados e Inidôneos, mantido pelo Tribunal; e 
    4. Registro, pelos órgãos e entidades das demais esferas e poderes, das respectivas penalidades no Sistema Integrado de Registro CEIS/CNEP (SIRCAD).

Política de revisão (retirar uma empresa do cadastro)

    1. Término do prazo de vigência da penalidade; 
    2. Registro da exclusão da penalidade no CGU-PJ pelo órgão responsável; 
    3. Registro da exclusão da penalidade no SIRCAD pelo órgão responsável; 
    4. Apresentação pelas partes interessadas de decisão judicial quanto à exclusão da penalidade; ou 
    5. Registro da exclusão da penalidade nas bases do CNCIAI e do Sistema Inabilitados e Inidôneos.

*O que podemos fazer com a base?* : 

    * Cruzar com dados de contratos públicos para identificar se a suspensão está sendo cumprida;
    * Cruzar informações sobre o quadro societário das empresas (QSA) e RAIS para verificar se donos de empresas suspensas estão relacionados com o setor público por alguma outra empresa.

*Problemas:* 

* Base exigirá atualização constante, o ideal seria ter acesso a alguma API do sistema.
* Base tem como referência de UF a UF do órgão imputador. Até onde eu reparei, todas as empresas poderiam atender em todo o país. A base ficará muito grande.

---------------

### Conteúdo dos arquivos

|Variável|Descrição|
|:------:|:--:|
|CNPJ/CPF da Pessoa ou Empresa Sancionada| 18 dígitos, números traços e barras|
|Razão Social| Razão social sem acento|
|Nome da Pessoa ou Empresa Sancionada| Nome da pessoa ou empresa com acento|
|Nome Fantasia da Empresa Sancionada| Nome fantasia sem acento|
|UF do sancionado| UF onde se localiza a empresa sancionada|
|Tipo de Pessoa|"Pessoa Jurídica" ou "Pessoa física"|
|Tipo da Sanção|Sanção que foi imputada à empresa. "Impedimento - Lei do Pregão" / "Suspensão - Lei de Licitações" / "Proibição - Lei de Improbidade" / "Inidoneidade - Legislação Estadual" / "Inidoneidade - Lei Orgânica TCU" / "Impedimento - Legislação Estadual" / "Inidoneidade - Lei de Licitações" / "Suspensão - Legislação Municipal" / "Decisão judicial liminar/cautelar que impeça contratação"|
|Data Inicial da Sanção| DD/MM/AAAA|
|Data Final da Sanção| DD/MM/AAAA|
|Nome do Órgão Sancionador| Nome de quem imputou a sanção|

------------

Descrição "Tipo da Sanção"

|Tipo de sanção| Base legal|Período|Razão|Abrangência|
|:--:|:---:|:---:|:----:|:---:|
|Impedimento - Lei do Pregão|  Art. 7º Lei nº 10.520/2002 | Até 5 anos|Não celebrar o contrato, deixar de entregar ou apresentar documentação falsa exigida para o certame, ensejar o retardamento da execução de seu objeto, não mantiver a proposta, falhar ou fraudar na execução do contrato, comportar-se de modo inidôneo ou cometer fraude fiscal| União, Estados, Distrito Federal ou Municípios| 
|Suspensão - Lei de Licitações| Art. 87 e Art. 88 Lei 8.666/1993| Até 2 anos|  Inexecução total ou parcial do contrato a Administração /  Condenação definitiva por prática dolosa de fraude fiscal / Ats ilícitos contra os objetivos da licitação / Falta de idoneidade por outros atos ilícitos praticados|União, Estados, Distrito Federal ou Municípios|
|Proibição - Lei de Improbidade|Art. 12 Lei 8.429/1992| De 3 a 10 anos| Condenação por improbridade administrativa (esfera cível: dano ao erário, enriquecimento ilícito, obter vantagem patrimonial em razão do cargo, violação de princípios da adm. pública)|União, Estados, Distrito Federal ou Municípios|
|Inidoneidade - Legislação Estadual|
|Inidoneidade - Lei Orgânica TCU|
|Impedimento - Legislação Estadual|
|Inidoneidade - Lei de Licitações|
|Suspensão - Legislação Municipal|
|Decisão judicial liminar/cautelar que impeça contratação|
