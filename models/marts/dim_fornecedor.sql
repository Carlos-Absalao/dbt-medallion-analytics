select
    fornecedor,
    count(*)                 as qtd_empenhos,
    sum(valor_empenhado)     as valor_empenhado,
    sum(saldo_a_pagar)       as saldo_a_pagar,
    rank() over (order by sum(valor_empenhado) desc) as ranking_valor
from {{ ref('int_execucao_empenho') }}
group by fornecedor
