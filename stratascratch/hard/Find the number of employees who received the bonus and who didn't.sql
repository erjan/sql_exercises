Find the number of employees who received the bonus and who didn't.
Output value inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding number of employees for each.


with h as(
select 

id,
case when bonus_date is null then 0 else 1 end as hasbonus
from employee e left outer join bonus b on e.id = b.worker_ref_id)


select  hasbonus, count(distinct id) from h group by hasbonus
