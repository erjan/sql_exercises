Return the top 2 users in each company that called the most. Output the company_id, user_id, and the user's rank. If there are multiple users in the same rank, keep all of them.


with h as(
SELECT company_id,
          c.user_id,
          count(call_id) AS n_calls,
          DENSE_RANK() OVER (PARTITION BY company_id
                             ORDER BY count(call_id) DESC) AS rank
   FROM rc_calls c
   JOIN rc_users u ON c.user_id = u.user_id
   GROUP BY company_id,
            c.user_id)
            
            
select company_id, user_id, rank from h where rank <=2            
