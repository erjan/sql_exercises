-- Выведите список комнат, которые были зарезервированы в течение 12 недели 2020 года.

select rooms.*

from reservations 
inner join rooms on rooms.id = reservations.room_id 
where week(start_date, 1) = 12 and year(start_date) = 2020
