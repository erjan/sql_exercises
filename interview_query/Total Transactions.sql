Write a query to get the cost of all transactions by user ordered by total cost descending.



with h as(
SELECT 
u.name,
u.id as user,
round(sum(quantity*price),2) as total_cost

FROM 
transactions t 
left join products p on t.product_id = p.id
inner join users u 
 on u.id = t.user_id

 group by u.id)


 select name, total_cost,user as user_id from h order by total_cost desc
 
