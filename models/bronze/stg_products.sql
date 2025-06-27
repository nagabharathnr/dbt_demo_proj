select
    product_id,
    product_name,
    category,
    price,
    created_at,
    updated_at
from
    {{source('demo_db', 'products')}}