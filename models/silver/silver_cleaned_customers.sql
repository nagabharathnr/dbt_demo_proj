{{ config(
    materialized = 'incremental',
    unique_key = 'customer_id',
    on_schema_change = 'sync_all_columns'
) }}

SELECT
    customer_id,
    customer_name,
    email,
    region,
    created_at,
    updated_at

FROM {{ ref('stg_customers') }}

{% if is_incremental() %}
WHERE updated_at > (SELECT COALESCE(max(updated_at), '1900-01-01') FROM {{ this }})
{% endif %}
