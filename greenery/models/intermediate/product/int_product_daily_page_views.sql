{{ 
  config(
    materialized='view'
  ) 
}}

select 
    product_id,
    page_url,
    date(created_at) as view_date, 
    count(distinct event_id) as daily_page_views,
    count(distinct user_id) as daily_page_viewers

from 
    {{ ref('stg_postgres__events') }}
where 
    event_type = 'page_view'
group by 
    product_id, 
    page_url, 
    date(created_at)
