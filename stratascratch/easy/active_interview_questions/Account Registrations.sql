Find the number of account registrations according to the signup date. Output the months and their corresponding number of registrations.

select 

to_char( started_at, 'YYYY-MM'),
count(*)

from noom_signups

group by to_char( started_at, 'YYYY-MM')

-- to_date('YYYY-MM', started_at)
