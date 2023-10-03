Find the price that a small handyman business is willing to pay per employee. Get the result based on the mode of the adword earnings per employee distribution. Small businesses are considered to have not more than ten employees.


select
mode() within group( order by val) as price_willing_to_pay_per_worker
from(

select 

adwords_earnings/n_employees::float as val
from google_adwords_earnings 

where n_employees <=10 and business_type = 'handyman')k

