# 🏅 dbt Medallion Analytics — Execução Orçamentária

Projeto **dbt** que modela dados de execução orçamentária (empenhos e pagamentos) em **camadas** — raw → processed → trusted → gold — com **testes de qualidade** e documentação gerada automaticamente.
Roda localmente com **DuckDB** (zero infraestrutura) e o mesmo código vai para **BigQuery** trocando o target.

![dbt](https://img.shields.io/badge/dbt-1.8+-FF694B?logo=dbt&logoColor=white)
![DuckDB](https://img.shields.io/badge/DuckDB-local-FFF000?logo=duckdb&logoColor=black)
![BigQuery](https://img.shields.io/badge/BigQuery-produção-669DF6?logo=googlebigquery&logoColor=white)

## Linhagem

```mermaid
flowchart LR
    s1[raw_empenhos] --> stg1[stg_empenhos]
    s2[raw_pagamentos] --> stg2[stg_pagamentos]
    stg1 --> int[int_execucao_empenho]
    stg2 --> int
    int --> f[fct_execucao_orcamentaria]
    int --> d[dim_fornecedor]
```

| Camada | Pasta | Materialização | Papel |
|---|---|---|---|
| raw | `seeds/` | seed | Dados de origem (sintéticos) |
| processed | `models/staging` | view | Tipagem e padronização |
| trusted | `models/intermediate` | view | Regras de negócio (remove anulados, calcula saldo) |
| gold | `models/marts` | table | Fatos e dimensões para BI |

## Como executar

```bash
pip install -r requirements.txt
export DBT_PROFILES_DIR=.
dbt build              # seeds + modelos + 18 testes
dbt docs generate && dbt docs serve   # documentação e linhagem no navegador
```

Para BigQuery: `pip install dbt-bigquery`, defina `GCP_PROJECT` e rode `dbt build --target bigquery`.

## Testes de qualidade

- `unique` / `not_null` nas chaves
- `accepted_values` para situação do empenho
- `relationships` (todo pagamento aponta para um empenho existente)
- Teste singular: **valor pago nunca excede o valor empenhado**

---
Autor: [Carlos Absalão](https://www.linkedin.com/in/carlos-absalao-dados-ia) · Licença MIT
