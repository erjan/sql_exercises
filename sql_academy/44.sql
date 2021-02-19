
-- Найдите максимальный возраст (колич. лет) среди обучающихся 10 классов ?
select 

year(now()) - year(birthday) as max_year 

from student_in_class inner join student on student_in_class.student = student.id  inner join class on class.id = student_in_class.class where class.name like '10%'
order by max_year desc limit 1
