/*
На практике прием с одинаковыми значениями в ORDER BY в оконной функции используют довольно редко. 
А вот нарастающие итоги в рамках групп строк довольно часто. Давай в этом задании попробуем вместе PARTITION BY и ORDER BY в оконной функции.

Выведи доходы от покупок нарастающим итогом в порядке оформления заказов по каждому магазину в отдельности.

Выведи поля:

store_id - идентификатор магазина;
purchase_date - дата заказа;
price_purchase - полная стоимость заказа (сумма по всем позициям стоимости товара * количество товара);
price_total - полная стоимость всех заказов, оформленных с самого начала и до оформления текущего заказа (включительно) в рамках магазина.
Отсортируй результат сначала по идентификатору магазина, затем по дате заказа.
*/

SELECT p.store_id,
       p.purchase_date,
        p.price_purchase,

       sum(p.price_purchase) over (PARTITION BY p.store_id order by p.purchase_date) AS price_total
       
  FROM (SELECT p.purchase_id,
               p.store_id,
               p.purchase_date,
               sum (pi.count * pi.price) AS price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.purchase_id
       ) p
  LEFT JOIN
       purchase p2
    ON p2.purchase_id= p.purchase_id
 ORDER BY p.store_id NULLS LAST, p2.purchase_date NULLS LAST
