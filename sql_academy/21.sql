-- Определить товары, которые покупали более 1 раза



select good_name from payments inner join goods on goods.good_id = payments.good group by good
having count(payments.payment_id) > 1
