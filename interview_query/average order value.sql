'''
Given three tables, representing customer transactions and customer attributes:

Write a query to get the average order value by gender.

Note: We’re looking at the average order value by users that have ever placed an order. Additionally, please round your answer to two decimal places.
'''

select 

round(avg(quantity*price),2) as aov,sex

 from transactions t inner join users u on u.id = t.user_id inner 
 join products 
 p on p.id = t.product_id

 group by sex
