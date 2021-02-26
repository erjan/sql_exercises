-- Отобрать все шаги, в которых рассматриваются вложенные запросы. Указать к какому уроку и модулю они относятся. Для этого вывести 3 поля
select 
concat(left(concat(module.module_id, ' ', module_name), 16),'...')  as Модуль,
concat(left(concat(module.module_id, '.', lesson_position, ' ', lesson_name),16) ,'...') as Урок,
concat(module.module_id,'.' ,lesson_position,'.', step_position, ' ', step_name) as Шаг
from module inner join lesson on module.module_id = lesson.module_id inner join step on lesson.lesson_id = step.lesson_id
where instr(step_name , 'Вложен')
order by Модуль, Урок, Шаг

-- Заполнить таблицу step_keyword следующим образом: если ключевое слово есть в названии шага, то включить в step_keyword строку с id шага и id ключевого слова. 
insert into step_keyword 
(step_id,keyword_id)
select step_id, keyword_id
FROM step CROSS JOIN keyword
WHERE REGEXP_INSTR(step_name, CONCAT("\\b", keyword_name, "\\b"))

-- Реализовать поиск по ключевым словам. Вывести шаги, с которыми связаны ключевые слова MIN и AVG одновременно. Для шагов указать 
-- номер модуля, номер урока, номер шага через точку, после номера шага перед заголовком - пробел. Столбец назвать Шаг. 
-- Информацию отсортировать по возрастанию сначала по порядковому номеру модуля, затем по порядковым номерам урока и шага соответственно
SELECT  CONCAT(module_id,".",lesson_position,".",step_position, " ", step_name) AS Шаг
FROM module INNER JOIN lesson USING(module_id) INNER JOIN step USING(lesson_id) INNER JOIN step_keyword USING(step_id) INNER JOIN keyword USING(keyword_id)
WHERE step_name REGEXP(CONCAT("\\b",keyword_name,"\\b"))
and keyword_name IN("MIN", "AVG")
GROUP BY Шаг
HAVING COUNT(keyword_name)=2;

-- Посчитать, сколько студентов относится к каждой группе. Указать границы интервала.
select 
Группа,
case Группа
    when  'I' then 'от 0 до 10'
    when 'II' then 'от 11 до 15'
    when 'III' then 'от 16 до 27'
    when  'IV' then 'больше 27' 
END AS Интервал,
count(RATE) as Количество
from (SELECT student_name, rate, 
    CASE
        WHEN rate <= 10 THEN "I"
        WHEN rate <= 15 THEN "II"
        WHEN rate <= 27 THEN "III"
        ELSE "IV"
    END AS Группа
FROM      (SELECT student_name, count(*) as rate
     FROM (SELECT student_name, step_id
          FROM student INNER JOIN step_student USING(student_id)
          WHERE result = "correct" GROUP BY student_name, step_id) query_in GROUP BY student_name 
     ORDER BY 2) query_in_1) we    
group by Группа
                              
-- Исправить запрос примера так: для шагов, которые  не имеют неверных ответов,  указать 100 как процент успешных 
-- попыток, если же шаг не имеет верных ответов, указать 0. 
-- Информацию отсортировать сначала по возрастанию успешности, а затем по названию шага в алфавитном порядке.
WITH get_count_correct (st_n_c, count_correct) 
  AS (
    SELECT step_name, count(*)
    FROM 
        step 
        INNER JOIN step_student USING (step_id)
    WHERE result = "correct"
    GROUP BY step_name
   ),
  get_count_wrong (st_n_w, count_wrong) 
  AS (
    SELECT step_name, count(*)
    FROM 
        step 
        INNER JOIN step_student USING (step_id)
    WHERE result = "wrong"
    GROUP BY step_name
   )   
SELECT st_n_c AS Шаг,
case when count_wrong is null then 100  
   when count_correct is null then 0
else
    ROUND(count_correct / (count_correct + count_wrong) * 100) end AS Успешность     
FROM  
    get_count_correct 
    LEFT JOIN get_count_wrong ON st_n_c = st_n_w
UNION
SELECT st_n_w AS Шаг,
case 
   when count_wrong is null then 100  
   when count_correct is null then 0
else
    ROUND(count_correct / (count_correct + count_wrong) * 100) end AS Успешность      
FROM  
    get_count_correct 
    RIGHT JOIN get_count_wrong ON st_n_c = st_n_w   
ORDER BY Успешность  asc, Шаг asc;
                              
-- Вычислить прогресс пользователей по курсу. Прогресс вычисляется как отношение верно пройденных шагов к 
-- общему количеству шагов в процентах, округленное до целого. В нашей базе данные о решениях занесены не для всех шагов, 
-- поэтому общее количество шагов определить как количество различных шагов в таблице step_student.
SET @max_progress = (SELECT COUNT(DISTINCT step_id) FROM step_student);
WITH get1 (student_id, count_correct) AS (
      SELECT student_id,  count(distinct step_id) 
      FROM  step_student     
      where result = 'correct'
      GROUP BY student_id)
select Студент,Прогресс,
    case 
        when Прогресс = 100 then "Сертификат с отличием"
        when Прогресс >= 80 then "Сертификат"
        else "" 
    end as Результат
from (
select student.student_name as Студент,
    round(100*( count_correct / @max_progress  )) AS Прогресс
FROM  get1 inner join student on get1.student_id = student.student_id)k
order by Прогресс desc, Студент asc
          
-- Для студента с именем student_61 вывести все его попытки: название шага, результат и дату отправки попытки (submission_time). 
-- Информацию отсортировать по дате отправки попытки и указать, сколько минут прошло между отправкой соседних попыток.
select student_name as Студент,
concat(left(step_name, 20), '...') as Шаг,
result as Результат,
from_unixtime(submission_time) as Дата_отправки,
sec_to_time(-ifnull(   lag(submission_time) over (order by submission_time) - submission_time,0) ) as Разница
from student join step_student using (student_id) join step using(step_id)
where student_name = 'student_61';
          
     /*     
        Посчитать среднее время, за которое пользователи проходят урок по следующему алгоритму:
для каждого пользователя вычислить время прохождения шага как сумму времени, потраченного на каждую 
          попытку (время попытки - это разница между временем отправки задания и временем начала попытки), при этом попытки, которые 
          длились больше 4 часов не учитывать, так как пользователь мог просто оставить задание открытым в браузере, а вернуться к нему на следующий день;
для каждого студента посчитать общее время, которое он затратил на каждый урок;
вычислить среднее время выполнения урока в часах, результат округлить до 2-х знаков после запятой;
вывести информацию по возрастанию времени, пронумеровав строки, для каждого урока указать номер модуля и его позицию в нем.            
      */                    
with 
 diff_step_time as (
 select student_id, step_student.step_id as step_id,  (submission_time - attempt_time) as step_time 
 from step_student
 where (submission_time - attempt_time) < 4 * 3600
 order by student_id),  
 one_step_time as (
 select student_id, step.step_id, lesson_id, sum(step_time) as total_step_time 
 from diff_step_time inner join step on step.step_id = diff_step_time.step_id
 group by student_id, step.step_id
 order by student_id),  
  s3 as (
  select lesson.lesson_id, student_id, lesson_name, module_id ,sum(total_step_time)/3600 as lesson_time from one_step_time inner join lesson on lesson.lesson_id = one_step_time.lesson_id
  group by lesson.lesson_id, student_id, lesson_name, module_id), 
 s4 as (
 select s3.lesson_id, round(avg(lesson_time),2) as Среднее_время ,s3.module_id , lesson.lesson_position, lesson.lesson_name
 from s3 inner join lesson on lesson.lesson_id = s3.lesson_id
 group by s3.lesson_id, module_id )
  
 select 
 row_number() over ( order by Среднее_время) as Номер,
 concat(module_id,'.',lesson_position, ' ', lesson_name) as Урок, Среднее_время from s4
 order by Среднее_время asc

          
          
-- Вычислить рейтинг каждого студента относительно студента, прошедшего наибольшее количество шагов в 
-- модуле (вычисляется как отношение количества пройденных студентом шагов к максимальному количеству пройденных шагов, умноженное на 100). 
-- Вывести номер модуля, имя студента, количество пройденных им шагов и 
-- относительный рейтинг. Относительный рейтинг округлить до одного знака после запятой                              
with helper(mod_id, stud_id, correct) as (
SELECT module_id, student_id,  count(DISTINCT step_id) as correct
   FROM step_student INNER JOIN step USING (step_id)
                     INNER JOIN lesson USING (lesson_id)
   WHERE result = "correct" 
   GROUP BY student_id, module_id)   
SELECT 
mod_id AS Модуль, 
student_name as Студент, 
correct as Пройдено_шагов,
 round(100* (correct/ MAX(correct) OVER (PARTITION BY mod_id)),1) AS Относительный_рейтинг 
FROM helper  inner join student on helper.stud_id = student.student_id
order by mod_id asc ,Относительный_рейтинг desc, student_name   
                                       
-- Проанализировать, в каком порядке и с каким интервалом пользователь отправлял последнее верно выполненное задание каждого урока. 
-- Учитывать только студентов, прошедших хотя бы один шаг из всех трех уроков. 
-- В базе занесены попытки студентов  для трех уроков курса, поэтому анализ проводить только для этих уроков  
with s1 as (
select 
step_student.student_id,step.step_id, lesson_id, submission_time
from step_student inner join step on step.step_id = step_student.step_id
where result = 'correct'
group by step_student.student_id,step.step_id, lesson_id, submission_time),
s2 as (
select 
student_id, 
lesson.lesson_id,     
submission_time,
max(submission_time) over(partition by student_id, lesson.lesson_id) as max_time
from s1 inner join lesson on s1.lesson_id = lesson.lesson_id
group by student_id, lesson.lesson_id, submission_time
order by student_id, lesson.lesson_id),

s3 as (
select 
student_id 
from s2 group by student_id
having count(distinct lesson_id) = 3)

select  
student_name as Студент,
concat(lesson.module_id, '.', lesson_position) as Урок, 
from_unixtime(s2.max_time) as Макс_время_отправки,
IFNULL(CEIL((s2.max_time-LEAD(s2.max_time) OVER (PARTITION BY student_name ORDER BY s2.max_time DESC))/86400),'-') as Интервал      
from s3 inner join s2 using(student_id) inner join student on student.student_id = s3.student_id  inner join lesson on lesson.lesson_id = s2.lesson_id
group by student_name, lesson.module_id, lesson_position, s2.max_time
order by Студент, Макс_время_отправки

             

-- Для студента с именем student_59 вывести следующую информацию по всем его попыткам:
-- информация о шаге: номер модуля, символ '.', позиция урока в модуле, символ '.', позиция шага в модуле;
-- порядковый номер попытки для каждого шага - определяется по возрастанию времени отправки попытки;
-- результат попытки;
-- время попытки (преобразованное к формату времени) - определяется как разность между временем отправки попытки и времени ее начала, в случае если попытка длилась более 1 часа, то время попытки заменить на среднее время всех попыток пользователя по всем шагам без учета тех, которые длились больше 1 часа;
-- относительное время попытки  - определяется как отношение времени попытки (с учетом замены времени попытки) к суммарному времени всех попыток  шага, округленное до двух знаков после запятой.
             
             
             with s1 as ( 
   
select  round(avg(submission_time - attempt_time)) as time 
from step_student 
where student_id = 59 and (submission_time - attempt_time) < 3600 ),

s2 (s_name, shag,st_id, num_attempt, r, time_attempt) as (
select 
student_name as s_name,
concat(lesson.module_id, '.', lesson_position, '.',step_position) as shag, 
    
step_student.step_id as st_id,
row_number() over(partition by step.step_id order by submission_time ) as num_attempt ,
result as r,
case when (submission_time - attempt_time) > 3600 then (select * from s1)
else (submission_time - attempt_time) end   as time_attempt      
from step_student 
inner join student on student.student_id = step_student.student_id 
inner join step on step.step_id = step_student.step_id 
inner join lesson on lesson.lesson_id = step.lesson_id 
     where step_student.student_id = 59)

select 
  s_name as Студент,
  shag as  Шаг,
  num_attempt as Номер_попытки, 
  r as Результат,
  sec_to_time(time_attempt) as Время_попытки,

  round(time_attempt/sum(time_attempt) OVER (partition by  s2.st_id   )*100,2)  as Относительное_время
  
 from s2 
  order by s2.st_id asc , Номер_попытки asc
