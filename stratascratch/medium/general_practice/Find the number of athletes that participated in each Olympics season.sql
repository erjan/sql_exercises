Find the number of athletes that participated in each Olympics season.
Output the season with the corresponding number of athletes.


select season, count(distinct id) from olympics_athletes_events group by season
