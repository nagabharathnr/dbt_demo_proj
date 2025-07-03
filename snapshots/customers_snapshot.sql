{% snapshot customers_snapshot %}
{{
    config(
        target_schema = 'demo_schema',
        unique_key = 'customer_id',
        strategy = 'timestamp',
        updated_at = 'updated_at'
    )
}}

SELECT * FROM {{ ref('silver_cleaned_customers') }}

{% endsnapshot %}