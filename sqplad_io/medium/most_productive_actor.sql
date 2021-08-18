Write a query to return the first name and the last name of the actor who appeared in the most films.


  
  select first_name, last_name from actor where actor_id in (
  select actor_id from (
  
    select actor_id, count(film_id) as c from actor inner join film_actor
	using (actor_id)
	group by actor_id
	order by c desc limit 1)k)

    
