
-- Выведите нагруженность (число пассажиров) каждого рейса (trip). Результат вывести в отсортированном виде по убыванию нагруженности.

select trip, count(pass_in_trip.passenger) as count from 

pass_in_trip  
group by trip
order by count desc
