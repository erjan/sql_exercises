Write a query to count the number of customers who spend more than (>) $20 by month
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.
Hint: a customer's spend varies every month.


select year, mon , count(distinct customer_id) from (

select
  EXTRACT( year from payment_ts)as year,
  EXTRACT( month from payment_ts) as mon,
  customer_id ,
  sum(amount) as amt
  FROM payment

group by year, mon, customer_id  --limit 3

 ) x where amt > 20 group by year, mon

    
