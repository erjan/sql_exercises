Write a query that returns the user ID of all users that have created at least one ‘Refinance’ submission and at least one ‘InSchool’ submission.

SELECT 
 user_id

FROM loans
where type = 'Refinance' 
intersect
select user_id from loans where type = 'InSchool'
