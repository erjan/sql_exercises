/*
Проанализируй суммы продаж сотрудников.

Определи двух человек с самой низкой суммой продаж и двух человек с самой высокой суммой продаж.

Сумма продаж сотрудника определяется как сумма произведения стоимости товара на 
количество по всем заказам, которые оформил сотрудник.

По этим сотрудникам выведи информацию:

employee_id - идентификатор сотрудника;
last_name - фамилия сотрудника;
first_name - имя сотрудника;
sum_purchases - сумма продаж сотрудника;
action - строка, принимающая одно из двух значений: 'Уволить' или 'Повысить'. Для двух сотрудников с 
худшими показателями отображается 'Уволить'. Для сотрудников с лучшими показателями - 'Повысить'.
Отсортируй результат сначала по сумме продаж, затем по идентификатору сотрудника.
*/

with top2 as (
select purchase.employee_id, sum(price*count)  as sum_purchases from purchase_item join purchase on purchase_item.purchase_id = purchase.purchase_id
group by purchase.employee_id
order by sum_purchases desc limit 2),

bottom2 as (
select purchase.employee_id, sum(price*count)  as sum_purchases from purchase_item join purchase on purchase_item.purchase_id = purchase.purchase_id
group by purchase.employee_id
order by sum_purchases asc limit 2),

top2_names as( 
select top2.employee_id, e.last_name, e.first_name, sum_purchases, 'Повысить' as action from top2 join employee e on  e.employee_id = top2.employee_id
),

bottom2_names as (
select bottom2.employee_id, e.last_name, e.first_name, sum_purchases, 'Уволить' as action from bottom2 join employee e on  e.employee_id = bottom2.employee_id
),
resulting as (select b.employee_id, b.last_name, b.first_name,b.sum_purchases,b.action from bottom2_names  b
union
select t.employee_id, t.last_name, t.first_name,t.sum_purchases,t.action from top2_names t)

select * from resulting order by sum_purchases, employee_id
