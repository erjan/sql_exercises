
-- Определить группы товаров, которые не приобретались в 2005 году

select  good_type_name 
from goodtypes where good_type_id not in (
select type from goods where goods.good_id in (select good from payments  where year(date) = 2005))
