-- Найдите среднюю стоимость икры. В базе данных хранятся данные о покупках красной (red caviar) и черной икры (black caviar).
 select  sum(unit_price)/ count(*) as cost
 from payments inner join goods on goods.good_id = payments.good 
 where good_name like '%caviar'


