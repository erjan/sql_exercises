/*

Write a query to return the number of films in 
3 separate groups: high, medium, low.
The order of your results doesn't matter.
Definition
high: revenue >= $100.
medium: revenue >= $20, <$100 .
low: revenue <$20.
*/


with help as (	

select f.film_id , sum(amount) as rev

from film f 
left join inventory i on f.film_id = i.film_id
left join rental r on r.inventory_id = i.inventory_id
left join payment p on p.rental_id = r.rental_id


group by f.film_id),


helper2 as (

select film_id,
case when rev >= 100 then 'high' 
            when rev >=20 and rev < 100 then 'medium'
			else 'low' end  as film_group
			
from help)


select  film_group, count(*) from helper2
group by film_group



-- official solution

SELECT film_group, COUNT(*) 
FROM (
	SELECT 
		F.film_id, 
	    CASE WHEN SUM(P.amount) >= 100 THEN 'high'
	         WHEN SUM(P.amount) >= 20 THEN 'medium'
	         ELSE 'low' END film_group
	FROM film F
	LEFT JOIN inventory I
	ON I.film_id = F.film_id
	LEFT JOIN rental R 
	ON R.inventory_id = I.inventory_id
	LEFT JOIN payment P
	ON P.rental_id = R.rental_id
	GROUP BY F.film_id
) X
GROUP BY film_group
;
