-- Какой процент обучающихся учится в 10 A классе ?

select 100* sum(if(class.name = '10 A', 1,0))/ count(student.id) as percent 
from class inner join student_in_class on class.id = student_in_class.class right join student on student.id = student_in_class.student
