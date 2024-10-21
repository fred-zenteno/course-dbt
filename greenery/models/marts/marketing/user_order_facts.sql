{{ 
  config(
    materialized='table'
  ) 
}}

with 
  users as (
    select 
      * 
    from 
      {{ ref('stg_postgres__users') }}
  ),

  orders as (
    select 
      * 
    from 
      {{ ref('stg_postgres__orders') }}
  )

select 
    u.user_id, 
    concat(u.first_name, ' ', u.last_name) as user_full_name,
    u.email as user_email,
    min(o.created_at) as first_order_date, 
    max(o.created_at) as last_order_date, 
    count(distinct o.order_id) as total_orders, 
    max(o.order_total) as max_order_value, 
    min(o.order_total) as min_order_value, 
    sum(o.order_total) as total_spend

from 
    users u
left join 
    orders o 
on 
    u.user_id = o.user_id
group by 
    1, 2, 3
