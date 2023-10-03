You are given a table containing assignment scores of students in a class. Write a query that identifies the largest difference in total score  of all assignments.
Output just the difference in total score (sum of all 3 assignments) between a student with the highest score and a student with the lowest score.

with h as(
select id, sum(assignment1)+ sum(assignment2) + sum(assignment3) as total 


from box_scores
group by id)

select max(total)-min(total) from h
