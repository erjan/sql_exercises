/*
Получи список сотрудников магазинов, разбитый по должностям. Для каждой 
должности в магазине сделай независимую нумерацию.

Выведи поля:

position - порядковый номер сотрудника, занимающего определенную 
должность в магазине. Сотрудников отсортируй сначала по имени, затем по фамилии.
store_name - название магазина.
rank_id - идентификатор должности сотрудника.
first_name - имя сотрудника.
last_name - фамилия сотрудника.
Отсортируй результат по названию магазина, идентификатору должности, имени сотрудника, фамилии сотрудника.
*/

select
row_number() over( partition by store.store_id, rank_id  order by first_name, last_name) as position,

store.name as store_name,
rank_id,
first_name,
last_name

from employee join store on employee.store_id = store.store_id
order by store_name, rank_id, first_name, last_name
