Find the number of words in each business name. Avoid counting special symbols as words (e.g. &). Output the business name and its count of words.

with h as(
select 
business_name,
regexp_replace(business_name, '[^a-zA-Z0-9 ]', '','g') as bname

from sf_restaurant_health_violations)


select distinct business_name,
array_length(regexp_split_to_array(bname, '\s+'),1) as word_count from h
