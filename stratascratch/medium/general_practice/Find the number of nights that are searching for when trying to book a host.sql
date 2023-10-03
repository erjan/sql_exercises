Find the number of nights that are searched by most people when trying to book a host.
Output the number of nights alongside the total searches.
Order records based on the total searches in descending order.


select 


(n_nights) as night,
sum(n_searches) as total_search
from airbnb_searches
group by n_nights
order by total_search desc
