--Write a query to find the top 3 film categories that generated the most sales.
--The order of your results doesn't matter.



SELECT category
FROM sales_by_film_category
order by total_sales desc limit 3;

    
