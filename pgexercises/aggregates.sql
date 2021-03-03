


select count(*) from cd.facilities

select count(*) from cd.facilities where guestcost >=10

select recommendedby, count(recommendedby) as count 
from cd.members 
where recommendedby is not null
group by recommendedby
order by recommendedby

select f.facid , sum(slots) as total_slots from cd.bookings b inner join cd.facilities f on f.facid = b.facid
group by  f.facid
order by f.facid


select f.facid , sum(slots) as total_slots 
from cd.bookings b inner join cd.facilities f on f.facid = b.facid
where starttime::date >= '2012-09-01' and starttime::date < '2012-10-01'
group by  f.facid
order by total_slots

select f.facid , extract(month from date(starttime)) as month, sum(slots) as total_slots 
from cd.bookings b inner join cd.facilities f on f.facid = b.facid
where starttime::date >= '2012-01-01' and starttime::date < '2013-01-01'
group by  f.facid, extract(month from date(starttime))
order by f.facid, month



select  count(distinct cd.members.memid)  as count
from cd.members inner join cd.bookings 
on cd.members.memid = cd.bookings.memid
-- group by cd.members.memid
having count(cd.bookings.facid) > 1


select facid, sum(slots) as total_slots from cd.bookings
group by facid
having sum(slots)> 1000
order by facid


select f.name , 

sum( slots * case when memid = 0 then f.guestcost else f.membercost end) as revenue
from cd.bookings b inner join cd.facilities f on b.facid = f.facid
group by f.name
order by revenue



select f.name,
sum( slots * case when memid = 0 then f.guestcost else f.membercost end) as revenue
from cd.bookings b inner join cd.facilities f on b.facid = f.facid
group by f.name
having sum( slots * case when memid = 0 then f.guestcost else f.membercost end) < 1000
order by revenue


select facid, sum(slots) as total_slots from cd.bookings
group by facid
order by total_slots desc limit 1 

--alternative messy limitless version:
select facid, sum(slots) as total_slots from cd.bookings
group by facid
having sum(slots) = (select max(k) from (select facid, 
										sum(slots) as k from cd.bookings group by facid)o)


--alternative messy limitless version 2:

select facid, max(totalslots) from (
	select facid, sum(slots) as totalslots    
		from cd.bookings    
		group by facid
	) as sub group by facid
	
	
	
	
select facid, 
extract(month from date(starttime)) as month, 
sum(slots) as slots from cd.bookings where extract(year from date(starttime)) = '2012'

group by rollup(facid, extract(month from date(starttime)))
order by facid, month


select f.facid, f.name ,

trim(to_char(sum(b.slots)/2.0,'9999999999999999D99'))   as total_hours

from cd.bookings b inner join cd.facilities f on b.facid=f.facid
group by f.facid , f.name
order by f.facid
	
	
-- логика - выбрать первый букинг - это все даты больше 2012 сент и первый из них - это минимальный!!!
select  surname, firstname, cd.members.memid, min(starttime) as starttime
from cd.members 
inner join cd.bookings 
on cd.members.memid = cd.bookings.memid 
where starttime::date >= '2012-09-01'
group by surname, firstname, cd.members.memid
order by cd.members.memid
	

	
select (select count(*) as k from cd.members) ,
 firstname,surname 
from cd.members m  
order by m.joindate


select row_number() over( order by joindate) ,
firstname,surname
from cd.members


select facid, total from (

select facid, sum(slots) as total, 
rank() over (order by sum(slots) desc) as rank 
from cd.bookings group by facid) as ranked
where rank =1 


-- my solution
select rank2.name, 
rank() over (order by rank2.revenue desc) as ranky from 
(select f.name, 
sum( slots * case when memid = 0 
then f.guestcost else f.membercost end) as revenue
from cd.bookings b inner join cd.facilities f on b.facid = f.facid
group by f.name) rank2
 order by ranky limit 3
 
 
select name, rank from (
	select facs.name as name, rank() over (order by sum(case
				when memid = 0 then slots * facs.guestcost
				else slots * membercost
			end) desc) as rank
		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		group by facs.name
	) as subq
	where rank <= 3
order by rank;    





select 
firstname,surname,hours, 
rank() over( order by hours desc) as rank

		from (select m.firstname, m.surname, ((sum(b.slots)+10)/20)*10 as hours
		
		from
		cd.bookings b
		inner join cd.facilities f on b.facid = f.facid
		inner join cd.members m on m.memid = b.memid
		group by m.firstname, m.surname)k
		order by rank, surname, firstname
		 
 
 
 select name, case when class = 1 then 'high' when class = 2 then 'average' else 'low' end as revenue from 
(select f.name as name, 

ntile(3) over (order by 
									  
									  sum(
										case when memid = 0 then slots * f.guestcost
										else slots * membercost end) desc ) as class
										from cd.bookings b inner join cd.facilities f on f.facid = b.facid
										group by f.name) as subq
										order by class,name
										
										
										
										select 	facs.name as name,
	facs.initialoutlay/((sum(case
			when memid = 0 then slots * facs.guestcost
			else slots * membercost
		end)/3) - facs.monthlymaintenance) as months
	from cd.bookings bks
	inner join cd.facilities facs
		on bks.facid = facs.facid
	group by facs.facid
order by name;        


select 	dategen.date,
	(
		-- correlated subquery that, for each day fed into it,
		-- finds the average revenue for the last 15 days
		select sum(case
			when memid = 0 then slots * facs.guestcost
			else slots * membercost
		end) as rev

		from cd.bookings bks
		inner join cd.facilities facs
			on bks.facid = facs.facid
		where bks.starttime > dategen.date - interval '14 days'
			and bks.starttime < dategen.date + interval '1 day'
	)/15 as revenue
	from
	(
		-- generates a list of days in august
		select 	cast(generate_series(timestamp '2012-08-01',
			'2012-08-31','1 day') as date) as date
	)  as dategen
order by dategen.date; 


