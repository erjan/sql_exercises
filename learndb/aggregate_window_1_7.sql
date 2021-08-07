/*
Продолжи анализировать цены на товары. К последнему запросу из теории добавь еще 
максимальную цену в рамках категории товаров и максимальную цену в рамках категории товаров конкретного магазина.

Выведи столбцы:

store_id - идентификатор магазина.
product_id - идентификатор товара.
category_id - идентификатор категории товаров.
price - цена на этот товар в этом магазине.
max_price_product - максимальная цена на этот товар по всем магазинам.
max_price_in_store - максимальная цена на какой-либо товар в этом магазине.
max_price_in_category - максимальная цена на какой-либо товар в этой категории товаров.
max_price_in_category_and_store - максимальная цена на любой товар в этой категории товаров и этом магазине.
max_price_total - максимальная цена на какой-либо товар в любой категории и любом магазине.
Отсортируй результат сначала по category_id, затем по price, затем по product_id.
*/


select store.store_id, product.product_id, category.category_id, price,

max(price) over(partition by product.product_id) as max_price_product,
max(price) over(partition by store.store_id) as max_price_in_store,
max(price) over(partition by category.category_id) as max_price_in_category,
max(price) over(partition by category.category_id, store.store_id) as max_price_in_category_and_store,
max(price) over() max_price_total


from store join product_price on store.store_id = product_price.store_id
join product on product_price.product_id = product.product_id
join category on category.category_id = product.category_id
order by category.category_id, price, product.product_id
