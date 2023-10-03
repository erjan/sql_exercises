Write a query to return Territory and corresponding Sales Growth. Compare growth between periods Q4-2021 vs Q3-2021.
If Territory (say T123) has Sales worth $100 in Q3-2021 and Sales worth $110 in Q4-2021, then the Sales Growth will be 10% [ i.e. = ((110 - 100)/100) * 100 ]
Output the ID of the Territory and the Sales Growth. Only output these territories that had any sales in both quarters.



with h as(
select 

m.territory_id as td,
extract(quarter from order_date) as q,
*


from fct_customer_sales f1
inner join map_customer_territory m on m.cust_id = f1.cust_id

where extract(quarter from order_date) in (3,4) and extract(year from order_date) =2021),

h2 as(
select td, q, sum(order_value) as total

from h group by td, q)


select hx.td,

((hy.total-hx.total  )/hx.total) * 100 as sales_growth
from h2  hy join h2 hx on hy.td = hx.td where hy.q >  hx.q

