-- Создать вспомогательную таблицу applicant,  куда включить id образовательной программы,  id абитуриента, сумму 
-- баллов абитуриентов в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде


create table applicant as 
select program.program_id, enrollee.enrollee_id, sum(result) as itog
from enrollee  inner join program_enrollee on enrollee.enrollee_id = program_enrollee.enrollee_id 
inner join program on program.program_id = program_enrollee.program_id 
inner join program_subject on program_subject.program_id = program.program_id 
inner join subject on subject.subject_id = program_subject.subject_id
inner join enrollee_subject on enrollee_subject.subject_id = subject.subject_id and enrollee_subject.enrollee_id = enrollee.enrollee_id

group by program.program_id ,enrollee.enrollee_id
order by program.program_id, itog desc;

select * from applicant;

-- Из таблицы applicant,  созданной на предыдущем шаге, удалить записи, если абитуриент на 
-- выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету

DELETE applicant
FROM applicant
JOIN program_subject USING(program_id)
JOIN enrollee_subject USING(enrollee_id, subject_id)
WHERE result < min_ball;

SELECT * FROM applicant;

-- Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов

update applicant
inner join (select  enrollee_id,  sum(bonus) as it2  from achievement inner join enrollee_achievement on 
achievement.achievement_id = enrollee_achievement.achievement_id
group by enrollee_id
order by enrollee_id) q on applicant.enrollee_id = q.enrollee_id
set itog = itog + it2;

-- Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной 
-- программе могут следовать не в порядке убывания суммарных баллов, необходимо создать новую таблицу applicant_order  
-- на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала по id образовательной программы, потом 
-- по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить

 create table applicant_order as
select * from applicant
order by program_id, itog desc;

drop table applicant;

-- Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.


ALTER TABLE applicant_order ADD str_id INT FIRST;
SELECT * FROM applicant_order;


-- Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.

SET @num_pr = 0;
SET @row_num = 1;

update applicant_order inner join

(SELECT  program_id, enrollee_id,
     if(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1) AS str_num,
     @num_pr := program_id AS add_var 
from applicant_order) as new_t on applicant_order.program_id = new_t.program_id and applicant_order.enrollee_id = new_t.enrollee_id
set  str_id = str_num;


-- Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению  в соответствии с планом набора. 
-- Информацию отсортировать сначала в алфавитном порядке по названию программ, а потом по убыванию итогового балла.

create table student as 
select name_program, name_enrollee,  itog 
from enrollee 
inner join applicant_order on enrollee.enrollee_id = applicant_order.enrollee_id
inner join program on program.program_id = applicant_order.program_id
where str_id <= plan
order by name_program, itog desc;


-- Придумайте один или несколько запросов корректировки данных для предметной области «Абитуриент» 
SELECT name_program, 
	   name_enrollee, 
	   itog, 
	   SUM(min_result) AS min_result,
	   IF((name_program, name_enrollee) IN (SELECT name_program, name_enrollee FROM student), "Accepted", "Denied") AS decision,
       plan
FROM applicant_order
	INNER JOIN program USING (program_id)
    INNER JOIN program_subject USING (program_id)
	INNER JOIN enrollee USING (enrollee_id)
GROUP BY name_program, name_enrollee, itog, plan
ORDER BY name_program, decision;
