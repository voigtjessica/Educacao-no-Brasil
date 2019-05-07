# SIGPC - Sistema de Gestão de Prestação de Contas

**Descrição:**

A versão pública do SIGPC permite que cidadãos acompanhem as transferências do FNDE para entidades públicas e privadas, assim como as prestações de contas daqueles que receberam esses recursos.


**O que é possível ver no sistema**

1. Se município realizou as prestações de contas;
2. Ordens bancárias (data e valor) de transferência de recursos para municípios;
3. Efeitos Suspensivos da Entidade Executora (se houver)
4. Objeto da transferência (no caso, você já faz o filtro prévio por programa antes de chegar às planilhas do detalhamento de contas);
5. Descobrir a conta corrente da Entidade Executora;
6. Contrapartidas (quando há)
7. Dados da prestação de contas
8. Pagamentos (Pagamentos >> Pagamentos >> Clicar em "Localizar"): São as notas fiscais emitidas pelos prestadores de serviço contratados pelas entidades executoras. 
9. Outro lugar para ver os pagamentos podendo exportar uma planilha excel (Visualizar Prestação de Contas >> Tipo: "Demonstrativo de receita e despesa" ). Ao exportar o PDF, ele já exporta todas as páginas. 

**Problemas**: 

1. A única forma de obter os demonstrativos de receita e despesa de todos os municípios é acessando manualmente. O sistema usa java, o que dificulta a raspagem;
2. Quando os demonstrativos são exportados, não consta o nome social completo do prestador de serviço;
3. Não consta o CNPJ do prestador de serviço;
4. Nao consta o objeto para o qual o serviço foi prestado;
5. Não se pode raspar os dados do SIGPC porque está em JAVA (ao menos que exista uma solução em Python);

