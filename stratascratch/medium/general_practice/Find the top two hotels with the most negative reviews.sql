Find the top two hotels with the most negative reviews.
Output the hotel name along with the corresponding number of negative reviews.
Sort records based on the number of negative reviews in descending order.


select hotel_name, x from (
select hotel_name, count(distinct negative_review) as x,
rank()over(order by count(distinct negative_review) desc) as rnk


from hotel_reviews

where negative_review <> 'No Negative'

group by hotel_name )k where rnk < 3
-- desc limit 2
