Find each taster's favorite wine variety.
Consider that favorite variety means the variety that has been tasted by most of the time.
Output the taster's name along with the wine variety.


select taster_name, variety from(
select 

taster_name,variety,
count(*)over(partition by taster_name ) as times_tasted,
dense_rank()over(partition by taster_name order by count(*) desc ) as rnk
from winemag_p2 where taster_name is not null

group by taster_name,variety
)k where rnk = 1
