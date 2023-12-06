'''
An electronics retail company tracks its sales and wants to run a performance analysis. They’re hoping to categorize sales into different groups, based on the amount of sales and the region where the sale occurred. The conditions for categorization are:

Standard Sales: Any sales below 2000 are considered standard, except if they occur in the East region, or in the month of July.
Premium Sales: Any sales that are over or equal to 2000, or any sales in the East region (regardless of the amount), are considered premium, except again during the month of July.
Promotional Sales: All sales made in the promotional period of July, regardless of the amount or region, are considered promotional.
The company wants a report that sums these amounts by region to help with financial planning and bonus allocations.

Note: You may assume that table contains data only for 2023
'''

with categorized as(
select 
*,
case when region != 'East' and month(sale_date)!=7 and sale_amount <2000 then 'std'
when sale_amount >=2000 or region ='East' and month(sale_date) != 7 then 'prem'
when month(sale_date) = 7 then 'prom' else null end as category

from sales)


select region, sum(sale_amount) as total_sales,
 sum(case when category = 'std' then sale_amount else 0 end) as standard_sales,
 sum(case when category = 'prem' then sale_amount else 0 end) as premium_sales,
 sum(case when category = 'prom' then sale_amount else 0 end) as promotional_sales
 
  from categorized  group by region
