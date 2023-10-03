Verify that the first 4 digits are equal to 1415 for all phone numbers.




select 

count(*)

from sf_restaurant_health_violations

where business_phone_number is not null and left(business_phone_number:: TEXT, 4)<>'1415'

