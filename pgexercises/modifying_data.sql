insert into 
cd.facilities(facid,name, membercost, guestcost, 
			  initialoutlay, monthlymaintenance)
values(9, 'Spa', 20,30,100000, 800);


insert into cd.facilities(facid, name, membercost,guestcost,
						   initialoutlay, monthlymaintenance)
values(9, 'Spa', 20,30,	100000, 800),(10,'Squash Court 2', 3.5,17.5, 5000,80);

-- alternative
insert into cd.facilities
    (facid, name, membercost, guestcost, initialoutlay, monthlymaintenance)
    SELECT 9, 'Spa', 20, 30, 100000, 800
    UNION ALL
        SELECT 10, 'Squash Court 2', 3.5, 17.5, 5000, 80;
		
		
		
insert into cd.facilities(facid,name, membercost,guestcost, initialoutlay,monthlymaintenance)
 select (select max(facid) from cd.facilities)+1, 
	   'Spa', 20,30,100000,800;


update cd.facilities
set initialoutlay = 10000 where name = 'Tennis Court 2'


update cd.facilities
set membercost = 6,
guestcost = 30 where name like 'Tennis Court%'


update cd.facilities
set membercost = membercost*1.1,
guestcost = guestcost*1.1
where name = 'Tennis Court 2'


delete  from cd.bookings	   

delete from cd.members
where memid = 37

delete from cd.members m
where m.memid not in (select f.memid from cd.bookings f)
