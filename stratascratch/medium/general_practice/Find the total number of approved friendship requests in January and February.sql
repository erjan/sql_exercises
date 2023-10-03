Find the total number of approved friendship requests in January and February.


select count(*) from facebook_friendship_requests
where date_approved between '2019-01-01' and '2019-02-28'
