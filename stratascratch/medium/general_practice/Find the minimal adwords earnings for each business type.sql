Find the minimal adwords earnings for each business type.
Output the business type along with the minimal earning.


select 


business_type, min(adwords_earnings)
from google_adwords_earnings
group by business_type
