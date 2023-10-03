Display the average number of times a user performed a search which led to a successful booking and the average number of times a user performed a search but did not lead to a booking. The output should have a column named action with values 'does not book' and 'books' as well as a 2nd column named average_searches with the average number of searches per action. Consider that the booking did not happen if the booking date is null. Be aware that search is connected to the booking only if their check-in dates match.




select 

case when ac.ts_booking_at is not null then 'books' else 'does not book' end as action, avg(n_searches) as average_searches


from airbnb_contacts ac 

right join airbnb_searches a2 on ac.ds_checkin = a2.ds_checkin and a2.id_user = ac.id_guest

group by 1

