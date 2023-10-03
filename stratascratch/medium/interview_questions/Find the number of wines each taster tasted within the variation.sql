Find the number of wines each taster tasted within the variation.
Output the tester's name, variety, and the number of tastings.
Order records by taster name and the variety in ascending order and by the number of tasting in descending order.


select taster_name ,variety, count(*) as n_tastings


from winemag_p2

where taster_name is  null
group by  taster_name, variety
order by taster_name, variety, n_tastings desc
