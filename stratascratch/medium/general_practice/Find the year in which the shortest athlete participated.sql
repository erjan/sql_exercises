Find the year in which the shortest athlete participated.
Output the year and the corresponding height.



select 

year, height
from olympics_athletes_events where height = (select min(height) from olympics_athletes_events)
