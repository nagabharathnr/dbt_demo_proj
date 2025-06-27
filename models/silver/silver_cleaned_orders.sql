{{ config(
    materialized = 'incremental',
    unique_key = 'order_id',
    on_schema_change = 'sync_all_columns'
) }}

SELECT
    order_id,
    customer_id,
    order_date,
    updated_at
FROM {{ ref('stg_orders') }}

{% if is_incremental() %}
  WHERE updated_at > (SELECT COALESCE(max(updated_at), '1900-01-01') FROM {{ this }})
{% endif %}
