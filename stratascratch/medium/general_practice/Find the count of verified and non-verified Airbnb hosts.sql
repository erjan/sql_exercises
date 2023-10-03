Find how many hosts are verified by the Airbnb staff and how many aren't. Assume that in each row you have a different host.


select host_identity_verified, count(*) from airbnb_search_details

group by host_identity_verified
