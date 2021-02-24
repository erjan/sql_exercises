-- Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.

select name_student , date_attempt, result from subject join attempt on subject.subject_id = attempt.subject_id
join student on student.student_id = attempt.student_id where name_subject = 'Основы баз данных'
order by result desc ;

-- Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. Под результатом попытки понимается процент правильных 
-- ответов на вопросы теста, который занесен в столбец result.  Информацию вывести по убыванию средних результатов.

select name_subject, count(attempt.attempt_id) as 'Количество', round(avg(result),2) as 'Среднее'
from subject left join attempt on subject.subject_id = attempt.subject_id 
group by  name_subject
order by 'Среднее' desc;

-- Вывести студента (различных студентов), имеющих максимальные результаты попыток . Информацию отсортировать в алфавитном порядке по фамилии студента.

SELECT name_student, result
FROM attempt join student  on attempt.student_id = student.student_id
WHERE result = (
         SELECT max(result) 
         FROM attempt
      )    order by name_student


-- Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой. 
-- Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать.       

select 
name_student,
name_subject,
datediff(max(date_attempt),min(date_attempt) )  as Интервал
from subject inner join attempt on subject.subject_id = attempt.subject_id inner join
student on student.student_id = attempt.student_id
group by name_subject, name_student
having count(attempt.subject_id) > 1
order by Интервал asc


-- Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем). 
-- Вывести дисциплину и количество уникальных студентов, которые по ней проходили тестирование . 
-- Информацию отсортировать сначала по убыванию количества, а потом по названию дисциплины. 
-- В результат включить и дисциплины, тестирование по которым студенты не проходили, в этом случае указать количество студентов 0.

select name_subject, count(distinct student_id) as Количество

from attempt right join  subject on attempt.subject_id = subject.subject_id
group by  name_subject
order by Количество desc, name_subject

-- Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных».

select question_id , name_question 
from question join subject 
on question.subject_id = subject.subject_id where
name_subject = 'Основы баз данных' order by rand() limit 3;

-- Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17  (значение attempt_id для этой попытки равно 7). 
-- Указать, какой ответ дал студент и правильный он или нет. 

select name_question, name_answer, if (is_correct, 'Верно', 'Неверно') as  Результат

from answer inner join testing on answer.answer_id = testing.answer_id
inner join question on question.question_id = testing.question_id
where attempt_id = 7


-- Посчитать результаты тестирования. Результат попытки вычислить как количество правильных ответов, деленное
-- на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до двух знаков после запятой. 
-- Вывести фамилию студента, название предмета, дату и результат. 
-- Информацию отсортировать сначала по фамилии студента, потом по убыванию даты попытки.

select name_student, name_subject,date_attempt, round(sum(is_correct)/3 * 100,2) as Результат

from student

inner join attempt on student.student_id = attempt.student_id 
inner join testing on testing.attempt_id = attempt.attempt_id 
inner join subject on subject.subject_id = attempt.subject_id 
inner join answer on answer.answer_id = testing.answer_id
group by attempt.attempt_id, name_subject
order by name_student, date_attempt desc

-- Для каждого вопроса вывести процент успешных решений, то есть отношение количества верных ответов к 
-- общему количеству ответов, значение округлить до 2-х знаков после запятой. Также вывести название предмета, 
-- к которому относится вопрос, и общее количество ответов на этот вопрос. Информацию отсортировать сначала по 
-- названию дисциплины, потом по убыванию успешности, а потом по тексту вопроса в алфавитном порядке.


select 
name_subject,
CONCAT(LEFT(name_question,30),'...') as Вопрос,
count(testing.answer_id) as Всего_ответов,

ROUND(100*( sum(answer.is_correct) / count(testing.answer_id)),2) as Успешность

from answer right join question on answer.question_id = question.question_id
inner join subject on subject.subject_id = question.subject_id join testing on testing.question_id = question.question_id and answer.answer_id = testing.answer_id
group by question.question_id  
order by name_subject, Успешность desc, Вопрос asc
