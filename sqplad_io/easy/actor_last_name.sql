-- Find the number of actors whose last name is one of the following: 'DAVIS', 'BRODY', 'ALLEN', 'BERRY'



SELECT  last_name, count(actor_id)

FROM actor where last_name in ('DAVIS', 'BRODY', 'ALLEN', 'BERRY')
group by last_name
order by last_name
