/*
Построй три набора данных: c 101 до 110, с 201 до 215, с 301 до 320.

В результате выведи один столбец - result_number.

Отсортируй результат по result_number по возрастанию.
*/

WITH RECURSIVE lv_initial AS (
    SELECT 101 AS start_number,
           10 AS count_iterations
     UNION ALL
    SELECT 201 AS start_number,
           15 AS count_iterations
     UNION ALL
    SELECT 301 as start_number, 20 as count_iterations
), 
lv_numbers (start_number, count_iterations, current_iteration, result_number) AS (
    SELECT start_number,
           count_iterations,
           1 AS current_iteration,
           start_number AS result_number
      FROM lv_initial
     UNION ALL
    SELECT p.start_number,
           p.count_iterations,
           p.current_iteration + 1,
           p.result_number + 1
      FROM lv_numbers p
     WHERE p.current_iteration < p.count_iterations
)
SELECT 
       n.result_number
  FROM lv_numbers n
 ORDER BY n.start_number,
          n.result_number
