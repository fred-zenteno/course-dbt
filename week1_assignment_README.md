# Assignment

## Question 1: How many users do we have? 
**Answer**: 130

**SQL Script**:
```sql
select
    count(distinct user_id) as num_of_users
from DEV_DB.DBT_FREDDIEZENTENOOUTLOOKCOM.STG_POSTGRES__USERS;
```

---

## Question 2: On average, how many orders do we receive per hour? 
**Answer**: 7.5

**SQL Script**:
```sql
with orders_per_hour as (
    select
        date_trunc(hour, created_at) as hour,
        count(distinct order_id) as num_of_orders
    from DEV_DB.DBT_FREDDIEZENTENOOUTLOOKCOM.STG_POSTGRES__ORDERS
    group by 1
)
select
    avg(num_of_orders) as avg_orders_per_hour
from orders_per_hour;
```

---

## Question 3: On average, how long does an order take from being placed to being delivered? 
**Answer**: 3.89 days

**SQL Script**:
```sql
with calculate_days as (
    select 
        order_id,
        datediff('day', created_at, delivered_at) as delivery_time_days
    from DEV_DB.DBT_FREDDIEZENTENOOUTLOOKCOM.STG_POSTGRES__ORDERS
    where status = 'delivered' and delivered_at is not null 
)
select avg(delivery_time_days) as avg_num_day_for_delivery
from calculate_days;
```

---

## Question 4: How many users have only made one purchase? Two purchases? Three+ purchases? 
**Answer**: 25, 28, and 71, respectively.

**SQL Script**:
```sql
with purchases_by_user as (
    select 
        user_id,
        count(distinct order_id) as num_of_purchases
    from DEV_DB.DBT_FREDDIEZENTENOOUTLOOKCOM.STG_POSTGRES__ORDERS
    group by 1
)
select 
    case 
        when num_of_purchases >= 3 then '3. three+ purchases'
        when num_of_purchases > 1 then '2. two purchases'
        when num_of_purchases = 1 then '1. one purchase'
    end as purchases, 
    count(distinct user_id) as num_of_users
from purchases_by_user
group by 1
order by 1;
```

---

## Question 5: On average, how many unique sessions do we have per hour? 
**Answer**: 16.3

**SQL Script**:
```sql
with hourly_sessions as (
    select
        date_trunc('hour', created_at) as hour_of_day,
        count(distinct session_id) as unique_sessions
    from DEV_DB.DBT_FREDDIEZENTENOOUTLOOKCOM.STG_POSTGRES__EVENTS
    group by 1
)
select 
    avg(unique_sessions) as avg_unique_sessions_per_hour
from hourly_sessions;
```
