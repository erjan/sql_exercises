-- Удалить компании, совершившие наименьшее количество рейсов.


delete from company 
where company.name in ( select y from (


select company.name as y
from trip inner join company on company.id = trip.company 
group by company.name
 having count(trip.id) =  (select min(fli) as opa from (

select company.name, count(trip.id) as fli from trip inner join company on company.id = trip.company

group by company.name 
order by  fli asc)k))as c)
