Summarize the number of customers and transactions for each month in 2017, filtering out transactions that were less than $5.



with h as(
select 
transaction_id,
transaction_date,
customer_id, 
sum(sales)
from wfm_transactions where extract(year from transaction_date) = 2017
group by transaction_date,customer_id, transaction_id 
having sum(sales)>=5)

select extract(month from transaction_date) as month,
count(distinct customer_id) as customers,
count(transaction_id) as transactions
from h
group by 1

