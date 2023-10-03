You're given a dataset of searches for properties on Airbnb. For simplicity, let's say that each search result (i.e., each row) represents a unique host. Find the city with the most amenities across all their host's properties. Output the name of the city.


with h as(
select 

city,
unnest(string_to_array( btrim(amenities, '{}'), ',')) as a

from airbnb_search_details) 

select city, count(a) as x 
from h where a not ilike '%translation%' group by city
order by x desc limit 1

