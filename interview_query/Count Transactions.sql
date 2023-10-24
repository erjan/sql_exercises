

'''
  Let’s say we have an annual_payments table. Answer the following three questions via SQL queries and output them as a table with the answers to each question.

How many total transactions are in this table?
How many different users made transactions?
How many transactions listed as "paid" have an amount greater or equal to 100?
Which product made the highest revenue? (use only transactions with a "paid" status)
'''

  

with h as(
select  4 as question_id , max(amount) as c, product as product_id  from annual_payments 
where status = 'paid'
group by product order by c desc limit 1)



SELECT 1 as question_id , count(*) as answer FROM annual_payments 

union 
SELECT  2 as question_id ,count(distinct user_id) as unique_users FROM annual_payments 
union
select  3 as question_id ,count(*) as greater100 from annual_payments 
where status = 'paid' and amount >= 100

union
select question_id, product_id from h

---------------------------------------------------------------------------------------------
official

SELECT 1 AS question_id, COUNT(*) AS answer 
	FROM annual_payments
UNION ALL
SELECT 2 AS question_id, COUNT(DISTINCT user_id) AS answer 
	FROM annual_payments
UNION ALL 
SELECT 3 AS question_id, COUNT(*) AS answer 
	FROM annual_payments 
	WHERE STATUS = 'paid' 
		AND amount>=100
UNION ALL 
SELECT * FROM (
	SELECT 4 AS question_id, product AS answer 
		FROM annual_payments 
		WHERE STATUS = 'paid' 
		GROUP BY product 
		ORDER BY SUM(amount) DESC
		LIMIT 1 
	) x
