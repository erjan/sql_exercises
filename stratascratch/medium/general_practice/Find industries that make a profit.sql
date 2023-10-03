Find all industries with a positive average profit. For those industries extract their lowest sale.
Output the industry along with the corresponding lowest sale and average profit.
Sort the output based on the lowest sales in ascending order.



select 

industry,
avg(profits), min(sales) as low_sale

from forbes_global_2010_2014
group by industry
having avg(profits)>0
order by low_sale asc
