Find the room types that are searched by most people. Output the room type alongside the number of searches for it. If the filter for room types has more than one room type, consider each unique room type as a separate row. Sort the result based on the number of searches in descending order.



select cleaned_filter, sum(n_searches) as x from (
select 

distinct *,
unnest(string_to_array(ltrim(filter_room_types, ','), ',')) as cleaned_filter

from airbnb_searches)k

group by cleaned_filter
order by x desc
