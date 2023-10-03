Find countries that are in winemag_p1 dataset but not in winemag_p2.
Output distinct country names.
Order records by the country in ascending order.


select 

distinct country
from winemag_p1 w1 where w1.country not in (select country from winemag_p2)
order by country desc
