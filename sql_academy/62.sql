
-- Вывести в порядке убывания популярности доменные имена 2-го уровня, используемые пользователями для 
-- электронной почты. Полученный результат необходимо дополнительно отсортировать по возрастанию названий доменных имён.

select substring( email, locate('@', email)+1)  as domain, count(*) as count from users  

group by substring( email, locate('@', email)+1)
order by count desc , domain asc
