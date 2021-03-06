/*
Write a query to print total number of unique hackers who made at least 1 
submission each day (starting on the first day of the contest), and find 
the hacker_id and name of the hacker who made maximum number of submissions 
each day. If more than one such hacker has a maximum number of submissions, 
print the lowest hacker_id. The query should 
print this information for each day of the contest, sorted by the date.

*/


-- really stupid problem - i was sitting on this one for so long cuz it's badly worded - just looked up the solution
select 
submission_date ,

( SELECT COUNT(distinct hacker_id)  
 FROM Submissions s2  
 WHERE s2.submission_date = s1.submission_date AND    
 (SELECT COUNT(distinct s3.submission_date) FROM   
      Submissions s3 WHERE s3.hacker_id = s2.hacker_id AND 
      s3.submission_date < s1.submission_date) = dateDIFF(s1.submission_date , '2016-03-01')) ,

(select hacker_id  from submissions s2 where s2.submission_date = s1.submission_date 
group by hacker_id order by count(submission_id) desc , hacker_id limit 1) as shit,
(select name from hackers where hacker_id = shit)
from 
(select distinct submission_date from submissions) s1
group by submission_date
