Write a query to return the number of customers who rented at least one movie vs. those who didn't in May 2020.
The order of your results doesn't matter.
Use customer table as the base table for all customers (assuming all customers have signed up before May 2020)
Rented: if a customer rented at least one movie.
Bonus: Develop a LEFT JOIN as well as a RIGHT JOIN solution

-- my own solution

with helper as (

select count_rented, count(*) from ( 


select customer.customer_id ,
case when i.customer_id is not null then 1 else 0 end as count_rented


from customer left join( select distinct customer_id from rental 
where date(rental_ts) >= '2020-05-01' and date(rental_ts) <= '2020-05-31')i
on customer.customer_id = i.customer_id)u

group by u.count_rented)



select case when count_rented = 0 then 'never-rented' else 'rented' end as have_rented, count from helper

    
--official

SELECT have_rented, COUNT(*)
FROM (
	SELECT 
	    C.customer_id,
	    CASE WHEN R.customer_id IS NOT NULL THEN 'rented' ELSE 'never-rented' END AS have_rented
	FROM customer C
	LEFT JOIN (
	    SELECT DISTINCT customer_id
		FROM rental 
	    WHERE DATE(rental_ts) >= '2020-05-01'
	    AND DATE(rental_ts) <= '2020-05-31'
    ) R	
	ON R.customer_id = C.customer_id	
) X
GROUP BY have_rented;
