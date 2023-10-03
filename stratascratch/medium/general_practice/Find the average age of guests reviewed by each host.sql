Find the average age of guests reviewed by each host.
Output the user along with the average age.


select 
from_user,
avg(age)


from airbnb_reviews ar inner join airbnb_guests ag on ar.to_user = ag.guest_id

where from_type = 'host' and to_type = 'guest'

group by from_user


