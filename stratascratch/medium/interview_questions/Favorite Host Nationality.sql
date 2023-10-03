For each guest reviewer, find the nationality of the reviewer’s favorite host based on the guest’s highest review score given to a host. Output the user ID of the guest along with their favorite host’s nationality. In case there is more than one favorite host from the same country, list that country only once (remove duplicates).


Both the from_user and to_user columns are user IDs.


with h as
(SELECT from_user,
        max(review_score) AS max_s
   FROM airbnb_reviews
   WHERE from_type = 'guest'
   GROUP BY 1
   ORDER BY 1),
   
   h2 as(

select ar.* from h 
inner join airbnb_reviews ar on ar.from_user = h.from_user
   and h.max_s = ar.review_score 
   where ar.from_type = 'guest')
   
   
select distinct h2.from_user , t.nationality from h2  inner join airbnb_hosts t
on h2.to_user = t.host_id order by 1
