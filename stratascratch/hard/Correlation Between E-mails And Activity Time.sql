There are two tables with user activities. The google_gmail_emails table contains information about emails being sent to users. Each row in that table represents a message with a unique identifier in the id field. The google_fit_location table contains user activity logs from the Google Fit app.
Find the correlation between the number of emails received and the total exercise per day. The total exercise per day is calculated by counting the number of user sessions per day.


SELECT corr(n_emails :: NUMERIC, total_exercise :: NUMERIC)
FROM
  (SELECT to_user,
          DAY,
          COUNT(*) AS n_emails
   FROM google_gmail_emails
   GROUP BY to_user,
            DAY) mail_base
INNER JOIN
  (SELECT user_id,
          DAY,
          COUNT(DISTINCT session_id) AS total_exercise
   FROM google_fit_location
   GROUP BY user_id,
            DAY) loc_base ON mail_base.to_user = loc_base.user_id
AND mail_base.DAY = loc_base.DAY
