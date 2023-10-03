Write a query to return all Customers (cust_id) who are violating primary key constraints in the Customer Dimension (dim_customer) i.e. those Customers who are present more than once in the Customer Dimension.
For example if cust_id 'C123' is present thrice then the query should return 'C123' | '3' as output.


select 
cust_id,
count(  cust_id)
from dim_customer group by cust_id
having count(cust_id)>1;
