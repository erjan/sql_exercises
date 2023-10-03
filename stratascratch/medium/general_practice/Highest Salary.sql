Find the worker who earns the highest salary. Output the worker's first name along with the salary.




select first_name , max(salary) from worker 
group by first_name
