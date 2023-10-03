Find the highest price in US country for each variety produced in English speaking regions, but not in Spanish speaking regions, with taking into consideration varieties that have earned a minimum of 90 points for every country they're produced in.
Output both the variety and the corresponding highest price.


Let's assume the US is the only English speaking region in the dataset, and Spain, Argentina are the only Spanish speaking regions in the dataset. Let's also assume that the same variety might be listed under several countries so you'll need to remove varieties that show up in both the US and in Spanish speaking countries.


SELECT variety,
       max(price)
FROM winemag_p1
WHERE variety in
    (SELECT variety
     FROM winemag_p1
     WHERE variety not in
         (SELECT variety
          FROM winemag_p1
          WHERE country in ('Spain',
                            'Argentina'))
     GROUP BY variety
     HAVING min(points) >= 90)
  AND country = 'US'
GROUP BY variety
