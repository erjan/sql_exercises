Rank each host based on the number of beds they have listed. The host with the most beds should be ranked 1 and the host with the least number of beds should be ranked last. Hosts that have the same number of beds should have the same rank but there should be no gaps between ranking values. A host can also own multiple properties.
Output the host ID, number of beds, and rank from highest rank to lowest.



select 
host_id, sum(n_beds) as nbeds,
dense_rank()over(order by sum(n_beds) desc) as rank


from airbnb_apartments

group by host_id
