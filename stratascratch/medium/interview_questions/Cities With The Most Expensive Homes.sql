Write a query that identifies cities with higher than average home prices when compared to the national average. Output the city names.


with nat_avg as(
select avg(mkt_price) from zillow_transactions),



h2 as(

select city, avg(mkt_price) from zillow_transactions
group by city
having avg(mkt_price) > ( select * from nat_avg) )

select city from h2
