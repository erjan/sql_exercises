Find how many athletes competing in Football won Gold medals by their NOC and gender.
Output the NOC, sex, and the corresponding number of athletes.
Sort records by the NOC, sex, and the number of athletes in ascending order.




select 

noc, sex, count(id)
from olympics_athletes_events
where sport = 'Football' and medal= 'Gold'
group by noc,sex

