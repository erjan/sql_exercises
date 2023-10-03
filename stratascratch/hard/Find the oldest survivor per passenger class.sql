Find the oldest survivor of each passenger class.
Output the name and the age of the survivor along with the corresponding passenger class.
Order records by passenger class in ascending order.


with h as(
select 

name,age, rank()over(partition by pclass order by age desc) as rnk
from titanic
where survived = 1 and age is not null
group by pclass,name,age)


select  t.name, t.pclass,h.age from h join
titanic t on h.name = t.name

where h.rnk = 1
