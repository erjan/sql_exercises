Calculate the average lifetime rating and rating from the movie with second biggest id across all actors and all films they had acted in. Remove null ratings from the calculation.
Role type is "Normal Acting". Output a list of actors, their average lifetime rating, rating from the film with the second biggest id (use id column), and the absolute difference between the two ratings.


with h as(
select 
name,rating as secondlast,
row_number()over(partition by name order by id desc)as rnk
from nominee_filmography
where role_type = 'Normal Acting' and rating is not null

group by name,id, rating),

h2 as(

select 
name,avg(rating) as lifetime_rating
from nominee_filmography
where role_type = 'Normal Acting'
group by name)


select h.name, h.secondlast, lifetime_rating,
abs(secondlast - lifetime_rating) as variance
from h join h2 on h.name = h2.name where h.rnk = 2
