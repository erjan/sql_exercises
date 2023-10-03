Find the number of athletes who participated in the Olympics that hosted in European cities.
European cities: Berlin, Athina, Lillehammer, London, Albertville and Paris.


select count(distinct id) from olympics_athletes_events
where city in ('Berlin', 'Athina', 'Lillehammer', 'London', 'Albertville' ,'Paris')

