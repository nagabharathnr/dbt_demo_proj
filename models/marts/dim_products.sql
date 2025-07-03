{{ config(materialized = 'table') }}

SELECT
    product_id,
    product_name,
    category,
    price
FROM {{ ref('silver_cleaned_products') }}