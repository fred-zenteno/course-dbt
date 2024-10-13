{{ 
  config(
    materialized='table'
  ) 
}}

with promos as (select * from {{ source('postgres', 'promos') }})

select
    promo_id,
    discount,
    status
from promos
