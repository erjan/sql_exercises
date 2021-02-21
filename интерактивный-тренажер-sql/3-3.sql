-- Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде
select 
name_enrollee from enrollee join program_enrollee on enrollee.enrollee_id = program_enrollee.enrollee_id join program on 
program.program_id = program_enrollee.program_id
where program.name_program = 'Мехатроника и робототехника'
order by substring_index(name_enrollee, ' ' , 1) asc

--  Вывести образовательные программы, на которые для поступления необходим предмет «Информатика».
select name_program from program join program_subject on program.program_id = program_subject.program_id 
join subject on subject.subject_id = program_subject.subject_id where name_subject = 'Информатика'

-- Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. 
-- Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.

select 
name_subject, 
count(enrollee_id) as Количество ,  
max(result) as Максимум ,
min(result) as Минимум, 
round(avg(result),1) as Среднее 
from enrollee_subject join subject on subject.subject_id = enrollee_subject.subject_id group by name_subject
order by name_subject asc

-- Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету 
-- больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.

select name_program from program join program_subject on program.program_id = program_subject.program_id 
 group by name_program 
 having min(min_result) >=40
order by name_program asc

--  Вывести образовательные программы, которые имеют самый большой план набора.

select name_program, plan from program where plan = (select max(plan) from program)

-- Посчитать, сколько дополнительных баллов получит каждый абитуриент. Информацию вывести в отсортированном по фамилиям виде.
select  name_enrollee,  sum(if (bonus is NULL,  0 , bonus)) as Бонус 
from enrollee e 

left join enrollee_achievement ea on e.enrollee_id =  ea.enrollee_id 
left join achievement a on ea.achievement_id = a.achievement_id 
group by name_enrollee order by name_enrollee


-- Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на 
-- нее (число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. 
-- В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, 
-- план набора абитуриентов на образовательную программу (plan), 
-- количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса

select name_department, name_program, plan , 
count(pe.program_enrollee_id) as Количество,
round(count(pe.program_enrollee_id)/p.plan,2) as Конкурс

from department d inner join program p on d.department_id = p.department_id inner join program_enrollee pe on p.program_id = pe.program_id
 group by name_department, name_program, plan
 order by Конкурс desc
 
 -- Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.
 select  name_program from program inner join program_subject on program.program_id = program_subject.program_id inner join subject on program_subject.subject_id = subject.subject_id 
where name_subject in ('Математика', 'Информатика') 
group by name_program
having count(name_program) = 2
order by name_program

-- Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. 
-- В отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов.

select name_program, name_enrollee, sum(result) as itog
from enrollee  inner join program_enrollee on enrollee.enrollee_id = program_enrollee.enrollee_id 
inner join program on program.program_id = program_enrollee.program_id 
inner join program_subject on program_subject.program_id = program.program_id 
inner join subject on subject.subject_id = program_subject.subject_id
inner join enrollee_subject on enrollee_subject.subject_id = subject.subject_id and enrollee_subject.enrollee_id = enrollee.enrollee_id

group by name_program,name_enrollee
order by name_program, itog desc

-- Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали 
-- документы на эту образовательную программу, но не могут быть зачислены на нее. 
-- Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления на эту 
-- образовательную программу, меньше минимального балла. 
-- Информацию вывести в отсортированном сначала по программам, а потом по фамилиям абитуриентов виде.

select name_program, name_enrollee
from enrollee inner join program_enrollee on enrollee.enrollee_id = program_enrollee.enrollee_id 
inner join program on program.program_id = program_enrollee.program_id 
inner join program_subject on program_subject.program_id = program.program_id 
inner join subject on subject.subject_id = program_subject.subject_id
inner join enrollee_subject on enrollee_subject.subject_id = subject.subject_id and enrollee_subject.enrollee_id = enrollee.enrollee_id
where enrollee_subject.result < program_subject.min_result
group by name_program,name_enrollee
order by name_program, name_enrollee

-- произвольное посл задание

select 
lower(name_subject) as предмет,  
round(min(result),1) as минимум, 
round(max(result),1) as максимум, 
round(avg(result),0) as среднее, 
count(enrollee_id) as количество 
from subject 
inner join enrollee_subject on subject.subject_id = enrollee_subject.subject_id 

group by 
name_subject

order by avg(result) desc
