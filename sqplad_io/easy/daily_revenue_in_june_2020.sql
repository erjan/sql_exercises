Write a query to return daily revenue in June, 2020.
Use DATE(colname) to extract the date from a timestamp column.
payment_ts's data type is timestamp, convert it to date before grouping.
No dates need to be included if there was no revenue on that day.


SELECT 
DATE(payment_ts) as dt ,
sum(amount)

FROM payment where 
EXTRACT( year from DATE(payment_ts)) = 2020 and

EXTRACT( month from DATE(payment_ts)) = 6

group by EXTRACT( day from DATE(payment_ts)), dt

    
