Given a list of a company's employees, find the name of the manager from the largest department. Manager is each employee that contains word "manager" under their position.  Output their first and last name.


SELECT first_name,
       last_name
FROM
  (SELECT *,
          RANK() over(
                      ORDER BY dpt_members DESC) AS rnk
   FROM
     (SELECT *,
             COUNT(*) over(PARTITION BY department_id) AS dpt_members
      FROM az_employees) a) b
WHERE POSITION ilike '%manager%'
  AND rnk = 1
