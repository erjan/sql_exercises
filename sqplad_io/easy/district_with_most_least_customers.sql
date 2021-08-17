/*
Return the districts with the most and least number of customers.
Append a column to indicate whether this district has the most customers or least customers with 'most' or 'least' category.
HINT: it is possible an address is not associated with any customer.

моя ошибка - здесь многие районы имеют одинаковое кол-во клиентов - поэтму надо их отсортировать и задать им ранг - row number. прост пощитать скоко клиентов надо
но недостаточно.


*/

-- 1st solution official 

WITH district_cust_cnt AS (
	SELECT     
		A.district,
		COUNT(DISTINCT C.customer_id) cust_cnt,
		ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT C.customer_id) ASC) AS cust_asc_idx,
		ROW_NUMBER() OVER(ORDER BY COUNT(DISTINCT C.customer_id) DESC) AS cust_desc_idx
	FROM address A
	LEFT JOIN customer C
	ON A.address_id = C.address_id
	GROUP BY A.district
)
SELECT 
    district,
    'least' AS city_cat
FROM district_cust_cnt
WHERE cust_asc_idx = 1
UNION
SELECT 
    district,
    'most' AS city_cat
FROM district_cust_cnt
WHERE cust_desc_idx = 1
;

-- 2nd my own solution:


with h1 as (
SELECT     
		A.district,
		COUNT(DISTINCT C.customer_id) cust_cnt  
	FROM address A
	LEFT JOIN customer C --inner join will not work, cuz some addreses can belong to nobody, gives 'Aceh' as result
	ON A.address_id = C.address_id
	GROUP BY A.district 
	ORDER by cust_cnt  limit 1),


h2 as (
SELECT     
		A.district,
		COUNT(DISTINCT C.customer_id) cust_cnt  
	FROM address A
	LEFT JOIN customer C
	ON A.address_id = C.address_id
	GROUP BY A.district 
	ORDER by cust_cnt desc limit 1)
	
	
select district, 'least' as city_cat from h1 union
select district , 'most' as city_cat  from h2

