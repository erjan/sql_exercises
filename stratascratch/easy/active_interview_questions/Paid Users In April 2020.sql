How many paid users had any calls in Apr 2020?



select 



count(distinct ru.user_id)
from rc_calls rc join rc_users ru on rc.user_id = ru.user_id

where status = 'paid' and extract(year from date) = 2020 and extract(month from date) = 4
