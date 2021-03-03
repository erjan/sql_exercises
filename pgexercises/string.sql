select concat( surname , ', ', firstname) from cd.members

select * from cd.facilities where name like 'Tennis%'


select * from cd.facilities where lower(name) like 'tennis%'

select memid, telephone from cd.members where telephone similar to '\(___\)%'


select lpad( cast(zipcode as text), 5, '0') as zip from cd.members 


select substr(surname, 0,2) as letter, count(substr(surname, 0,2)) as count from cd.members
group by substr(surname, 0,2)
order by letter


select memid, 
translate(telephone , '-() ', '') as telephone
from cd.members 
order by memid





