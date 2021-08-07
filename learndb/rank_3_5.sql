/*
Составь рейтинг магазинов по количеству сотрудников. Чем больше сотрудников, тем выше рейтинг магазина.

Выведи поля:

store_id - идентификатор магазина.
name - название магазина.
count_employees - количество сотрудников, работающих в магазине.
position - номер магазина в рейтинге. Магазин с максимальным количеством сотрудников 
занимает 1-ю позицию. Магазины с одинаковым количеством сотрудников занимаю одинаковую позицию.
Отсортируй результат сначала по позиции в рейтинге, затем по названию магазина.

P.S. В ORDER BY в оконной функции можно задавать порядок сортировки ASC или DESC, как и в 
ORDER BY для сортировки результата запроса.
*/

select 
store.store_id,
store.name as name,
count(*) as count_employees,


rank() over (order by count(employee.*) desc ) as position

from employee join store on employee.store_id = store.store_id

group by store.store_id
order by position , name
