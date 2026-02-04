SELECT
    s.products_id,
    s.orders_id,
    s.date_date,
    s.quantity,
    s.revenue,
    p.purchase_price,
    s.quantity * p.purchase_price AS purchase_cost,
    s.revenue - (s.quantity * p.purchase_price) AS margin
FROM {{ ref('stg_gz_raw_data__sales') }} s
LEFT JOIN {{ ref('stg_gz_raw_data__product') }} p
USING (products_id)