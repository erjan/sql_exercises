What percentage of all products are both low fat and recyclable?




select sum(distinct case when is_low_fat = 'Y' and is_recyclable='Y' then 1 else 0 end )::float/
count(product_id) *100.0
from facebook_products;
