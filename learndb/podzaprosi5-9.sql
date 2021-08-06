/*
Получи информацию о сотрудниках, которые кем-либо 
руководят (идентификатор сотрудника присутствует в столбце employee.manager_id). Выведи следующие столбцы:

employee_id - идентификатор сотрудника;
last_name - фамилия;
first_name - имя;
rank_id - идентификатор должности.
Отсортируй результат сначала по фамилии, затем по идентификатору сотрудника.
*/


select e1.employee_id,e1.last_name, e1.first_name, e1.rank_id 

from employee e1 
where e1.employee_id in (select manager_id from employee)

order by e1.last_name, e1.employee_id
