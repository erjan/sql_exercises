Consider all LinkedIn users who, at some point, worked at Microsoft. For how many of them was Google their next employer right after Microsoft (no employers in between)?


SELECT count(user_id) n_employees
FROM
  (SELECT user_id,
          employer,
          LEAD(employer) OVER (PARTITION BY user_id
                               ORDER BY start_date ASC) next_employer
   FROM linkedin_users)a
WHERE LOWER(employer) LIKE LOWER('microsoft')
  AND LOWER(next_employer) LIKE LOWER('google')
