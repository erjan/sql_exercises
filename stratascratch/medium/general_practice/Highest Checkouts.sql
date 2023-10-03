Find the number of patrons that have made the highest checkouts up to 10 (excluding 10).
Output the number of patrons along with the corresponding total checkouts. Sort records based on the total checkouts in descending order.


select 

count(patron_type_code),


max(total_checkouts) 


from library_usage
where total_checkouts<10
group by total_checkouts

