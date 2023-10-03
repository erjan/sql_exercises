Find the average number of beds in each neighborhood that has at least 3 beds in total.


Output results along with the neighborhood name and sort the results based on the number of average beds in descending order.


select 


avg(beds), neighbourhood
from airbnb_search_details



group by neighbourhood
having sum(beds)>=3
