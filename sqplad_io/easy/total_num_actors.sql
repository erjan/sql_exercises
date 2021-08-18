Write a query to return the total number of actors from actor_tv, actor_movie with FULL OUTER JOIN.
Use COALESCE to return the first non-null value from a list.
Actors who appear in both tv and movie share the same value of actor_id in both actor_tv and actor_movie tables.


    select coalesce( count(*),0)  from actor_tv full outer join actor_movie using(actor_id)
