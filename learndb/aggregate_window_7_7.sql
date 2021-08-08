/*
Найди товар, который чаще всего встречается в заказах (purchase_item). Выведи информацию о нем:

product_id - идентификатор товара;
name - название;
description - описание.
*/

-- stupid solution
 with k as (
select mode()  within group (order by purchase_item.product_id) as product_id
from purchase_item 
) 

select purchase_item.product_id,
name,
description

from purchase_item join product on purchase_item.product_id = product.product_id
where purchase_item.product_id = ( select product_id from k  ) limit 1


-- SELECT mode() WITHIN GROUP (ORDER BY e.manager_id) FROM employee e

