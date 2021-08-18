Write a query to return the top search term on new year's day: 2021-01-01



select query as top_search_query 
from search 
where date = '2021-01-01'
group by query
order by count(query) desc limit 1

    
