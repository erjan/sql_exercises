Find the number of occurrences of custom email labels for each user receiving an email. Output the receiver user id, label, and the corresponding number of occurrences.


select user_id, label , c from (
select 

to_user as user_id,
label,
sum(case when label ilike '%Custom_%'  then 1 else 0 end) as c

from google_gmail_emails g1 inner join google_gmail_labels g2 on 
g1.id = g2.email_id

group by to_user, label)k where label ilike '%Custom%'
