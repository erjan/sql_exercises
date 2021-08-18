Write a query to return the titles of the films that were rented by our customers in August 2020 but have not been returned.
Hint
Use rental_ts from the rental table to identify when a film is rented.
If a movie is not returned, the return_ts will be NULL in the rental table.

 
 select distinct title from inventory 
 inner join film on film.film_id = inventory.film_id inner join rental 
 on rental.inventory_id = inventory.inventory_id
 where return_ts is null

    
