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
