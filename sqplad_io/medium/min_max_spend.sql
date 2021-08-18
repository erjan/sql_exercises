Write a query to return the minimum and maximum customer total spend in June 2020.
For each customer, first calculate their total spend in June 2020.
Then use MIN, and MAX function to return the min and max customer spend .



select min(s), max(s) from (

select customer_id, sum(amount) as s from payment


where EXTRACT(year from payment_ts) = 2020 and EXTRACT(month from payment_ts) = 6

group by customer_id    )k

    
