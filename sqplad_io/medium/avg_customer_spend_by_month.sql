Write a query to return the average customer spend by month.
Definition: average customer spend: total customer spend divided by the unique number of customers for that month.
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.



SELECT 

EXTRACT(year from payment_ts) as year,
EXTRACT(month from payment_ts) as month,

sum(amount)/count(distinct customer_id) as avg_spend

FROM payment
group by year, month
order by year, month

    
