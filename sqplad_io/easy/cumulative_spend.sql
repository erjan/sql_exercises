/*
Write a query to return the cumulative daily spend for the following customers:
customer_id in (1, 2, 3).
Each day a user has a rental, return their total spent until that day.
If there is no rental on that day, you can skip that day.
*/

with h as (

select 

date(payment_ts) as date,
customer_id,
 
sum(amount) as daily_spend


from payment 
where customer_id in(1,2,3)

group by date(payment_ts), customer_id)

select date, customer_id, 
daily_spend,

sum(daily_spend) over(partition by customer_id order by date)as cumulative_spend

from h
