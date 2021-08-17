-- Write a query to return the name of the store and its manager, that generated the most sales.

SELECT store, manager
FROM sales_by_store
ORDER BY total_sales DESC
LIMIT 1;

    
