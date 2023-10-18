Given a employees and departments table, select the top 3 departments 

  with at least ten employees and rank them according to the percentage of their employees making over 100K in salary.



with big as(
select d.id , d.name as department_name, count(e.id) as num_workers
from departments d 
join employees e on d.id =
 e.department_id

 group by d.id, d.name

 having count(e.id)>=10)


 select department_name, num_workers as number_of_employees,
 sum(case when salary>100000 then 1 else 0 end )/num_workers as percentage_over_100k
 

 from employees e join big on e.department_id = big.id
 group by department_name, num_workers
