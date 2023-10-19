with pair as(





'''
  Let’s say we have two tables, transactions and products. Hypothetically the transactions table consists of over a billion rows of purchases bought by users.

We are trying to find paired products that are often purchased together by the same user, such as wine and bottle openers, chips and beer, etc..

Write a query to find the top five paired products and their names.

Notes: For the purposes of satisfying the test case, p2 should be the item that comes first in the alphabet. The qty column represents paired products count
  '''
  
select  
t1.product_id as prod1_id, 
t2.product_id as prod2_id, 
count(*) as x

from transactions t1 inner join transactions t2
 on t1.product_id < t2.product_id and t1.created_at = t2.created_at
and t1.user_id = t2.user_id
group by t1.product_id, t2.product_id
)


select 

least(p.name, p2.name) as p1,
greatest(p.name, p2.name) as p2, x as qty
from pair pp
join products p on pp.prod1_id = p.id
join products p2 on pp.prod2_id = p2.id
group by p1, p2
order by qty desc limit 5



