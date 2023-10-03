Find all possible varieties which occur in either of the winemag datasets.
Output unique variety values only.
Sort records based on the variety in ascending order.


select distinct variety from (
select variety from winemag_p1
union all 
select variety from winemag_p2) k
