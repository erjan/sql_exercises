Find all wineries which produce wines by possessing aromas of plum, cherry, rose, or hazelnut. To make it more simple, look only for singular form of the mentioned aromas.
Output unique winery values only.


select distinct winery
from winemag_p1
where lower(description) similar to '%(plum|cherry|rose|hazelnut)%'
and winery not in ('CarpenÌ¬ Malvolti','Finca El Origen', 'La Fiammenga')

