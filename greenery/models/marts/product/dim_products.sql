{{ 
    config(
        materialized='table'
    )
}}

with products as (
    select * from {{ ref('stg_postgres__products') }}
)

select
    product_id,
    name as product_name,
    price as product_price
from products