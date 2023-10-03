
WFM would like to segment the customers in each of their store brands into Low, Medium, and High segmentation. The segments are to be based on a customer's average basket size which is defined as (total sales / count of transactions), per customer.


The segment thresholds are as follows:



If average basket size is more than $30, then Segment is “High”.

If average basket size is between $20 and $30, then Segment is “Medium”.

If average basket size is less than $20, then Segment is “Low”.


Summarize the number of unique customers, the total number of transactions, total sales, and average basket size, grouped by store brand and segment for 2017.


Your output should include the brand, segment, number of customers, total transactions, total sales, and average basket size.


with h as(
select 
store_brand as brand,
customer_id,
count(distinct transaction_id) as total_transactions,
sum(sales) as total_sales,
sum(sales)/count(transaction_id) as avg_basket_size
from wfm_transactions t
join wfm_stores s
on t.store_id = s.store_id
where EXTRACT(YEAR from transaction_date) = 2017
group by store_brand,2
order by 2 asc),

h2 as(
select *, 
case when avg_basket_size > 30 THEN 'High'
     when avg_basket_size BETWEEN 20 AND 30 THEN 'Medium'
     ELSE 'Low' END as segment

from h)


select 

brand,segment, 
count(customer_id),
sum(total_transactions) as total_transactions,
sum(total_sales) as total_sales,
sum(total_sales)/sum(total_transactions) as avg_basket_size

from h2 group by brand,segment


