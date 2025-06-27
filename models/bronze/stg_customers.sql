{{ config(
    pre_hook="INSERT INTO demo_schema.audit_table (model_name, run_timestamp, row_count, status) VALUES ('my_model', CURRENT_TIMESTAMP, NULL, 'started')",
    post_hook="INSERT INTO demo_schema.audit_table (model_name, run_timestamp, row_count, status) VALUES ('my_model', CURRENT_TIMESTAMP, (SELECT COUNT(*) FROM {{ this }}), 'completed')"
) }}

select
    customer_id,
    customer_name,
    email,
    region,
    created_at,
    updated_at
from
    {{source('demo_db', 'customers')}}