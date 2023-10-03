Count how many claims submitted in December 2021 are still pending. A claim is pending when it has neither an acceptance nor rejection date.


select 


count(*)
from cvs_claims
where extract(year from date_submitted) = 2021 and extract(month from date_submitted) = 12 and date_accepted is null and date_rejected is null
