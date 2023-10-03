In a marathon, gun time is counted from the moment of the formal start of the race while net time is counted from the moment a runner crosses a starting line. Both variables are in seconds.


You are asked to check if the interval between the two times is different for male and female runners. First, calculate the average absolute difference between the gun time and net time. Group the results by available genders (male and female). Output the absolute difference between those two values.


with h as(
select 

avg(abs(gun_time - net_time)) as d1
from marathon_male),

h2 as(
select 

avg(abs(gun_time - net_time)) as d2
from marathon_female)


select abs(d1-d2) from h cross join h2
