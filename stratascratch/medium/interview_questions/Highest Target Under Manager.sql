Find the highest target achieved by the employee or employees who works under the manager id 13. Output the first name of the employee and target achieved. The solution should show the highest target achieved under manager_id=13 and which employee(s) achieved it.

with m13 as(
select 

*
from salesforce_employees m where m.manager_id = 13)


select  first_name, target from m13 where target = (select max(target) from m13)
