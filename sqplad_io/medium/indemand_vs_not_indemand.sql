	
  /*
  
  Write a query to return the number of in demand and not in demand movies in May 2020.
Assumptions (great to clarify in your interview): all films are available for rent before May.
But if a film is not in stock, it is not in demand.
The order of your results doesn't matter.
Definition
in-demand: rented >1 times in May 2020.
not-in-demand: rented <= 1 time in May 2020.
*/
  
  
select demand_category, count(*) from (	

select f.film_id,
  
  case when count(t.rental_id) > 1 then 'in demand' else 'not in demand' end as demand_category
  
  from film f left join inventory i on f.film_id = i.film_id  left join 
  
(select inventory_id, rental_id from rental r where date(r.rental_ts) >= '2020-05-01' 
and date(r.rental_ts) <= '2020-05-31')t on t.inventory_id = i.inventory_id
  group by f.film_id
)o

group by demand_category

--official

SELECT demand_category, COUNT(*)
FROM (
	SELECT 
		F.film_id, 
		CASE WHEN COUNT(R.rental_id) >1 THEN 'in demand' ELSE 'not in demand' END AS demand_category
	FROM film F
	LEFT JOIN INVENTORY I
	ON F.film_id =I.film_id
	LEFT JOIN (
	    SELECT inventory_id, rental_id
		FROM rental 
		WHERE DATE(rental_ts) >= '2020-05-01'
		AND DATE(rental_ts) <= '2020-05-31'
	) R
	ON R.inventory_id = I.inventory_id
	GROUP BY F.film_id
)X
GROUP BY demand_category;
