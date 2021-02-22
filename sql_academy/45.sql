
-- Какой(ие) кабинет(ы) пользуются самым большим спросом?

select classroom from schedule group by classroom
having count(classroom) = 

(select max(kolvo) as op from (

select  classroom ,count(classroom)  as kolvo
from schedule
group by   classroom 
order by count(classroom) desc )k)
