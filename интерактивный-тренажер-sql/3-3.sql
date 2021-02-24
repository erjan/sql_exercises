-- Вывести абитуриентов, которые хотят поступать на образовательную программу «Мехатроника и робототехника» в отсортированном по фамилиям виде
SELECT name_enrollee
FROM   enrollee
       JOIN program_enrollee
         ON enrollee.enrollee_id = program_enrollee.enrollee_id
       JOIN program
         ON program.program_id = program_enrollee.program_id
WHERE  program.name_program =
       'Мехатроника и робототехника'
ORDER  BY Substring_index(name_enrollee, ' ', 1) ASC

--  Вывести образовательные программы, на которые для поступления необходим предмет «Информатика».
SELECT name_program
FROM   program
       JOIN program_subject
         ON program.program_id = program_subject.program_id
       JOIN subject
         ON subject.subject_id = program_subject.subject_id
WHERE  name_subject = 'Информатика'

-- Выведите количество абитуриентов, сдавших ЕГЭ по каждому предмету, максимальное, минимальное и среднее значение баллов по предмету ЕГЭ. 
-- Информацию отсортировать по названию предмета в алфавитном порядке, среднее значение округлить до одного знака после запятой.
SELECT name_subject,
       Count(enrollee_id)    AS Количество,
       Max(result)           AS Максимум,
       Min(result)           AS Минимум,
       Round(Avg(result), 1) AS Среднее
FROM   enrollee_subject
       JOIN subject
         ON subject.subject_id = enrollee_subject.subject_id
GROUP  BY name_subject
ORDER  BY name_subject ASC

-- Вывести образовательные программы, для которых минимальный балл ЕГЭ по каждому предмету 
-- больше или равен 40 баллам. Программы вывести в отсортированном по алфавиту виде.
SELECT name_program
FROM   program
       JOIN program_subject
         ON program.program_id = program_subject.program_id
GROUP  BY name_program
HAVING Min(min_result) >= 40
ORDER  BY name_program ASC

--  Вывести образовательные программы, которые имеют самый большой план набора.
SELECT name_program,
       plan
FROM   program
WHERE  plan = (SELECT Max(plan)
               FROM   program)

-- Посчитать, сколько дополнительных баллов получит каждый абитуриент. Информацию вывести в отсортированном по фамилиям виде.
SELECT name_enrollee,
       SUM(If (bonus IS NULL, 0, bonus)) AS Бонус
FROM   enrollee e
       LEFT JOIN enrollee_achievement ea
              ON e.enrollee_id = ea.enrollee_id
       LEFT JOIN achievement a
              ON ea.achievement_id = a.achievement_id
GROUP  BY name_enrollee
ORDER  BY name_enrollee

-- Выведите сколько человек подало заявление на каждую образовательную программу и конкурс на 
-- нее (число поданных заявлений деленное на количество мест по плану), округленный до 2-х знаков после запятой. 
-- В запросе вывести название факультета, к которому относится образовательная программа, название образовательной программы, 
-- план набора абитуриентов на образовательную программу (plan), 
-- количество поданных заявлений (Количество) и Конкурс. Информацию отсортировать в порядке убывания конкурса
SELECT name_department,
       name_program,
       plan,
       Count(pe.program_enrollee_id)                    AS Количество,
       Round(Count(pe.program_enrollee_id) / p.plan, 2) AS Конкурс
FROM   department d
       INNER JOIN program p
               ON d.department_id = p.department_id
       INNER JOIN program_enrollee pe
               ON p.program_id = pe.program_id
GROUP  BY name_department,
          name_program,
          plan
ORDER  BY ������� DESC

-- Вывести образовательные программы, на которые для поступления необходимы предмет «Информатика» и «Математика» в отсортированном по названию программ виде.
SELECT name_program
FROM   program
       INNER JOIN program_subject
               ON program.program_id = program_subject.program_id
       INNER JOIN subject
               ON program_subject.subject_id = subject.subject_id
WHERE  name_subject IN ( 'Математика', 'Информатика' )
GROUP  BY name_program
HAVING Count(name_program) = 2
ORDER  BY name_program

-- Посчитать количество баллов каждого абитуриента на каждую образовательную программу, на которую он подал заявление, по результатам ЕГЭ. 
-- В отсортированном сначала по образовательной программе, а потом по убыванию суммы баллов.
SELECT name_program,
       name_enrollee,
       SUM(result) AS itog
FROM   enrollee
       INNER JOIN program_enrollee
               ON enrollee.enrollee_id = program_enrollee.enrollee_id
       INNER JOIN program
               ON program.program_id = program_enrollee.program_id
       INNER JOIN program_subject
               ON program_subject.program_id = program.program_id
       INNER JOIN subject
               ON subject.subject_id = program_subject.subject_id
       INNER JOIN enrollee_subject
               ON enrollee_subject.subject_id = subject.subject_id
                  AND enrollee_subject.enrollee_id = enrollee.enrollee_id
GROUP  BY name_program,
          name_enrollee
ORDER  BY name_program,
          itog DESC

-- Вывести название образовательной программы и фамилию тех абитуриентов, которые подавали 
-- документы на эту образовательную программу, но не могут быть зачислены на нее. 
-- Эти абитуриенты имеют результат по одному или нескольким предметам ЕГЭ, необходимым для поступления на эту 
-- образовательную программу, меньше минимального балла. 
-- Информацию вывести в отсортированном сначала по программам, а потом по фамилиям абитуриентов виде.
SELECT name_program,
       name_enrollee
FROM   enrollee
       INNER JOIN program_enrollee
               ON enrollee.enrollee_id = program_enrollee.enrollee_id
       INNER JOIN program
               ON program.program_id = program_enrollee.program_id
       INNER JOIN program_subject
               ON program_subject.program_id = program.program_id
       INNER JOIN subject
               ON subject.subject_id = program_subject.subject_id
       INNER JOIN enrollee_subject
               ON enrollee_subject.subject_id = subject.subject_id
                  AND enrollee_subject.enrollee_id = enrollee.enrollee_id
WHERE  enrollee_subject.result < program_subject.min_result
GROUP  BY name_program,
          name_enrollee
ORDER  BY name_program,
          name_enrollee

-- произвольное посл задание
SELECT Lower(name_subject)   AS предмет,
       Round(Min(result), 1) AS минимум,
       Round(Max(result), 1) AS максимум,
       Round(Avg(result), 0) AS среднее,
       Count(enrollee_id)    AS количество
FROM   subject
       INNER JOIN enrollee_subject
               ON subject.subject_id = enrollee_subject.subject_id
GROUP  BY name_subject
ORDER  BY Avg(result) DESC 
