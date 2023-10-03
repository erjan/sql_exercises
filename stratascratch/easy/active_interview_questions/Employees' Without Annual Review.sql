Return all employees who have never had an annual review. Your output should include the employee's first name, last name, hiring date, and termination date. List the most recently hired employees first.


select 

first_name, last_name, hire_date, termination_date

from uber_employees u1 where u1.id not in (select emp_id from uber_annual_review)

order by hire_date desc

