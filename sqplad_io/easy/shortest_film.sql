Write a query to return the title of the film with the minimum duration.
A movie's duration can be found using the length column.
If there are ties, e.g., two movies have the same length, return either one of them.


select title from (
  
   select title, min(length) as min_length from film 
   group by film_id 
   order by min_length asc limit 1)OO

    
