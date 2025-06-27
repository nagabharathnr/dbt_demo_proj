select
    order_id,
    customer_id,
    order_date,
    updated_at
from
    {{source('demo_db', 'orders')}}