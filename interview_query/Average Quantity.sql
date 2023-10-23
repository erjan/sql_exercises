'''
Given a table of transactions, write a query to find the average quantity of each product purchased per transaction each year.

The output should include the year, product_id, and average quantity of the product purchased per transaction that year. The output table should be sorted by year and product_id in ascending order. The value for avg_quantity should be rounded to two decimal places.
'''

select 
round(avg(quantity),2) as avg_quantity,
product_id,
year(created_at) as year

 from transactions

group by year(created_at), product_id

order by year(created_at), product_id
