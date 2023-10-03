ABC Corp is a mid-sized insurer in the US and in the recent past their fraudulent claims have increased significantly for their personal auto insurance portfolio. They have developed a ML based predictive model to identify propensity of fraudulent claims. Now, they assign highly experienced claim adjusters for top 5 percentile of claims identified by the model.
Your objective is to identify the top 5 percentile of claims from each state. Your output should be policy number, state, claim cost, and fraud score.


with h as(
select 

state,
percentile_cont(0.05) within group( order by fraud_score desc) as perc

from fraud_score

group by state)

select 
policy_num, f.state, claim_cost, fraud_score
from fraud_score f  join h on h.state = f.state
where fraud_score >= perc
