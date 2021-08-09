/*
Реши задачу из предыдущего задания, используя вместо таблицы employee подзапрос lv_employee
Для каждого сотрудника выведи количество его руководителей и их список.

В результате запроса выведи столбцы

employee_id - идентификатор сотрудника;
first_name - имя;
last_name - фамиля;
count_managers - количество руководителей над сотрудником;
managers - список руководителей (имя и фамилия, разделенные пробелом), разделенных 
через '; ' (точка с запятой + пробел). Если у сотрудника нет руководителей, выведи пустую строку. Руководители 
должны следовать в порядке их подчиненности: на персом месте - самый главный начальник, на последнем - непосредственный 
руководитель сотрудника. В начале и конце строки точки с запятой быть не должно.
Отсортируй результат так, чтобы:

подчиненные руководителя следовали сразу за строчкой с руководителем;
подчиненные одного руководителя были отсортированы сначала по имени, затем по фамилии;
сотрудники без руководителя отсортированы сначала по имени, затем по фамилии, затем по идентификатору сотрудника.

*/



WITH recursive lv_employee AS (
  SELECT e.employee_id, 
         e.first_name, 
         e.last_name, 
         e.manager_id
    FROM employee e
   UNION ALL
  SELECT e.employee_id * 1000, 
         e.first_name, 
         e.last_name, 
         e.manager_id * 1000
    FROM employee e
),
lv_hierarchy as (
   select e.employee_id,
   e.first_name, e.last_name,
   0 as count_managers,
   '' as managers,  
   array[row_number() over(order by e.first_name, e.last_name, e.employee_id)] as sort   
   from lv_employee e where e.manager_id is null
   union all
   select 
   e.employee_id,
   e.first_name, e.last_name,
   p.count_managers + 1 as count_managers,
   p.managers || '; ' || p.first_name || ' ' || p.last_name,
   p.sort || row_number() over (PARTITION BY e.manager_id ORDER BY e.first_name, e.last_name, e.employee_id) AS sort   
   from lv_employee e , lv_hierarchy p where p.employee_id = e.manager_id

)

SELECT e.employee_id,
       e.first_name,
       e.last_name,
       e.count_managers,
       trim('; ' from e.managers) AS managers
  FROM lv_hierarchy e
 ORDER BY e.sort
