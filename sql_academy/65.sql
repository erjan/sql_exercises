

-- Необходимо вывести рейтинг для комнат, которые хоть раз арендовали, как среднее значение рейтинга отзывов округленное до целого вниз.


select room_id, floor(avg(rating)) as rating from reservations inner join rooms on reservations.room_id = rooms.id 
inner join reviews on reviews.reservation_id = reservations.id
group by room_id 
having count(reservations.id) >=1

