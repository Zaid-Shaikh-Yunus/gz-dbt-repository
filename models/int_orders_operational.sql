WITH shipping AS (
    SELECT
        orders_id,
        CAST(shipping_fee AS FLOAT64) AS shipping_fee,
        CAST(logCost AS FLOAT64) AS log_cost,
        CAST(ship_cost AS FLOAT64) AS ship_cost
    FROM {{ source('gz_raw_data', 'ship') }}
),

orders AS (
    SELECT *
    FROM {{ ref('int_orders_margin') }}
)

SELECT
    orders_id,
    date_date,
    margin + shipping_fee - log_cost - ship_cost AS operational_margin
FROM orders
LEFT JOIN shipping
USING (orders_id)