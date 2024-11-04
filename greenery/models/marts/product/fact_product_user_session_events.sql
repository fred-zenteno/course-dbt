{{ 
    config(
        materialized='table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres__events') }}
),
order_items as (
    select * from {{ ref('stg_postgres__order_items') }}
)

select 
    coalesce(e.product_id, o.product_id) as product_id, 
    user_id,
    session_id, 
    DATE(created_at) as event_created_date,
    {{ count_event_types('e', 'event_type') }}
from 
    events e 
left join 
    order_items o ON e.order_id = o.order_id
group by 1, 2, 3, 4
