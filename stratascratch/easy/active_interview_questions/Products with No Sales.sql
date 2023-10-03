Write a query to get a list of products that have not had any sales. Output the ID and market name of these products.

select 

d.prod_sku_id,
market_name
from dim_product d where d.prod_sku_id not  in(select prod_sku_id from fct_customer_sales)

