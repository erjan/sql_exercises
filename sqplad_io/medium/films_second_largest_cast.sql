Write a query to return the title of the film with the second largest cast.
If there are ties, e.g., two movies have the same number of actors, return either one of the movie.


  select  title from film_actor inner join film on film_actor.film_id = film.film_id
  group by  title
  order by count(actor_id) desc limit 1 offset 1
  -- )k

    
