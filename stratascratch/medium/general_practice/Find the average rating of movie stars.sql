Find the average rating of each movie star along with their names and birthdays. Sort the result in the ascending order based on the birthday. Use the names as keys when joining the tables.


select 


n1.name, birthday,
avg(rating)

from nominee_filmography n1 inner join nominee_information n2 on n1.name = n2.name
group by n1.name, birthday
