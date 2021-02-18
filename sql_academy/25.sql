-- Determine which products are available in the Goods table but were not purchased during 2005


  select good_name from goods where good_id not in (
 select good from payments where year(date) = 2005)
