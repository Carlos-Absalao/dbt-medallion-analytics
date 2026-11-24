select
    cast(id_empenho as integer)       as id_empenho,
    upper(trim(orgao))                as orgao,
    upper(trim(fornecedor))           as fornecedor,
    upper(trim(elemento_despesa))     as elemento_despesa,
    cast(valor as decimal(16, 2))     as valor_empenhado,
    cast(dt_empenho as date)          as dt_empenho,
    upper(situacao)                   as situacao
from {{ ref('raw_empenhos') }}
