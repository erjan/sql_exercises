Find all emails with duplicates.



select 
email
from employee group by email

having count(*) > 1
