You are given a dataset that provides the number of active users per day per premium account. A premium account will have an entry for every day that it’s premium. However, a premium account may be temporarily discounted and considered not paid, this is indicated by a value of 0 in the final_price column for a certain day. Find out how many premium accounts that are paid on any given day are still premium and paid 7 days later.
Output the date, the number of premium and paid accounts on that day, and the number of how many of these accounts are still premium and paid 7 days later. Since you are only given data for a 14 days period, only include the first 7 available dates in your output.


SELECT a.entry_date,
       count(a.account_id) premium_paid_accounts,
       count(b.account_id) premium_paid_accounts_after_7d
FROM premium_accounts_by_day a
LEFT JOIN premium_accounts_by_day b ON a.account_id = b.account_id
AND datediff(b.entry_date, a.entry_date) = 7
AND b.final_price > 0
WHERE a.final_price > 0
GROUP BY a.entry_date
ORDER BY a.entry_date
LIMIT 7
