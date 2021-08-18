Write a query to return the name of the 3 movie categories that generated the most rental revenue
And rental revenue from each of the category.
The order of your results doesn't matter.
If there are ties, return just one of them.




select category.name, sum(amount) as s 

from category 
inner join film_category on category.category_id = film_category.category_id
inner join inventory on inventory.film_id = film_category.film_id
inner join rental on rental.inventory_id = inventory.inventory_id
inner join payment on rental.customer_id = payment.customer_id 
and rental.rental_id = payment.rental_id
group by category.name
order by s desc limit 3

    --official
    
    SELECT C.name, SUM(P.amount)
FROM 
    payment P
INNER JOIN rental R 
ON R.rental_id = P.rental_id
INNER JOIN inventory I
ON I.inventory_id = R.inventory_id
INNER JOIN film F
ON F.film_id = I.film_id
INNER JOIN film_category FC
ON FC.film_id = F.film_id
INNER JOIN category C
ON C.category_id = FC.category_id
GROUP BY C.name 
ORDER BY SUM(P.amount) DESC
LIMIT 3
;
