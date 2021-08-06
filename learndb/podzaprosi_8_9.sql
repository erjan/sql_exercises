/*
Получи информацию о сотрудниках, которые кем-либо 
руководят (идентификатор сотрудника присутствует в столбце employee.manager_id). Выведи следующие столбцы:

employee_id - идентификатор сотрудника;
last_name - фамилия;
first_name - имя;
rank_id - идентификатор должности.
Отсортируй результат сначала по фамилии, затем по идентификатору сотрудника.

P.S. Да-да, такое задание уже было :) Но теперь воспользуйся EXISTS.
*/

SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
  
 WHERE exists (SELECT 1 FROM employee m where e.employee_id = m.manager_id)
 ORDER BY e.last_name, e.employee_id
