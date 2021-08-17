/*
For each movie category: return the customer id who spend the most in rentals.
If there are ties, return any customer id.
*/



    WITH cust_revenue_by_cat AS (
    SELECT 
        P.customer_id,
	FC.category_id,
	SUM(P.amount) AS revenue
    FROM payment P
    INNER JOIN rental R
    ON R.rental_id = P.rental_id
    INNER JOIN inventory I
    ON I.inventory_id = R.inventory_id
    INNER JOIN film F
    ON F.film_id = I.film_id
    INNER JOIN film_category FC
    ON FC.film_id = F.film_id
    GROUP BY P.customer_id, FC.category_id
)



select category_id, customer_id  from (

select category_id, customer_id, 
row_number() over(partition by category_id order by revenue desc) as row_num
from cust_revenue_by_cat)k

where k.row_num = 1
