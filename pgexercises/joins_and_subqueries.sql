select starttime from cd.bookings inner join cd.members on cd.members.memid = cd.bookings.memid
where firstname = 'David' and surname = 'Farrell'


select starttime as start, name from cd.bookings inner join cd.facilities on cd.bookings.facid =
cd.facilities.facid where name like 'Tennis %'  and starttime::date = '2012-09-21%' 
order by start


select  distinct m1.firstname,  m1.surname 
from cd.members m1 
 inner join cd.members m2 on m1.memid = m2.recommendedby 
order by surname, firstname


select 
 mem.firstname as memfname, 
mem.surname as memsname, 

rec.firstname as recfname,
rec.surname as recsname

from cd.members mem left outer join cd.members rec on rec.memid = mem.recommendedby

order by memsname, memfname;



select distinct concat(firstname,' ',  surname ) as member,
name as facility
from cd.members 
inner join cd.bookings on cd.members.memid = cd.bookings.memid 
inner join cd.facilities on cd.facilities.facid = cd.bookings.facid where name like 'Tennis%'
order by member, facility




select concat(firstname, ' ', surname) as member,
name as facility,

case when cd.members.memid = 0 then slots * guestcost
else slots * membercost end as cost

from cd.members inner join cd.bookings on cd.members.memid = cd.bookings.memid 
inner join cd.facilities on
cd.facilities.facid = cd.bookings.facid 

where cd.bookings.starttime >= '2012-09-14' and cd.bookings.starttime < '2012-09-15'

and ((cd.members.memid = 0 and slots*guestcost > 30) or ( cd.members.memid != 0 and slots *membercost > 30))
order by cost desc




-- логика - ид рекомендателя должен быть тем самым который recommendedby! должен совпадать с тем кто стоит
в таблице у члена мембера как рекомендатель!
select 
distinct 
concat(m.firstname, ' ' , m.surname) as member,

(select concat(rec.firstname, ' ', rec.surname) as recommender 
 from cd.members rec 
 where rec.memid = m.recommendedby)
 
 from cd.members m
 order by member
 
 
 
 
 select  member,
 facility, cost from (  
   
   select concat(m.firstname , ' ' , m.surname) as member, name as facility,
   
   
   case when m.memid = 0 then b.slots* f.guestcost
   else b.slots*f.membercost end as cost
   
   from cd.members m inner join cd.bookings b on b.memid = m.memid
   inner join cd.facilities f on f.facid = b.facid
   
   where b.starttime >= '2012-09-14' and b.starttime < '2012-09-15'
   
   )as bookings
   where cost > 30
   order by cost desc
