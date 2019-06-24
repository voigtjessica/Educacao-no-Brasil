# Editais de licitação e contratos de merenda escolar - estado do Rio de Janeiro

Recebemos um arquivo .xlsx ("contratos_editais_tcrj") contendo 6 abas. Cada aba se transformou em um arquivo Rdata. Como não havia dispensas de editais nem editais de licitação do Estado do RJ para merenda escolar, não criamos esses arquivos, permanecendo, na esfera estadual, apenas os contratos de merenda. Na esfera municipal, temos arquivos de editais, contratos e dispensas.

### Codebook

#### mun_editais.Rdata

| Variável | Descrição|
|:--:|:--|
|NM_UNIDADE| Nome da prefeitura |
|CD_UNIDADE| Código do município |
|DE_MODALIDADE| Modalidade da licitação. Assume os valores "Pregão presencial", "Pregão eletrônico", "Convite", "RDC - Regime Diferenciado de Contratação"|
|NU_EDITAL| Número do edital |
|DE_OBJETO| Objeto do edital |
|NM_PARTICIPANTE| Nome da empresa participante |
|CD_CICPARTICIPANTE| CNPJ Participante |
|DE_ITEMLICITACAO| Descrição do item da licitação |
|QT_ITEMLICITADO| Quantidade de item licitado |
|NM_UNIMED| Unidade de medida |
|VL_UNITARIO| Valor unitário |
|VL_ESTIMADO| Valor estimado para todo o edital |
|CD_VENCEDORPERDEDOR| Códigos** Ainda não está claro o que é, encaminhei um e-mail para o TC |

#### mun_contratos.Rdata e est_contratos.Rdata

| Variável | Descrição|
|:--:|:--|
|DT_ANO| Ano de contratação|
|NM_MUNICIPIO| Nome do município* Não consta na planilha dos contratos estaduais |
|CD_UNIDADE| Código da unidade que contratou realizou a licitação |
|NM_UNIDADE| Nome da unidade que realizou a licitação (pode ser o próprio município) |
|NU_PROCESSOLICITATORIO| Número do processo licitatório |
|NU_CONTRATO| Número do contrato |
|VL_CONTRATO| Valor do contrato |
|CD_CICCONTRATADO| CNPJ da empresa contratada ?? |
|DT_ASSINATURACONTRATO| Data de assinatura do contrato |
|DT_VENCIMENTOCONTRATO| Data de vencimento do contrato |
|CD_FONTERECURSO| ?? |
|CD_FUNCAO| ?? |
|CD_PROGRAMA| ?? |
|NU_PROJETOATIVIDADE| ?? |
|DE_OBJETIVO| Objetivo do contrato |

### mun_dispensas

| Variável | Descrição|
|:--:|:--|
|DT_ANO| Ano da dispensa |
|CD_UNIDADE| Código da unidade que está contratando |
|NM_MUNICIPIO| Nome do município |
|NM_UNIDADE| Nome da unidade que está realizando a contratação |
|DE_LICITACAO| Tipo de dispensa|
|CD_FUNDAMENTO| Fundamento da dispensa. Assume valores de incisos - pesquisar melhor o que cada um significa |
|NU_PROCESSODISPENSA| Número do processo de dispensa da licitação |
|VL_TOTALPREVISTO| Valor do total previsto no contrato |
|NM_FORNECEDOR| Nome do fornecedor |
|DE_OBJETO| Objeto da contratação |
