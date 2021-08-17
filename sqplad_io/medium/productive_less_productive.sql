
/*
Write a query to return the number of productive and less-productive actors.
The order of your results doesn't matter.
Definition
productive: appeared in >= 30 films.
less-productive: appeared in <30 films.
*/
	
  
-- my own solution  
with h1 as (	
	
select 

actor.actor_id, 
count(distinct film_actor.film_id) 

from actor left join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
having count(distinct film_actor.film_id)>=30),

h2 as (select 

actor.actor_id, 
count(distinct film_actor.film_id) 

from actor left join film_actor on actor.actor_id = film_actor.actor_id
group by actor.actor_id
having count(distinct film_actor.film_id)<30)


select 'less productive' as actor_category , count(actor_id) from h2
union
select 'productive' as actor_category , count(actor_id) from h1



--official solution

SELECT actor_category,
    COUNT(*)
FROM (        
	SELECT 
	    A.actor_id,
	    CASE WHEN  COUNT(DISTINCT FA.film_id) >= 30 THEN 'productive' ELSE 'less productive' END AS actor_category	     
	FROM actor A
	LEFT JOIN film_actor FA
	ON FA.actor_id = A.actor_id
	GROUP BY A.actor_id
) X
GROUP BY actor_category;
