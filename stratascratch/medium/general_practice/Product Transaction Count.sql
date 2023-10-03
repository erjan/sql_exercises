Find the number of transactions that occurred for each product. Output the product name along with the corresponding number of transactions and order records by the product id in ascending order. You can ignore products without transactions.


select 
product_name, 
count(case when transaction_id is not null then 1 else 0 end) as c

from excel_sql_inventory_data es inner join excel_sql_transaction_data
 et on es.product_id = et.product_id
 
 group by product_name
