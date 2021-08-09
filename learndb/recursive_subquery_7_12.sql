/*
Для каждого сотрудника выведи количество его руководителей и их список.

В результате запроса выведи столбцы

employee_id - идентификатор сотрудника;
first_name - имя;
last_name - фамиля;
count_managers - количество руководителей над сотрудником;
managers - список руководителей (имя и фамилия, 
разделенные пробелом), разделенных через '; ' (точка с запятой + пробел). Если у
сотрудника нет руководителей, выведи пустую строку. Руководители должны следовать в порядке их 
подчиненности: на первом месте - самый главный начальник, на последнем - непосредственный руководитель сотрудника. В начале и конце 
строки точки с запятой быть не должно.
Сортировать результат не нужно.
*/

WITH RECURSIVE lv_hierarchy AS (
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         0 AS count_managers,
         '' as managers
    FROM employee e
  WHERE e.manager_id IS NULL

   UNION ALL
  
  SELECT e.employee_id,
         e.first_name,
         e.last_name,
         p.count_managers + 1 AS count_managers,
         p.managers || '; ' || p.first_name || ' ' || p.last_name
    FROM lv_hierarchy p,
         employee e
   where e.manager_id = p.employee_id
)
SELECT 
l.employee_id, l.first_name, l.last_name,
l.count_managers,
trim('; ' from l.managers) as managers

  FROM lv_hierarchy l
 
