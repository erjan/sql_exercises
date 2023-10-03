Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased. Do not include returns which are represented by negative purchase values. Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.


A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current month and previous two months. The first two months will not be a true 3-month rolling average since we are not given data from last year. Assume each month has at least one purchase.



with h as(
select *,
to_char(created_at, 'YYYY-MM') as ym from amazon_purchases where purchase_amt > 0),

h2 as(
select 
ym,
sum(purchase_amt) as total
from h
group by ym
having count(*)>=1
order by ym)

select 
ym,
avg(total)OVER(ORDER BY ym ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) as rol_avg
from h2
