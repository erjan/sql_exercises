


Write a query to identify customers who placed more than three transactions each in both 2019 and 2020.


#my own solution:

with h as(

select  t.id as transaction_id ,
user_id, name, date_format(created_at, '%Y')as year

from transactions t inner join users u on u.id = t.user_id
where  date_format(created_at, '%Y') in (2019,2020)  ),



h2 as(

select 
user_id, year
from h 
group by year, user_id
having count(transaction_id)>3 )

select name as customer_name from users where users.id in (select user_id from h2)



--------------------
#official

WITH transaction_counts AS (
SELECT u.id, 
name,
SUM(CASE WHEN YEAR(t.created_at)= '2019' THEN 1 ELSE 0 END) AS t_2019,
SUM(CASE WHEN YEAR(t.created_at)= '2020' THEN 1 ELSE 0 END) AS t_2020
FROM transactions t
JOIN users u
ON u.id = user_id
GROUP BY 1
HAVING t_2019 > 3 AND t_2020 > 3)

SELECT tc.name AS customer_name
FROM transaction_counts tc
