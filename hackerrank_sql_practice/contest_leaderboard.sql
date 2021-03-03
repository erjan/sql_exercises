
/*

You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!

The total score of a hacker is the sum of their maximum scores for all of the challenges. 
Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
If more than one hacker achieved the same total score, then sort the 
result by ascending hacker_id. Exclude all hackers with a total score of 0 from your result.
*/

select  hacker_id, name, sum(maxscore) as ii  from (
select 
h.hacker_id,
h.name, 
challenge_id,

max(score) as maxscore

from submissions s  inner join hackers h on h.hacker_id = s.hacker_id
group by h.hacker_id, h.name, challenge_id)k 
group by name, hacker_id
having sum(maxscore) != 0
order by ii desc, hacker_id asc

