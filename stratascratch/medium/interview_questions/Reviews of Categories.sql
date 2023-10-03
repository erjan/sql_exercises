Find the top business categories based on the total number of reviews. Output the category along with the total number of reviews. Order by total reviews in descending order.




select unnest(string_to_ARRAY(categories, ';')) as category,

sum(review_count) as totalreview



from yelp_business

group by category
order by totalreview desc

