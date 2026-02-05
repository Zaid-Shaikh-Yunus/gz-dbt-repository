with adwords as (
    select *
    from {{ ref('stg_gz_raw_data__adwords') }}
),
bing as (
    select *
    from {{ ref('stg_gz_raw_data__bing') }}
),
criteo as (
    select *
    from {{ ref('stg_gz_raw_data__criteo') }}
),
facebook as (
    select *
    from {{ ref('stg_gz_raw_data__facebook') }}
)

select * from adwords
union all
select * from bing
union all
select * from criteo
union all
select * from facebook