Find IDs of LinkedIn users who were employed at Google on November 1st, 2021. Do not consider users who started or ended their employment at Google on that day but do include users who changed their position within Google on that day.


SELECT a.user_id
FROM linkedin_users a
JOIN linkedin_users b ON a.user_id=b.user_id
WHERE LOWER(a.employer) LIKE LOWER('Google')
  AND ((a.start_date < '2021-11-01'
        AND (a.end_date > '2021-11-01'
             OR a.end_date IS NULL))
       OR (a.end_date = '2021-11-01'
           AND b.start_date = '2021-11-01'
           AND LOWER(b.employer) LIKE LOWER('Google')))
