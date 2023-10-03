You’re given a table of rental property searches by users. The table consists of search results and outputs host information for searchers. Find the minimum, average, maximum rental prices for each host’s popularity rating. The host’s popularity rating is defined as below:
0 reviews: New
1 to 5 reviews: Rising
6 to 15 reviews: Trending Up
16 to 40 reviews: Popular
more than 40 reviews: Hot


Tip: The id column in the table refers to the search ID. You'll need to create your own host_id by concating price, room_type, host_since, zipcode, and number_of_reviews.


Output host popularity rating and their minimum, average and maximum rental prices.



with help as(

select 

concat(price, room_type, host_since,zipcode,number_of_reviews) as host_id,
CASE
    WHEN number_of_reviews = 0 THEN 'New'
    WHEN number_of_reviews < 6 THEN 'Rising'
    WHEN number_of_reviews < 16 THEN 'Trending Up'
    WHEN number_of_reviews < 41 THEN 'Popular'
    ELSE 'Hot'
END AS popularity,price

from airbnb_host_searches),

help2 as(
select host_id, popularity, price from help
group by host_id, popularity,price)

select popularity, min(price),avg(price),max(price) from help2 group by popularity


