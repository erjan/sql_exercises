Write a query to find the Market Share at the Product Brand level for each Territory, for Time Period Q4-2021. Market Share is the number of Products of a certain Product Brand brand sold in a territory, divided by the total number of Products sold in this Territory.
Output the ID of the Territory, name of the Product Brand and the corresponding Market Share in percentages. Only include these Product Brands that had at least one sale in a given territory.



with h as(
select 

territory_id,prod_brand,
count(*) as n_sales

from fct_customer_sales f1 inner join map_customer_territory f2 on f2.cust_id = f1.cust_id
 inner join dim_product f3 on f3.prod_sku_id = f1.prod_sku_id

where extract(quarter from order_date) = 4 and extract(year from order_date) = 2021

group by territory_id,prod_brand)

select territory_id,prod_brand,
c * 100 from h
