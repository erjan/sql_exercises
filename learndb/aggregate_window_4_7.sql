/*
Выведи доходы от покупок по всем магазинам нарастающим итогом в порядке оформления заказов.

Выведи поля

purchase_id - идентификатор заказа;
purchase_date - дата заказа;
price_purchase - полная стоимость заказа (сумма по всем позициям стоимости товара * количество товара);
price_total - полная стоимость всех заказов, оформленных с самого начала и до оформления текущего заказа (включительно).
Отсортируй результат по дате заказа.
*/

SELECT p.purchase_id,
       p.purchase_date,
       p.price_purchase,
 sum(p.price_purchase) over (order by p.purchase_date) AS price_total
  FROM (SELECT p.purchase_id,
               p.employee_id,
               p.purchase_date,
               sum (pi.count * pi.price) AS price_purchase
          FROM purchase p,
               purchase_item pi
         WHERE pi.purchase_id = p.purchase_id
         GROUP BY p.purchase_id,
                  p.employee_id
       ) p
       
       order by p.purchase_date
