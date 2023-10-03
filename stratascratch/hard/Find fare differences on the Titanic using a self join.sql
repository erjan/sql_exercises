Find the average absolute fare difference between a specific passenger and all passengers that belong to the same pclass,  both are non-survivors and age difference between two of them is 5 or less years. Do that for each passenger (that satisfy above mentioned coniditions). Output the result along with the passenger name.



select 


t1.name ,
avg(abs(t1.fare - t2.fare)) as avg_fare

from 
titanic t1,
titanic t2 
where t1.passengerid <> t2.passengerid and
t1.survived = 0 and t2.survived = 0
and abs(t1.age - t2.age) <=5 
and t1.pclass = t2.pclass

group by t1.name
