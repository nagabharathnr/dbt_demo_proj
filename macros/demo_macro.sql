{% macro calculate_total_sales(table_name) %}
    select * from {{ source('demo_db', table_name) }}
{% endmacro %}