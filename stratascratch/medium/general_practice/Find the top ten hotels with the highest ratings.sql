Find the top ten hotels with the highest ratings.

Output the hotel name along with the corresponding average score.
Sort records based on the average score in descending order.


 with h as(
select 

hotel_name, average_score,  rank()over(order by average_score desc ) as rnk
from hotel_reviews order by rnk asc )

select hotel_name, average_score from h where rnk < 11

