select  timestamp '2012-08-31 01:00:00'


select timestamp '2012-08-31 01:00:00' - timestamp'2012-07-30 01:00:00' as interval;


select generate_series(
           (date '2012-10-01')::timestamp,
           (date '2012-10-31')::timestamp,
           interval '1 day'
         );
		 
		 
		 
select extract (day from  date(timestamp '2012-08-31') ) as date_part		 

select extract(epoch from  (timestamp '2012-09-02 00:00:00' - timestamp '2012-08-31 01:00:00'))  as t;


select 	extract(month from cal.month) as month,
	(cal.month + interval '1 month') - cal.month as length
	from
	(
		select generate_series(timestamp '2012-01-01', timestamp '2012-12-01', interval '1 month') as month
	) cal
order by month;


select (date_trunc('month',ts.testts) + interval '1 month') 
		- date_trunc('day', ts.testts) as remaining
	from (select timestamp '2012-02-11 01:00:00' as testts) ts       
	
	
	
select 

starttime,

starttime + slots* (interval '30 minutes') as endtime

from cd.bookings 
order by endtime desc ,starttime desc limit 10



select 

date_trunc('month' , starttime) as month,
count(facid) 
from cd.bookings
group by  date_trunc('month' , starttime)
order by date_trunc('month' , starttime)

select name, month, 
	round((100*slots)/
		cast(
			25*(cast((month + interval '1 month') as date)
			- cast (month as date)) as numeric),1) as utilisation
	from  (
		select facs.name as name, date_trunc('month', starttime) as month, sum(slots) as slots
			from cd.bookings bks
			inner join cd.facilities facs
				on bks.facid = facs.facid
			group by facs.facid, month
	) as inn
order by name, month 
