Calculate the total revenue made per book. Output the book ID and total sales per book. In case there is a book that has never been sold, include it in your output with a value of 0.


select 


a1.book_id,
coalesce( unit_price * sum(quantity),0) as total_sales
from amazon_books a1 left join amazon_books_order_details a2
on a1.book_id = a2.book_id

group by a1.book_id, unit_price
