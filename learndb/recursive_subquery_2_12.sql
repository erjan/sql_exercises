/*
Найди сотрудников, которые продали меньше, чем среднестатистический сотрудник.

Будем считать, что среднестатистический сотрудник продал на сумму, равную среднему значению 
от суммы продаж каждого сотрудника. Например, если в системе три сотрудника и они продали на 
суммы 100, 100 и 400 соответственно, то среднестатистический сотрудник продал на сумму (100 + 100 + 400) / 3 = 200.

Сумма продаж сотрудника определяется как сумма произведения стоимости товара на количество по всем заказам, которые оформил сотрудник.

Сотрудников, которые не сделали ни одной продажи, в расчет не берем.

Выведи информацию по каждому сотруднику:

employee_id - идентификатор сотрудника;
last_name - фамилия сотрудника;
first_name - имя сотрудника;
sum_purchases - сумма продаж сотрудника.
Отсортируй результат сначала по сумме продаж менеджера, затем по идентификатору сотрудника.
*/


with s1 as (
select 
count(purchase_item.count),
sum(price*count) as sum from purchase_item join purchase on purchase_item.purchase_id = purchase.purchase_id group by purchase.employee_id ),

s2 as ( select round(avg(sum),2) from s1 )

select purchase.employee_id, last_name, first_name,
sum(price*count) as sum_purchases from purchase_item join purchase on purchase_item.purchase_id = purchase.purchase_id join employee e on e.employee_id = purchase.employee_id group by purchase.employee_id,last_name, first_name
having sum(price*count) < (select * from s2)
order by sum_purchases , purchase.employee_id



