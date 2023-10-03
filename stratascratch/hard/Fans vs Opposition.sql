Meta/Facebook is quite keen on pushing their new programming language Hack to all their offices. They ran a survey to quantify the popularity of the language and send it to their employees. To promote Hack they have decided to pair developers which love Hack with the ones who hate it so the fans can convert the opposition. Their pair criteria is to match the biggest fan with biggest opposition, second biggest fan with second biggest opposition, and so on. Write a query which returns this pairing. Output employee ids of paired employees. Sort users with the same popularity value by id in ascending order.


Duplicates in pairings can be left in the solution. For example, (2, 3) and (3, 2) should both be in the solution.


with haters as(
select 
employee_id,popularity,
row_number()over(order by popularity asc, employee_id asc) as hater
from facebook_hack_survey f1),

lovers as(
select 
employee_id,popularity,
row_number()over(order by popularity desc, employee_id asc) as lover
from facebook_hack_survey f1)

select employee_fan_id, employee_opposition_id from (
select l.employee_id as employee_fan_id, h.employee_id as employee_opposition_id, l.popularity, h.popularity from lovers l inner join haters h on l.lover = h.hater)k
