/*

Julia asked her students to create some coding challenges. 
Write a query to print the hacker_id, name, and the total number of 
challenges created by each student. Sort your results by the total
number of challenges in descending order. 

- If more than one student 
created the same number of challenges, then sort the result by
hacker_id. 

- If more than one student created the same number of (a)
challenges and
the count is less than the maximum number of (b)
challenges created, then exclude those students from the result.

здесь надо вывернуть условие - ( if a and b) = if ~a or ~b  - вместо того чтобы искать кол-во студентов больше 1 
и фильтровать - надо просто искать тех студентов у которых ровно 1 сет(b) и тех 
студентов у которых кол-во челенджей = макс кол-во из всех возможных!
*/



select h.hacker_id, name, count( distinct challenge_id) as c
from hackers h inner join challenges c on 
h.hacker_id = c.hacker_id
group by h.hacker_id, name

having c = 
     -- the count is less than the maximum number - флипнуть на "искать тех студентов у которых макс. кол-во задач"
    (select c_max from (
    select h.hacker_id, count( distinct challenge_id)  as c_max
    from hackers h inner join challenges c on 
    h.hacker_id = c.hacker_id
    group by h.hacker_id order by c_max desc limit 1)k)
    
    or c in (
        -- If more than one student created the same number of  challenges  - поменять на "искать студентов создавших ровно 1 сет челенджей"
        select t.cnt from
        (select count(*) as cnt from challenges group by hacker_id)t
        group by t.cnt
        having count(t.cnt) = 1 )
        
order by c desc, h.hacker_id
    
 

