/*
Построй иерархию подчиненности сотрудников из таблицы employee.

В результате запроса выведи столбцы

employee_id - идентификатор сотрудника;
full_name - имя и фамилия сотрудника, разделенные пробелом. Слева добавь 8 пробелов на каждый 
уровень вложенности. Перед ФИО сотрудника, которым никто не руководит, пробелов быть не должно.
is_manager - признак, что у сотрудника есть подчиненные (булево значение): TRUE - есть подчиненные, FALSE - нет подчиненных.
Отсортируй результат так, чтобы:

подчиненные руководителя следовали сразу за строчкой с руководителем;
подчиненные одного руководителя были отсортированы сначала по 
имени, затем по фамилии;
сотрудники без руководителя отсортированы сначала по имени, затем по фамилии, затем по идентификатору сотрудника.
*/

WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         array[row_number() over (ORDER BY e.first_name, e.last_name, e.employee_id)] AS sort
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.sort || row_number() over (PARTITION BY e.manager_id ORDER BY e.first_name, e.last_name, e.employee_id) AS sort
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT e.employee_id,
       lpad('', 8 * e.count_managers, ' ') || e.first_name || ' ' || e.last_name AS full_name,
       exists (
          SELECT 1
            FROM employee ch
           WHERE ch.manager_id = e.employee_id
       ) AS is_manager
  FROM lv_hierarchy e
 ORDER BY e.sort
