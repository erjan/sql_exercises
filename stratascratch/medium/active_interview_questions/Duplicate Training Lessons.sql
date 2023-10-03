Display a list of users who took the same training lessons more than once on the same day. Output their usernames, training IDs, dates and the number of times they took the same lesson.

SELECT *
FROM users_training u
inner JOIN training_details t ON u.u_id = t.u_id
-- GROUP BY u_name,training_id,training_date
-- HAVING COUNT(*) > 1
