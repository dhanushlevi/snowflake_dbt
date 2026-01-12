{{
    config(
        materialized='table',
        tags=['pipe_snow_AI']
    )
}}
SELECT
    product_id,
    region,
    target_amount
FROM DBT_LEARN.RAW.targets
