{{ config(
    materialized = 'incremental',
    unique_key = 'product_id',
    on_schema_change = 'sync_all_columns'
) }}

SELECT
    product_id,
    product_name,
    category,
    price,
    created_at,
    updated_at

FROM {{ ref('stg_products') }}

{% if is_incremental() %}
WHERE updated_at > (SELECT COALESCE(max(updated_at), '1900-01-01') FROM {{ this }})
{% endif %}
