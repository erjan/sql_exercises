'''
Let’s say you work at Costco. Costco has a database with two tables. The first is users composed of user
  information, including their registration date, and the second is purchases that has the entire item purchase history (if any) for those users.

Write a query to get the total amount spent on each item in the ‘purchases’ table by users that registered in 2022.
'''

SELECT 

item, sum(price) as total_amount_spent

 FROM users u join purchases p on u.user_id = p.user_id

 where year(registration_date)=2022
 group by item
