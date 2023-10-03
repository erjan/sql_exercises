The election is conducted in a city and everyone can vote for one or more candidates, or choose not to vote at all. Each person has 1 vote so if they vote for multiple candidates, their vote gets equally split across these candidates. For example, if a person votes for 2 candidates, these candidates receive an equivalent of 0.5 vote each. All candidates can vote too.
Find out who got the most votes and won the election. Output the name of the candidate or multiple names in case of a tie. To avoid issues with a floating-point error you can round the number of votes received by a candidate to 3 decimal places.


with h as(
        select *, 
        1/count(*) over (partition by voter)::DECIMAL vote_split
        from voting_results 
        where candidate is not null),
        
h2 as(        
select candidate, round(sum(vote_split),3) as n_votes from h group by candidate)   


select candidate from (

select candidate, 
dense_rank()over(order by n_votes desc) as place 
from h2)k where place = 1
   
