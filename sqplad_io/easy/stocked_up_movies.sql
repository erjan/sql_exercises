Write a query to return the titles of movies with more than >7 dvd copies in the inventory.
The film titles are unique, i.e., no 2 films share the same titles.


select distinct title from 
inventory inner join film on 
inventory.film_id = film.film_id 
group by  title
having count(inventory.store_id) > 7

    
