{{ 
  config(
    materialized='view'
  ) 
}}

with 
  order_items as (
    select 
      * 
    from 
      {{ ref('stg_postgres__order_items') }}
  ),

  orders as (
    select 
      * 
    from 
      {{ ref('stg_postgres__orders') }}
  )

select 
    ot.product_id,
    date(od.created_at) as order_date,
    count(distinct ot.order_id) as total_delivered_orders,
    sum(ot.quantity) as total_quantities_delivered

from 
    order_items ot
left join 
    orders od
on 
    ot.order_id = od.order_id

where 
    od.status = 'delivered'

group by 
    1, 2
