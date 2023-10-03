Find Yelp food reviews containing any of the keywords: 'food', 'pizza', 'sandwich', or 'burger'. List the business name, address, and the state which satisfies the requirement.


select distinct name ,address,state 
from (

select  business_name 

from yelp_reviews yr
where strpos(review_text, 'food')<> 0 

or strpos(review_text, 'pizza')<> 0 
or strpos(review_text, 'sandwich')<> 0 
or strpos(review_text, 'burger')<> 0 )k join yelp_business bus on btrim(bus.name, '"') = k.business_name
