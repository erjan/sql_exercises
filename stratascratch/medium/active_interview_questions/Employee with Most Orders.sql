What is the last name of the employee or employees who are responsible for the most orders?




select last_name from (
select 

id,
first_name,
last_name,count(*)as c,
rank()over(order by count(*) desc) as rnk

from shopify_orders so inner join shopify_employees se on so.resp_employee_id = se.id
group by id,
first_name, last_name) k where rnk = 1
