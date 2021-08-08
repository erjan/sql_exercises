/*
Сформируй статистику продаж по сотрудникам. Для выполнения задания потребуются 
таблицы purchase, purchase_item и employee.

Выведи столбцы:

employee_id - идентификатор сотрудника (purchase.employee_id).
last_name - фамилия сотрудника.
first_name - имя сотрудника.
purchase_id - идентификатор заказа.
price_purchase - сумма заказа. Равна сумме price * count по всем товарам заказа.
price_total_percent - процент суммы заказа от суммы всех заказов, оформленных 
сотрудником, округленный до целого (100 * price_purchase / price_total).
price_total - сумма всех заказов, оформленных сотрудником.
count_total - количество заказов, оформленных сотрудником.
Отсортируй результат по

Количеству заказов, оформленных сотрудником, по убыванию;
Идентификатору сотрудника;
Сумме заказа по убыванию;
Идентификатору заказа.
*/

select 
p.employee_id,
e.last_name,
e.first_name,
p.purchase_id,
x.price_purchase,
round(100* x.price_purchase/y.price_total,0) as price_total_percent,
y.price_total,
y.count_total

from ( select pi.purchase_id, sum(price*count) as price_purchase from purchase_item pi 
group by pi.purchase_id )x,

(select p2.employee_id, sum(pi2.price*pi2.count) as price_total,count(distinct pi2.purchase_id)as count_total from purchase p2 join purchase_item pi2 on p2.purchase_id = pi2.purchase_id group by p2.employee_id)y,

employee e,
purchase p
where e.employee_id = p.employee_id and x.purchase_id = p.purchase_id  and y.employee_id = e.employee_id
order by count_total desc,p.employee_id, price_total desc, purchase_id 
