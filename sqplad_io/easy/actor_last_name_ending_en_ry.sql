Identify all actors whose last name ends in 'EN' or 'RY'.
Group and count them by their last name.




SELECT last_name, count(actor_id)
FROM actor
where last_name LIKE ('%EN') or last_name like ('%RY')
group by last_name

    
