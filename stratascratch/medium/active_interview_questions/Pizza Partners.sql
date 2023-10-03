Which partners have ‘pizza’ in their name and are located in Boston? And what is the average order amount? Output the partner name and the average order amount.


select pp.name, avg(amount) from postmates_orders po inner join postmates_markets pm on 
po.city_id = pm.id inner join postmates_partners pp on pp.id = po.seller_id

where pp.name ilike '%pizza%' and pm.name = 'Boston'

group by pp.name
