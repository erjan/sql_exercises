Find the average accommodates-to-beds ratio for shared rooms in each city. Sort your results by listing cities with the highest ratios first.


select 


city, avg(cast(accommodates as float)/cast( beds as float)) as ratio
from airbnb_search_details where room_type = 'Shared room'

 group by city
