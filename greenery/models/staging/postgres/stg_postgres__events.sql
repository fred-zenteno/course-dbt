{{ 
  config(
    materialized='table'
  ) 
}}

with events as (select * from {{ source('postgres', 'events') }})

select
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at,
    order_id,
    product_id
from events
