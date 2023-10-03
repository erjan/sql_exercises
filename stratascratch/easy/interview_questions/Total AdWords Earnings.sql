Find the total AdWords earnings for each business type. Output the business types along with the total earnings.


select 

business_type,
sum(adwords_earnings)
from google_adwords_earnings

group by business_type
