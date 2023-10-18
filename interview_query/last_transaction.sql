
'''
  Given a table of bank transactions with columns id, transaction_value, and created_at representing the date and time for each transaction, write a query to get the last transaction for each day.

The output should include the id of the transaction, datetime of the transaction, and the transaction amount. Order the transactions by datetime.
  '''

with h as(

select rank()over(partition by date_format(created_at, '%Y-%m-%d') order by created_at desc) as rnk,

created_at, id,  transaction_value 
from bank_transactions)


select created_at, id, transaction_value from h where rnk = 1
