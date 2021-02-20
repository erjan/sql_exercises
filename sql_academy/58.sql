    
  -- Добавить отзыв с рейтингом 5 на жилье, находящиеся по адресу "11218, Friel Place, New York", от имени "George Clooney"
  
insert into reviews (id, reservation_id, rating)

select COUNT(*) + 1 ,
 
(select reservations.id from users 
inner join 
reservations on users.id = reservations.user_id 
inner join rooms on rooms.id = reservations.room_id where users.name = 'George Clooney' 
and rooms.address = "11218, Friel Place, New York"),
 
 
 5 from reviews;


