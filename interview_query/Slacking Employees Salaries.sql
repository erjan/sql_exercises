
'''
  Suppose your company needs to cut costs due to an economic downturn. During a coffee break, you hear a rumor that a lot of money goes to employees who don’t do their work, and you decide to find out if the rumor is true.

Given two tables: employees and projects, find the sum of the salaries of all the employees who didn’t complete any of their projects.

Clarification:

We will consider a project unfinished if it has no end date (its End_dt is NULL).

Given this, we’ll say an employee didn’t finish any of their projects when:

They were assigned at least one project.
None of their projects have an End_dt.
  '''


WITH slack_salaries AS (
    SELECT e.salary
    FROM employees e
    INNER JOIN projects p
    ON e.id = p.employee_id
    GROUP BY e.id
    HAVING COUNT(p.End_dt) = 0
)

SELECT sum(salary) AS total_slack_salary
FROM slack_salaries
