/*
Получи информацию о количестве сотрудников из таблицы employee:

в каждом магазине на каждой должности;
общее количество сотрудников в магазине;
общее количество сотрудников, занимающих определенную должность;
общее количество сотрудников во всех магазинах.
В результате выведи столбцы:

store_id - идентификатор магазина;
rank_id - идентификатор должности;
count_employees - количество сотрудников.
Отсортируй результат сначала по идентификатору магазина, затем по 
идентификатору должности. Для обоих полей NULL значения размести в конце, воспользовавшись 
конструкцией NULLS LAST, как это сделано в теории задания.
*/

select store_id, rank_id,

count(*) as count_employees

from employee

group by cube(store_id, rank_id)
order by store_id NULLS LAST, rank_id NULLS LAST
