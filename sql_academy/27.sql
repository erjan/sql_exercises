-- Узнать, сколько потрачено на каждую из групп товаров в 2005 году. Вывести название группы и сумму

select 


good_type_name,

sum(amount * unit_price) as costs

from payments inner join goods on goods.good_id = payments.good inner join goodtypes on goodtypes.good_type_id = goods.type where year(date) = 2005
group by good_type_name
