-- Вывести отсортированный по количеству перелетов (по убыванию) и имени (по возрастанию) список пассажиров, совершивших хотя бы 1 полет.


select name, count(trip.id) as count 

from passenger inner join pass_in_trip on passenger.id = pass_in_trip.passenger inner join trip on trip.id = pass_in_trip.trip
group by passenger
having count(pass_in_trip.id) > 0
order by count(trip.id) desc, name asc
