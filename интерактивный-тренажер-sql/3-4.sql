-- Создать вспомогательную таблицу applicant,  куда включить id образовательной программы,  id абитуриента, сумму
-- баллов абитуриентов в отсортированном сначала по id образовательной программы, а потом по убыванию суммы баллов виде

CREATE TABLE applicant AS
SELECT     program.program_id,
           enrollee.enrollee_id,
           Sum(result) AS itog
FROM       enrollee
INNER JOIN program_enrollee
ON         enrollee.enrollee_id = program_enrollee.enrollee_id
INNER JOIN program
ON         program.program_id = program_enrollee.program_id
INNER JOIN program_subject
ON         program_subject.program_id = program.program_id
INNER JOIN subject
ON         subject.subject_id = program_subject.subject_id
INNER JOIN enrollee_subject
ON         enrollee_subject.subject_id = subject.subject_id
AND        enrollee_subject.enrollee_id = enrollee.enrollee_id
GROUP BY   program.program_id ,
           enrollee.enrollee_id
ORDER BY   program.program_id,
           itog DESC;SELECT *
FROM   applicant;

-- Из таблицы applicant,  созданной на предыдущем шаге, удалить записи, если абитуриент на
-- выбранную образовательную программу не набрал минимального балла хотя бы по одному предмету

DELETE applicant
FROM   applicant
JOIN   program_subject
using (program_id)
JOIN   enrollee_subject
using (enrollee_id, subject_id)
WHERE  result < min_ball;SELECT *
FROM   applicant;

-- Повысить итоговые баллы абитуриентов в таблице applicant на значения дополнительных баллов

UPDATE applicant
INNER JOIN
           (SELECT     enrollee_id, Sum(bonus) AS it2
                      FROM       achievement
                      INNER JOIN enrollee_achievement
                      ON         achievement.achievement_id = enrollee_achievement.achievement_id
                      GROUP BY   enrollee_id
                      ORDER BY   enrollee_id) q
ON         applicant.enrollee_id = q.enrollee_id
SET        itog = itog + it2;

-- Поскольку при добавлении дополнительных баллов, абитуриенты по каждой образовательной
-- программе могут следовать не в порядке убывания суммарных баллов, необходимо создать новую таблицу applicant_order
-- на основе таблицы applicant. При создании таблицы данные нужно отсортировать сначала по id образовательной программы, потом
-- по убыванию итогового балла. А таблицу applicant, которая была создана как вспомогательная, необходимо удалить

CREATE TABLE applicant_order AS
SELECT   *
FROM     applicant
ORDER BY program_id,
         itog DESC;DROP TABLE applicant;

-- Включить в таблицу applicant_order новый столбец str_id целого типа , расположить его перед первым.

ALTER TABLE applicant_order ADD str_id INT first;SELECT *
FROM   applicant_order;

-- Занести в столбец str_id таблицы applicant_order нумерацию абитуриентов, которая начинается с 1 для каждой образовательной программы.

SET @num_pr = 0;SET @row_num = 1;UPDATE applicant_order
INNER JOIN
           (SELECT program_id,enrollee_id,IF(program_id = @num_pr, @row_num := @row_num + 1, @row_num := 1) as str_num,
                         @num_pr := program_id                                             AS add_var
                  FROM   applicant_order) AS new_t
ON         applicant_order.program_id = new_t.program_id
AND        applicant_order.enrollee_id = new_t.enrollee_id
SET        str_id = str_num;

-- Создать таблицу student,  в которую включить абитуриентов, которые могут быть рекомендованы к зачислению  в соответствии с планом набора.
-- Информацию отсортировать сначала в алфавитном порядке по названию программ, а потом по убыванию итогового балла.

CREATE TABLE student AS
SELECT     name_program,
           name_enrollee,
           itog
FROM       enrollee
INNER JOIN applicant_order
ON         enrollee.enrollee_id = applicant_order.enrollee_id
INNER JOIN program
ON         program.program_id = applicant_order.program_id
WHERE      str_id <= PLAN
ORDER BY   name_program,
           itog DESC;

-- Придумайте один или несколько запросов корректировки данных для предметной области «Абитуриент»

SELECT name_program,
       name_enrollee,
       itog,
       Sum(min_result) AS min_result,IF((name_program, name_enrollee) IN (
       SELECT name_program,
              name_enrollee
       FROM   student), "Accepted", "Denied") as decision,
PLAN FROM applicant_order 
INNER JOIN program using (program_id) INNER JOIN program_subject using (program_id) INNER JOIN enrollee using (enrollee_id) 
GROUP BY name_program,
name_enrollee,
itog,
PLAN ORDER BY name_program,
decision;
