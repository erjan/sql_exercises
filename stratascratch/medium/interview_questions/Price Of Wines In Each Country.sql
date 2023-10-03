Find the minimum, average, and maximum price of all wines per country. Assume all wines listed across both datasets are unique. Output the country name along with the corresponding minimum, maximum, and average prices.

select country, min(price), avg(price) , max(price) from (
select price, country from winemag_p1
union all
select price, country from winemag_p2)tmp where tmp.price is not null and country is not null

group by country
