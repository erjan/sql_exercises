The CMO is interested in understanding how the sales of different product families are affected by promotional campaigns. To do so, for each product family, show the total number of units sold, as well as the percentage of units sold that had a valid promotion among total units sold. If there are NULLS in the result, replace them with zeroes. Promotion is valid if it's not empty and it's contained inside promotions table.


with h as(
select 

product_family,
coalesce(sum(units_sold),0) as total_sold,

coalesce(coalesce(sum(units_sold)filter(where f3.promotion_id is not null),0)/sum(units_sold)*100 ,0) as perc_rate


from facebook_products f1
left join facebook_sales f2 on f1.product_id = f2.product_id left join facebook_sales_promotions f3 on f2.promotion_id = f3.promotion_id

group by product_family)


select * from h
