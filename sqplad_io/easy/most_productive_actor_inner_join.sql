Write a query to return the name of the actor who appears in the most films.
You have to use INNER JOIN in your query.




select actor.actor_id  , first_name, last_name -- , count(film_actor.film_id) as total
  from actor inner join film_actor on actor.actor_id = film_actor.actor_id
 group by actor.actor_id  , first_name, last_name
 order by count(film_actor.film_id) desc limit 1
