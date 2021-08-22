/*

Write a query to return the number of happy customers from May 24 (inclusive) to May 31 (inclusive).
Definition
Happy customer: customers who made at least 1 rental in each day of any 2 consecutive days.
Hint
For customer 1, you can create the following temporary table:
customer 1, first rental date, second rental date
customer 1, second rental date, third rental date
..............
customer 1, second last rental date, last rental date
customer 1, last rental date, NULL
As long as there is at least one row, where the delta of the last 2 columns are not null, and less or equal than 1 day, this customer must be a happy customer.



я не понял как считать правильно и хотел разбить на пары  вторая_дата - первая_дата, третья_дата - вторая_дата  и проч. а надо было просто по другому! считать!

я считал и получал 245 а надо 159
*/

--official solution

WITH customer_rental_date AS (
	SELECT
            customer_id,
            DATE(rental_ts) AS rental_date
	FROM rental
	WHERE DATE(rental_ts) >= '2020-05-24'
	AND DATE(rental_ts) <= '2020-05-31'
	GROUP BY 
            customer_id, 
            DATE(rental_ts)
),

customer_rental_date_diff AS (
    SELECT 
        customer_id,
        rental_date AS current_rental_date,
        LAG( rental_date, 1) OVER(PARTITION BY customer_id ORDER BY rental_date) AS prev_rental_date
    FROM customer_rental_date
)

SELECT COUNT(*) FROM (
	SELECT 
		customer_id, 
		MIN(current_rental_date - prev_rental_date) 	
	FROM customer_rental_date_diff
	GROUP BY customer_id
	HAVING MIN(current_rental_date - prev_rental_date) = 1
) X
;
