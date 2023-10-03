Given a table of purchases by date, calculate the month-over-month percentage change in revenue. The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.


with help as(
select 
to_char(created_at, 'YYYY-MM') as year_month,
sum(value) as value
from sf_transactions group by 1)



select

year_month,  round((value - lag(value) over(order by year_month))/lag(value) over(order by year_month)*100,2) as revenue_diff_pct

from help
