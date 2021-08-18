Write a query to return the top 5 customer ids and their rankings based on their spend for each store.
The order of your results doesn't matter.
If there are ties, return just one of them.


-- my solution

with helper as (

select customer.customer_id, store_id, sum(amount) as revenue from payment 

inner join customer on 

payment.customer_id = customer.customer_id

group by store_id, customer.customer_id),




helper2 as (
select store_id, customer_id,revenue, dense_rank() over(partition by store_id order by revenue desc) as ranking from helper)


select store_id, customer_id, revenue, ranking from helper2
where ranking <=5



-- official solution


WITH cust_revenue AS (
  SELECT 
    C.customer_id, 
    MAX(store_id) store_id,
    SUM(amount) revenue
  FROM customer C
  INNER JOIN payment P
  ON P.customer_id = C.customer_id
  GROUP BY C.customer_id
)
SELECT * FROM (
  SELECT 
    store_id,
    customer_id,
    revenue,
    DENSE_RANK() OVER(PARTITION BY store_id ORDER BY revenue DESC) ranking
  FROM cust_revenue
) X
WHERE ranking <= 5;
