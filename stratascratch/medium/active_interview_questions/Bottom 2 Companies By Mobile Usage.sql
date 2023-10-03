Write a query that returns a list of the bottom 2 companies by mobile usage. Company is defined in the customer_id column. Mobile usage is defined as the number of events registered on a client_id == 'mobile'. Order the result by the number of events ascending.
In the case where there are multiple companies tied for the bottom ranks (rank 1 or 2), return all the companies. Output the customer_id and number of events.


with h as(
select 
customer_id, count(event_type) as events, dense_rank()over(order by count(event_type) ) as rnk

from fact_events

where client_id = 'mobile'

group by customer_id)


select customer_id, events from h where rnk <=2
