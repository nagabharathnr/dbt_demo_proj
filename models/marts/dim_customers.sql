{{ config(materialized = 'table') }}

SELECT
    customer_id,
    customer_name,
    email,
    region
FROM {{ ref('silver_cleaned_customers') }}