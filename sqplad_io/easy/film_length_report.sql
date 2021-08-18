Write a query to return the number of films in the following categories: short, medium, and long.
The order of your results doesn't matter.



select film_category, sum( c) from (

select 
film_id,

case when  length< 60 then 'short'

when length >=60 and length <100 then 'medium'
when length >=100 then 'long'

end as film_category, 

count(distinct film_id) as c

from film

group by film_id)k

group by film_category

    
