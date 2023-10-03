Each Employee is assigned one territory and is responsible for the Customers from this territory. There may be multiple employees assigned to the same territory.
Write a query to get the Employees who are responsible for the maximum number of Customers. Output the Employee ID and the number of Customers.


select empl_id, n_customers from (
select 

m1.empl_id, count(cust_id) as n_customers, rank()over(order by count(cust_id) desc) as rnk

from map_employee_territory m1 inner join map_customer_territory m2 
on m1.territory_id = m2.territory_id

group by m1.empl_id) k where rnk = 1
