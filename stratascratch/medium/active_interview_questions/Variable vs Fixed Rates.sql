Write a query that returns binary description of rate type per loan_id. The results should have one row per loan_id and two columns: for fixed and variable type.


select loan_id, 

case when rate_type = 'fixed' then 1 else 0 end as fixed,
case when rate_type = 'variable' then 1 else 0 end as variable

from submissions;
