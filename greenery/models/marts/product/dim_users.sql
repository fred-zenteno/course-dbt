{{ 
    config(
        materialized='table'
    )
}}

with users as (
    select * from {{ ref('stg_postgres__users') }}
)

select 
    user_id,
    first_name || ' ' || last_name as user_full_name,
    email as user_email,
    phone_number as user_phone_number

from users