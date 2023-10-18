

'''
Given the tables users and rides, write a query to report the distance traveled by each user in descending order.
'''


select distance_traveled,name from (

select 

u.id,u.name, sum(ifnull(distance,0)) as distance_traveled
 from users u left join rides r on u.id = r.passenger_user_id

group by u.id,u.name)k

order by distance_traveled desc

