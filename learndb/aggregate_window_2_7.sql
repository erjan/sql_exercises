/*
Получи информацию из таблицы purchase_item, добавив немного статистики.

Выведи столбцы

purchase_id - идентификатор заказа;
product_id - идентификатор товара;
total_price - полная стоимость за товар (количество * цена за штуку);
total_price_min - минимальная полная стоимость за товар в рамках заказа;
total_price_max - максимальная полная стоимость за товар в рамках заказа;
total_price_avg - средняя полная стоимость за товар в рамках заказа;
count_products - количество уникальных позиций в заказе;
purchase_price - полная стоимость заказа.
Отсортируй результат сначала по идентификатору покупки, затем по идентификатору товара.
*/

select
purchase_id,product_id,
price*count as total_price,

min(price*count) over(partition by purchase_id) as total_price_min,

max(price*count) over(partition by purchase_id) as total_price_max,

avg(price*count) over(partition by purchase_id) as total_price_avg,
count(product_id) over(partition by purchase_id) as count_products,
sum(price*count) over(partition by purchase_id)as  purchase_price

from purchase_item
order by purchase_id, product_id
