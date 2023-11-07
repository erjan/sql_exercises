'''
The sales department is conducting a performance review and is interested in trends in product sales. They have decided to use a weighted moving average as part of their analysis.

Write a SQL query to calculate the 3-day weighted moving average of sales for each product. Use the weights 0.5 for the current day, 0.3 for the previous day, and 0.2 for the day before that.

Note: Only output the weighted moving average for dates that have two or more preceding dates. You may assume that the table doesn’t skip dates.
'''

with h as(
SELECT 
date,product_id,
sales_volume,
lag(sales_volume,1)over(partition by product_id order by date) as day1,
lag(sales_volume,2)over(partition by product_id order by date) as day2 FROM sales )

  select date,product_id, 0.5*sales_volume + 0.3*day1 + 0.2*day2 
as weighted_avg_sales
from h
where day1 is not null and day2 is not null
