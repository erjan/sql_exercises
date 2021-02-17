
-- Выведите отсортированный список (по возрастанию) имен студентов в виде Фамилия.И.О.

select  
concat(

concat(ucase(left(last_name,1)), substring( last_name,2)) , '.',

ucase(left(first_name,1)), '.',

ucase(left(middle_name,1)), '.'   ) as name


from student order by name asc ;
