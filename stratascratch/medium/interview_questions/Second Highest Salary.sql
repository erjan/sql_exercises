Find the second highest salary of employees.




select salary from (
select salary, dense_rank()over(order by salary desc) as rnk from employee order 
by rnk limit 2) k where rnk =2
