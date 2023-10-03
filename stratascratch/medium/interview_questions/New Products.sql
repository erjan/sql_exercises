You are given a table of product launches by company by year. Write a query to count the net difference between the number of products companies launched in 2020 with the number of products companies launched in the previous year. Output the name of the companies and a net difference of net products released for 2020 compared to the previous year.


with y2020 as(
select company_name, count(product_name) as net_products from car_launches

where year = 2020
group by company_name),

y2019 as(
select company_name, count(product_name)as net_products from car_launches

where year = 2019
group by company_name)


select y1.company_name, (y2.net_products - y1.net_products) as net_products

from y2019 y1  join y2020 y2 on y1.company_name = y2.company_name
