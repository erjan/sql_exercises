Find colleges that produce the most NFL players.  Output the college name and the player count. Order the result based on the player count in descending order. Players that were not drafted into the NFL have 0s as values in the pickround column.


select 

college, count(name) as x
from nfl_combine
where pickround <> 0  group by college
order by x desc

