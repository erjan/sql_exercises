Write a query to return the total number of unique customers for each month
Use EXTRACT(YEAR from ts_field) and EXTRACT(MONTH from ts_field) to get year and month from a timestamp column.
The order of your results doesn't matter.


select 

EXTRACT(YEAR FROM rental_ts) as year,
EXTRACT(month FROM rental_ts) as mon,
count(distinct customer_id)
from rental
group by year, mon;

    
