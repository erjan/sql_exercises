-- Выведите заполненность классов в порядке убывания

select 

class.name , count(student_in_class.student) as count

from student_in_class inner join student on student_in_class.student = student.id inner join class on class.id = student_in_class.class
group by class.id
order by count desc
