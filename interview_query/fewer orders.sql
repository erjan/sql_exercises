'''
Write a query to identify the names of users who placed less than 3 orders or ordered less than $500 worth of product.
'''


with h as(
select 
u.id,
count(ifnull(t.id,0)) as num_order,
sum(quantity*price) as total_spent

from transactions t left join users u on t.user_id=u.id
left join products p on p.id = t.product_id
group by u.id)

select u.name as users_less_than from h join users u on u.id = h.id 
where total_spent<500 or num_order<3


----------------------------------------------------------------------------
SELECT DISTINCT(user_name) users_less_than FROM 
(
  SELECT u.name user_name, COUNT(t.id) tx_count, SUM(quantity*price) total_prod_worth FROM users u
  LEFT JOIN transactions t ON u.id = t.user_id
  LEFT JOIN products p ON t.product_id = p.id
  GROUP BY 1
) sub
WHERE tx_count<3 OR total_prod_worth < 500;
