-- В таблицу attempt включить новую попытку для студента Баранова Павла по 
-- дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.
INSERT INTO attempt
VALUES     (8,
            1,
            2,
            Now(),
            NULL);

-- Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой 
-- собирается проходить студент, занесенный в таблицу attempt 
-- последним, и добавить их в таблицу testing.id последней попытки получить как максимальное значение id из таблицы attempt.

INSERT INTO testing
            (attempt_id,
             question_id)
SELECT attempt_id,
       question_id
FROM   question
       JOIN attempt USING (subject_id)
WHERE  attempt_id = (SELECT Max(attempt_id)
                     FROM   attempt)
ORDER  BY Rand()
LIMIT  3;

SELECT *
FROM   testing;

-- Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее 
-- необходимо вычислить результат(запрос) и занести его в таблицу attempt для соответствующей попытки.  Результат попытки вычислить как количество 
-- правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до целого.
UPDATE attempt
SET    result = (SELECT Round(Sum(is_correct) / 3 * 100) AS result
                 FROM   testing
                        INNER JOIN answer
                                ON testing.answer_id = answer.answer_id
                 WHERE  attempt_id = 8)
WHERE  attempt_id = 8;

SELECT *
FROM   attempt;

-- Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы из таблицы testing.
DELETE FROM attempt
WHERE  date_attempt < '2020-05-01';

SELECT *
FROM   attempt;

SELECT *
FROM   testing; 
