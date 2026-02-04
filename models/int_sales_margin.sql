SELECT *
FROM {{ ref('stg_gz_raw_data__sales') }}
LEFT JOIN {{ ref('stg_gz_raw_data__product') }}
USING (products_id);