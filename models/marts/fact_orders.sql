{{ config(materialized = 'table') }}

SELECT
    o.order_id,
    o.customer_id,
    o.order_date,
    oi.product_id,
    oi.quantity,
    oi.updated_at AS order_item_updated_at,
    c.region,
    p.category,
    p.price,
    (oi.quantity * p.price) AS total_amount 
FROM {{ ref('silver_cleaned_orders') }} o 
JOIN {{ ref('silver_cleaned_order_items') }} oi 
    ON o.order_id = oi.order_id
JOIN {{ ref('dim_customers') }} c 
    ON o.customer_id = c.customer_id
JOIN {{ ref('dim_products') }} p 
    ON oi.product_id = p.product_id