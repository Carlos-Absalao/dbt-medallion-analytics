select
    cast(id_pagamento as integer)     as id_pagamento,
    cast(id_empenho as integer)       as id_empenho,
    cast(valor_pago as decimal(16, 2)) as valor_pago,
    cast(dt_pagamento as date)        as dt_pagamento
from {{ ref('raw_pagamentos') }}
