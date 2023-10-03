Find the price of the cheapest property for every city.



select city, min(price) from airbnb_search_details

group by city
