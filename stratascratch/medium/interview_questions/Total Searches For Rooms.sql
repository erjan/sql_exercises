Find the total number of searches for each room type (apartments, private, shared) by city.




with h as(
select 

room_type,city,
count(*) as total_searches
from airbnb_search_details

group by room_type, city)


select city, 
sum(case when  room_type = 'Entire home/apt' then total_searches else 0 end) as apt_count,
sum(case when  room_type = 'Private room' then total_searches else 0 end) as private_count,
sum(case when  room_type = 'Shared room' then total_searches else 0 end) as shared_count

from h
group by city
