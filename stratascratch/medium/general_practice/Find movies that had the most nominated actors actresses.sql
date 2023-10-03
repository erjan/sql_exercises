Find movies that had the most nominated actors/actresses. Be aware of the fact that some movies have the same name. Use the year column to separate count for such movies.
Output the movie name alongside the number of nominees.
Order the result in descending order.


select movie, x from (
select 

year,movie,
count(nominee) as x
from oscar_nominees

group by movie, year

order by x desc)k
