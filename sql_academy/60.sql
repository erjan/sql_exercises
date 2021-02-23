-- Print the identifiers of the teachers who taught at least once for the entire time in each of the eleventh grades.

with help as (
select teacher, classroom, name from schedule inner join class on class.id = schedule.class where class.name like '11%')


select distinct h1.teacher from help h1 inner join help h2 on h1.teacher = h2.teacher where  h1.name != h2.name

-- note: "условие "не меньше ОДНОГО раза" не требует дополнительной проверки на количество"

-- bad SOLUTION with having() - no need to use having!

with help as (
select teacher, classroom, name from schedule inner join class on class.id = schedule.class where class.name like '11%')


select distinct h1.teacher from help h1 inner join help h2 on h1.teacher = h2.teacher where  h1.name != h2.name
group by h1.teacher
having count(distinct h1.classroom) >= 1



