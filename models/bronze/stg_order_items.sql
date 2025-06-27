select
    order_id,
    product_id,
    quantity,
    updated_at
from
    {{source('demo_db', 'order_items')}}