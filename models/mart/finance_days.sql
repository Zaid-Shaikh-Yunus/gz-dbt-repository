WITH base AS (
    SELECT
        o.date_date,
        o.orders_id,
        m.revenue,
        m.quantity,
        m.purchase_cost,
        m.margin AS operational_margin,
        s.shipping_fee,
        s.log_cost,
        s.ship_cost
    FROM {{ ref('int_orders_operational') }} o
    LEFT JOIN {{ ref('int_orders_margin') }} m
        USING (orders_id, date_date)
    LEFT JOIN {{ ref('stg_gz_raw_data__ship') }} s
        USING (orders_id)
)

SELECT
    date_date,
    COUNT(DISTINCT orders_id) AS total_transactions,
    SUM(revenue) AS total_revenue,
    SUM(revenue)/NULLIF(COUNT(DISTINCT orders_id),0) AS average_basket,
    SUM(operational_margin) AS total_operational_margin,
    SUM(purchase_cost) AS total_purchase_cost,
    SUM(shipping_fee) AS total_shipping_fees,
    SUM(log_cost) AS total_log_costs,
    SUM(ship_cost) AS total_ship_costs,
    SUM(quantity) AS total_quantity_sold
FROM base
GROUP BY date_date
ORDER BY date_date