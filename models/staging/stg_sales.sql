{{
    config(
        materialized='table',
        tags=['pipe_snow_AI']
    )
}}
SELECT
    sale_date,
    product_id,
    region,
    sales_amount
FROM DBT_LEARN.RAW.sales

