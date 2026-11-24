-- Falha se algum empenho tiver pagamento maior que o valor empenhado
select *
from {{ ref('int_execucao_empenho') }}
where valor_pago > valor_empenhado
