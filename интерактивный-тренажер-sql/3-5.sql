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

для каждого пользователя вычислить время прохождения шага как сумму времени, потраченного на каждую попытку (время попытки - это разница между временем отправки задания и временем начала попытки), при этом попытки, которые длились больше 4 часов не учитывать, так как пользователь мог просто оставить задание открытым в браузере, а вернуться к нему на следующий день;
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
