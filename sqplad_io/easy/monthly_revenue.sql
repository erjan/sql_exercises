Write a query to return the total movie rental revenue for each month.
You can use EXTRACT(MONTH FROM colname) and EXTRACT(YEAR FROM colname) to extract month and year from a timestamp column.


SELECT 
EXTRACT(YEAR FROM payment_ts) as year,

EXTRACT(MONTH FROM payment_ts) as mon,

sum(amount) as rev

FROM payment group by mon, year

    
