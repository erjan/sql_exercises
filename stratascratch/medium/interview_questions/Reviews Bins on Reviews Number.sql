To better understand the effect of the review count on the price of accomodation, categorize the number of reviews into the following groups along with the price.
0 reviews: NO
1 to 5 reviews: FEW
6 to 15 reviews: SOME
16 to 40 reviews: MANY
more than 40 reviews: A LOT
Output the price and it's categorization. Perform the categorization on accomodation level.


select 

price,
case when number_of_reviews between 1 and 5 then 'FEW'
 when number_of_reviews = 0 then 'NO'
when number_of_reviews between 6 and 15 then 'SOME'
when number_of_reviews between 16 and 40 then 'MANY'
 when number_of_reviews > 40 then 'A LOT' end 

from airbnb_search_details

--group by accommodates
