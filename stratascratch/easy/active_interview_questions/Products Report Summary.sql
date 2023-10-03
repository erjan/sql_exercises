Find the number of unique transactions and total sales for each of the product categories in 2017. Output the product categories, number of transactions, and total sales in descending order. The sales column represents the total cost the customer paid for the product so no additional calculations need to be done on the column.
Only include product categories that have products sold.


select 

product_category,
count(distinct transaction_id),
sum(sales)

from wfm_transactions w1 inner join wfm_products w2 on w1.product_id = w2.product_id
where extract(year from transaction_date) = 2017
and sales <>0

group by product_category
