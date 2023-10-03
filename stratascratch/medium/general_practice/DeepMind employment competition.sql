Find the winning teams of DeepMind employment competition.
Output the team along with the average team score.
Sort records by the team score in descending order.


select 

team_id, avg(member_score) as avg_team_score
from google_competition_participants m1 join google_competition_scores m2 on m1.member_id = m2.member_id

group by team_id order by avg_team_score desc
