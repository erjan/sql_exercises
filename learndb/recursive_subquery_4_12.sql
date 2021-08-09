/*
Сгенерируй числа от -10 до 10 рекурсивным подзапросом.

В результате должна получиться таблица с одним столбцом num.

Результат отсортируй по возрастанию числа num.
*/

WITH RECURSIVE lv_recursive (num) as (
  -- Нерекурсивная часть
  SELECT -10 AS num
    
    UNION ALL

  -- Рекурсивная часть
  SELECT p.num + 1
    FROM lv_recursive p
   WHERE p.num < 10
)
select * from lv_recursive
