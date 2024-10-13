{{ 
  config(
    materialized='table'
  ) 
}}

with users as (select * from {{ source('postgres', 'users') }})

select
    user_id,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id
from users