Find the total revenue made by each region from each variety of wine in that region. Output the region, variety, and total revenue.


Take into calculation both region_1 and region_2. Remove the duplicated rows where  region, price and variety are exactly the same.


SELECT
    region,variety,sum(price) 
FROM 
    (
    select region_1 as region,variety, price
    from winemag_p1
    UNION
    select region_2 as region,variety, price
    from winemag_p1
    ) tmp
Where price is NOT NULL
    and region is not NULL
GROUP BY region,variety
ORDER BY sum(price) DESC
