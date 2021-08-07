/*
Составь рейтинг магазинов с самым маленьким количеством сотрудников.

Выведи поля:

store_id - идентификатор магазина.
name - название магазина.
count_employees - количество сотрудников, работающих в магазине.
position - номер магазина в рейтинге. Магазин с минимальным 
количеством сотрудников занимает 1-ю позицию. Магазины с одинаковым 
количеством сотрудников занимаю одинаковую позицию. Пропусков в позициях быть не должно.
Выведи магазины, занимающие с 1-й по 3-ю позиции в рейтинге.

Отсортируй результат сначала по позиции в рейтинге, затем по названию магазина.
*/


SELECT *
  FROM (SELECT s.store_id,
  s.name,
  count(e.*) as count_employees,
               dense_rank () over (order by count(e.*)) AS position
          FROM employee e,
               store s
         WHERE s.store_id = e.store_id 
         GROUP BY s.store_id
       --  HAVING min (pi.price) > 22000
       ) p
 WHERE p.position <= 3
 ORDER BY p.position, name
