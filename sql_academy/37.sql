-- Сколько лет самому молодому обучающемуся ?


select  timestampdiff( YEAR,  birthday, curdate()) as year from student_in_class inner join student on student_in_class.student = student.id order by birthday desc limit 1



