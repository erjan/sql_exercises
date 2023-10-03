Find the best day of the month for AAPL stock trading. The best day is the one with highest positive difference between average closing price and average opening price. Output the result along with the average opening and closing prices.


with h as(
select 

extract(day from date) as day_of_month,
avg(close) as c, avg(open) as o,
avg(close)- avg(open) as diff
from aapl_historical_stock_price group by extract(day from date))


select day_of_month,c,o from h where diff > 0 order by diff desc limit 1
