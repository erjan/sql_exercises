Find the scores of 4 quartiles of each company

Output the company name along with the corresponding score of each quartile.
Order records based on the average score of all quartiles in ascending order.





select 
owner_name,
percentile_cont(0.25)within group(order by score),
percentile_cont(0.5)within group(order by score),
percentile_cont(0.75)within group(order by score),
percentile_cont(1.0)within group(order by score)


from los_angeles_restaurant_health_inspections 
group by owner_name

