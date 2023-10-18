

'''

  Let’s say we have a table representing a company payroll schema.

Due to an ETL error, the employees table instead of updating the salaries every year when doing compensation adjustments, did an insert instead. The head of HR still needs the current salary of each employee.

Write a query to get the current salary for each employee.

Note: Assume no duplicate combination of first and last names (I.E. No two John Smiths). Assume the INSERT operation works with ID autoincrement.
  '''

WITH H AS(
select 

first_name, last_name, max(id)  as id
 from employees 
 
 group by first_name, last_name)


 select h.first_name,h.last_name, e.salary  
 from h inner join employees e on h.id  = e.id

