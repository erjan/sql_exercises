Find how many events happened on MacBook-Pro per company in Argentina from users that do not speak Spanish.
Output the company id, language of users, and the number of events performed by users.


select 

company_id, language, count(event_name)

from playbook_events pe left join 

playbook_users pu on pe.user_id = pu.user_id

where location = 'Argentina' and language <> 'spanish' and device = 'macbook pro'

group by company_id, language
