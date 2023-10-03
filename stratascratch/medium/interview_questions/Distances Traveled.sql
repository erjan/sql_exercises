Find the top 10 users that have traveled the greatest distance. Output their id, name and a total distance traveled.




select user_id, name, traveled_distance from (

select
l2.id as user_id, l2.name as name, 
sum(distance) as traveled_distance,
rank()over(order by sum(distance) desc) as rank
from lyft_rides_log l1 left join lyft_users l2 on l1.user_id = l2.id

group by l2.id,l2.name
order by 3 )k
where rank<=10
