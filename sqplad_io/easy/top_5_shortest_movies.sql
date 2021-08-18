-- Write a query to return the titles of the 5 shortest movies by duration.
-- The order of your results doesn't matter.

SELECT title
FROM film
order by length asc
LIMIT 5;

    
