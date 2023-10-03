Find departments with at more than or equal 5 employees.




select 

department, count(id)
from employee 
group by department
having count(id)>=5
