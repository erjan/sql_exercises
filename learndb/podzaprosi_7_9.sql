/*
Получи информацию о сотрудниках, которые никем не 
руководят (идентификатор сотрудника отсутствует в столбце employee.manager_id). Выведи следующие столбцы:

employee_id - идентификатор сотрудника;
last_name - фамилия;
first_name - имя;
rank_id - идентификатор должности.
Отсортируй результат сначала по фамилии, затем по идентификатору сотрудника.
*/


SELECT e.employee_id,
       e.last_name,
       e.first_name,
       e.rank_id
  FROM employee e
 WHERE e.employee_id NOT IN (SELECT e2.manager_id
                              FROM employee e2  where e2.manager_id is not null)
                              
order by e.last_name, e.employee_id                              
