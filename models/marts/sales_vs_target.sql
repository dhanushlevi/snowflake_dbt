
{{
    config(
        materialized='table',
        tags=['pipe_snow_AI']
    )
}}

WITH sales AS (
    SELECT
        product_id,
        region,
        SUM(sales_amount) AS total_sales
    FROM {{ ref('stg_sales') }}
    GROUP BY product_id, region
),
targets AS (
    SELECT
        product_id,
        region,
        target_amount
    FROM {{ ref('stg_targets') }}
)
SELECT
    s.product_id,
    s.region,
    s.total_sales,
    t.target_amount,
    s.total_sales - t.target_amount AS variance,
    CASE
        WHEN s.total_sales >= t.target_amount THEN 'ACHIEVED'
        ELSE 'NOT ACHIEVED'
    END AS target_status
FROM sales s
LEFT JOIN targets t
ON s.product_id = t.product_id
AND s.region = t.region
