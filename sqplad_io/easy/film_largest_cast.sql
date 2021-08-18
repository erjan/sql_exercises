Write a query to return the title of the film with the largest cast (most actors).
If there are ties, return just one of them


  select title from (
  
  select title, count(actor_id) as c FROM film_actor inner join film on film.film_id = film_actor.film_id
  group by title order by c desc limit 1)k

    
