-- В какие города можно улететь из Парижа (Paris) и сколько времени это займёт?

select town_to , timediff( time_in , time_out) as flight_time from trip  where town_from  = 'Paris'
