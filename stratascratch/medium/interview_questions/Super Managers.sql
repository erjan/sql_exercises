Find managers with at least 7 direct reporting employees. In situations where user is reporting to himself/herself, count that also.
Output first names of managers.


select first_name from employee e3 where e3.id in (

select 
e1.manager_id

from employee e1 join employee e2 on e1.manager_id = e2.id
group by e1.manager_id
having count(e2.id)>=7)
