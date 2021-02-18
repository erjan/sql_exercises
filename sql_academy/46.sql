-- В каких классах введет занятия преподаватель "Krauze" ?

select distinct class.name as name from
class inner join schedule on class.id = schedule.class inner join teacher on teacher.id = schedule.teacher where teacher.last_name = 'Krauze'
