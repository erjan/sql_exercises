Find the number of emails received by each user under each built-in email label. The email labels are: 'Promotion', 'Social', and 'Shopping'. Output the user along with the number of promotion, social, and shopping mails count,.

SELECT to_user,
       SUM(CASE
               WHEN label = 'Promotion' THEN cnt
               ELSE 0
           END) AS promotion_count,
       SUM(CASE
               WHEN label = 'Social' THEN cnt
               ELSE 0
           END) AS social_count,
       SUM(CASE
               WHEN label = 'Shopping' THEN cnt
               ELSE 0
           END) AS shopping_count
FROM
  (SELECT mails.to_user,
          labels.label,
          COUNT(*) AS cnt
   FROM google_gmail_emails mails
   INNER JOIN google_gmail_labels labels ON mails.id = labels.email_id
   GROUP BY mails.to_user,
            labels.label) base
GROUP BY to_user
ORDER BY to_user
