/*

Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
Order your output in descending order by the total number of challenges in which the hacker earned a full score. 

If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

*/

-- NOTE: join submissions and hackers table - not submissions & challenges table.  Cuz it's submissions related to hackers. if i just join challenges and submissions 
-- i get wrong data. ultimately i need to pull data from submissions
-- also, the difficulty level should match - a hacker can submit score of 30 for challenge of max score 120 and diff level should indicate it

select hackers.hacker_id, name
from submissions inner join challenges on submissions.challenge_id = challenges.challenge_id 
inner join difficulty on difficulty.difficulty_level = challenges.difficulty_level
inner join hackers on submissions.hacker_id = hackers.hacker_id
where difficulty.score = submissions.score and difficulty.difficulty_level = challenges.difficulty_level
group by hackers.hacker_id, name 
having count( challenges.challenge_id)> 1
order by count( challenges.challenge_id) desc, hackers.hacker_id 
 

