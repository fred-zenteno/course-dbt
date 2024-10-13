{{ 
  config(
    materialized='table'
  ) 
}}

with products as (select * from {{ source('postgres', 'products') }})

select
    product_id,
    name,
    price,
    inventory
from products
