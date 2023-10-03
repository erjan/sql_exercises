Calculate the sales revenue for the year 2021.



select sum(order_total) from amazon_sales
where to_char(order_date, 'YYYY') = '2021'
