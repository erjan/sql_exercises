How many searches were there in the second quarter of 2021?




select count(search_id) from fb_searches

where extract(quarter from date) = 2 and extract(year from date) = 2021
