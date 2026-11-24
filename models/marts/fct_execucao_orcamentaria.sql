select
    orgao,
    elemento_despesa,
    date_trunc('month', dt_empenho)                   as mes,
    count(*)                                          as qtd_empenhos,
    sum(valor_empenhado)                              as valor_empenhado,
    sum(valor_pago)                                   as valor_pago,
    round(sum(valor_pago) / nullif(sum(valor_empenhado), 0), 4) as pct_execucao
from {{ ref('int_execucao_empenho') }}
group by 1, 2, 3
