select * from cd.facilities

select name, membercost from cd.facilities


select * from cd.facilities 
where membercost != 0

select facid, name, membercost, monthlymaintenance from cd.facilities 
where membercost > 0 and membercost < monthlymaintenance/50


select * from cd.facilities where name like 'Tennis%' or name like '%Tennis'

select * from cd.facilities where facid in(1,5)

select 
name,
case when monthlymaintenance > 100 then 'expensive'
else 'cheap' end as cost
from cd.facilities


select memid,surname, firstname, joindate from cd.members where joindate::date >= '2012-09-01'

select distinct surname from  cd.members order by surname limit 10 

select distinct surname from cd.members union all
select name from cd.facilities

select max(joindate) from cd.members 

select firstname, surname, joindate from cd.members where joindate = (

select max(joindate) from cd.members )
