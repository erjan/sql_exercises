Find the best selling item for each month (no need to separate months by year) where the biggest total invoice was paid. The best selling item is calculated using the formula (unitprice * quantity). Output the description of the item along with the amount paid.


with h as(
select 

*,
extract(month from invoicedate) as month

from online_retail),

 h2 as(
select 

month,description,
sum(unitprice*quantity) as total_paid, 
rank()over(partition by month order by sum(unitprice*quantity) desc) as rnk
from h group by month, description
order by rnk)

select month, description, total_paid from h2 where rnk = 1

