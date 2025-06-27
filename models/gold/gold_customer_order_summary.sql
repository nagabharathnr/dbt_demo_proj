{{config(
    materialized = 'table'
)}}

WITH orders as (
    SELECT * from {{ ref('silver_cleaned_orders') }}
),

customers as (
    SELECT * FROM {{ ref('silver_cleaned_customers') }}
),

order_items as (
    SELECT * FROM {{ ref('silver_cleaned_order_items') }}
),

products as (
    SELECT * FROM {{ ref('silver_cleaned_products') }}
),

--to calculate total items cost, lets join order_items with products
order_items_enriched as (
    SELECT
        oi.order_id,
        oi.product_id,
        oi.quantity,
        p.price,
        oi.quantity * p.price as item_total
    FROM order_items oi 
    left join products p 
    on oi.product_id = p.product_id
),

--to aggregate on customer level
customer_order_summary as (
    SELECT
        c.customer_id,
        c.customer_name,
        c.email,
        c.region,
        count(distinct o.order_id) as total_orders,
        sum(oi.item_total) as total_amount_spent,
        sum(oi.quantity) as total_items_purchased,
        max(o.order_date) as last_order_date
    FROM customers c 
    left join orders o 
        on c.customer_id = o.customer_id
    left join order_items_enriched oi 
        on o.order_id = oi.order_id
    group by 
        c.customer_id, c.customer_name, c.email, c.region
    order by 1
)

select * from customer_order_summary