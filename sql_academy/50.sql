-- Какой процент обучающихся родился в 2000 году? Результат округлить до целого в меньшую сторону.

select  floor(100*sum( if(  year(birthday) = 2000, 1, 0)) / count(student.id) ) as percent from student 
