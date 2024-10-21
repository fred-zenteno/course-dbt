{{ 
  config(
    materialized='table'
  ) 
}}

with 
  products as (
    select 
      * 
    from 
      {{ ref('stg_postgres__products') }}
  ),

  product_page_views as (
    select 
      * 
    from 
      {{ ref('int_product_daily_page_views') }}
  )

select 
    pv.product_id,
    pv.page_url,
    pd.name as product_name,
    pv.view_date,
    pv.daily_page_views,
    pv.daily_page_viewers

from 
    product_page_views pv 
left join 
    products pd 
on 
    pv.product_id = pd.product_id