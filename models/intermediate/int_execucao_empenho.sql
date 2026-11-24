-- Um registro por empenho válido, com o total pago até hoje
with pagos as (
    select id_empenho, sum(valor_pago) as valor_pago, max(dt_pagamento) as ultimo_pagamento
    from {{ ref('stg_pagamentos') }}
    group by id_empenho
)
select
    e.*,
    coalesce(p.valor_pago, 0)                       as valor_pago,
    e.valor_empenhado - coalesce(p.valor_pago, 0)   as saldo_a_pagar,
    p.ultimo_pagamento
from {{ ref('stg_empenhos') }} e
left join pagos p using (id_empenho)
where e.situacao <> 'ANULADO'
