	
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
