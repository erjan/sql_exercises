-- Вывести студентов, которые сдавали дисциплину «Основы баз данных», указать дату попытки и результат. Информацию вывести по убыванию результатов тестирования.
SELECT   name_student ,
         date_attempt,
         result
FROM     subject
JOIN     attempt
ON       subject.subject_id = attempt.subject_id
JOIN     student
ON       student.student_id = attempt.student_id
WHERE    name_subject = 'Основы баз данных'
ORDER BY result DESC ;

-- Вывести, сколько попыток сделали студенты по каждой дисциплине, а также средний результат попыток, который округлить до 2 знаков после запятой. Под результатом попытки понимается процент правильных
-- ответов на вопросы теста, который занесен в столбец result.  Информацию вывести по убыванию средних результатов.SELECT    name_subject,
          Count(attempt.attempt_id) AS 'Количество',
          Round(Avg(result),2)      AS 'Среднее'
FROM      subject
LEFT JOIN attempt
ON        subject.subject_id = attempt.subject_id
GROUP BY  name_subject
ORDER BY  'Среднее' DESC;

-- Вывести студента (различных студентов), имеющих максимальные результаты попыток . Информацию отсортировать в алфавитном порядке по фамилии студента.SELECT   name_student,
         result
FROM     attempt
JOIN     student
ON       attempt.student_id = student.student_id
WHERE    result =
         (
                SELECT Max(result)
                FROM   attempt )
ORDER BY name_student
-- Если студент совершал несколько попыток по одной и той же дисциплине, то вывести разницу в днях между первой и последней попыткой.
-- Информацию вывести по возрастанию разницы. Студентов, сделавших одну попытку по дисциплине, не учитывать.SELECT     name_student,
           name_subject,
           Datediff(Max(date_attempt),Min(date_attempt) ) AS 'Интервал'
FROM       subject
INNER JOIN attempt
ON         subject.subject_id = attempt.subject_id
INNER JOIN student
ON         student.student_id = attempt.student_id
GROUP BY   name_subject,
           name_student
HAVING     Count(attempt.subject_id) > 1
ORDER BY   'Интервал' ASC
-- Студенты могут тестироваться по одной или нескольким дисциплинам (не обязательно по всем).
-- Вывести дисциплину и количество уникальных студентов, которые по ней проходили тестирование .
-- Информацию отсортировать сначала по убыванию количества, а потом по названию дисциплины.
-- В результат включить и дисциплины, тестирование по которым студенты не проходили, в этом случае указать количество студентов 0.SELECT     name_subject,
           Count(DISTINCT student_id) AS 'Количество'
FROM       attempt
RIGHT JOIN subject
ON         attempt.subject_id = subject.subject_id
GROUP BY   name_subject
ORDER BY   'Количество' DESC,
           name_subject
-- Случайным образом отберите 3 вопроса по дисциплине «Основы баз данных».SELECT   question_id ,
         name_question
FROM     question
JOIN     subject
ON       question.subject_id = subject.subject_id
WHERE    name_subject = 'Основы баз данных'
ORDER BY Rand() limit 3;

-- Вывести вопросы, которые были включены в тест для Семенова Ивана по дисциплине «Основы SQL» 2020-05-17  (значение attempt_id для этой попытки равно 7).
-- Указать, какой ответ дал студент и правильный он или нет.SELECT name_question,
       name_answer,IF (is_correct, 'Верно', 'Неверно') as 'Результат' FROM answer INNER JOIN testing ON answer.answer_id = testing.answer_id INNER JOIN question ON question.question_id = testing.question_id WHERE attempt_id = 7
-- Посчитать результаты тестирования. Результат попытки вычислить как количество правильных ответов, деленное
-- на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до двух знаков после запятой.
-- Вывести фамилию студента, название предмета, дату и результат.
-- Информацию отсортировать сначала по фамилии студента, потом по убыванию даты попытки.
SELECT     name_student,
           name_subject,
           date_attempt,
           round(sum(is_correct)/3 * 100,2) AS 'Результат'
FROM       student
INNER JOIN attempt
ON         student.student_id = attempt.student_id
INNER JOIN testing
ON         testing.attempt_id = attempt.attempt_id
INNER JOIN subject
ON         subject.subject_id = attempt.subject_id
INNER JOIN answer
ON         answer.answer_id = testing.answer_id
GROUP BY   attempt.attempt_id,
           name_subject
ORDER BY   name_student,
           date_attempt DESC
-- Для каждого вопроса вывести процент успешных решений, то есть отношение количества верных ответов к
-- общему количеству ответов, значение округлить до 2-х знаков после запятой. Также вывести название предмета,
-- к которому относится вопрос, и общее количество ответов на этот вопрос. Информацию отсортировать сначала по
-- названию дисциплины, потом по убыванию успешности, а потом по тексту вопроса в алфавитном порядке.SELECT     name_subject,
                      Concat(LEFT(name_question,30),'...')                   AS 'Вопрос',
           Count(testing.answer_id)                                          AS 'Всего_ответов',
           Round(100*( Sum(answer.is_correct) / Count(testing.answer_id)),2) AS 'Успешность'
FROM       answer
RIGHT JOIN question
ON         answer.question_id = question.question_id
INNER JOIN subject
ON         subject.subject_id = question.subject_id
JOIN       testing
ON         testing.question_id = question.question_id
AND        answer.answer_id = testing.answer_id
GROUP BY   question.question_id
ORDER BY   name_subject,
           'Успешность' DESC,
           'Вопрос' ASC
