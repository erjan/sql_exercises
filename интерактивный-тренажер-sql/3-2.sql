-- В таблицу attempt включить новую попытку для студента Баранова Павла по 
-- дисциплине «Основы баз данных». Установить текущую дату в качестве даты выполнения попытки.

insert into attempt VALUES(8,1,2, NOW(), NULL);

-- Случайным образом выбрать три вопроса (запрос) по дисциплине, тестирование по которой 
-- собирается проходить студент, занесенный в таблицу attempt 
-- последним, и добавить их в таблицу testing.id последней попытки получить как максимальное значение id из таблицы attempt.
INSERT INTO testing (attempt_id, question_id)
SELECT attempt_id, question_id
FROM question JOIN attempt USING (subject_id)
WHERE attempt_id = (SELECT MAX(attempt_id) FROM attempt)
ORDER BY RAND()
LIMIT 3;

SELECT * FROM testing;

-- Студент прошел тестирование (то есть все его ответы занесены в таблицу testing), далее 
-- необходимо вычислить результат(запрос) и занести его в таблицу attempt для соответствующей попытки.  Результат попытки вычислить как количество 
-- правильных ответов, деленное на 3 (количество вопросов в каждой попытке) и умноженное на 100. Результат округлить до целого.


update attempt 
set result = 
(select round(sum(is_correct)/3 * 100) as result 
from testing inner join answer on testing.answer_id = answer.answer_id where attempt_id = 8)
where attempt_id = 8;

select * from attempt;


-- Удалить из таблицы attempt все попытки, выполненные раньше 1 мая 2020 года. Также удалить и все соответствующие этим попыткам вопросы из таблицы testing.

delete from attempt
where date_attempt < '2020-05-01';
select * from attempt;
select * from testing;
