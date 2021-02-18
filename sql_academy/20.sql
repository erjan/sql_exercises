
-- Сколько и кто из семьи потратил на развлечения (entertainment). Вывести статус в семье, имя, сумму
select status, member_name, 

sum(unit_price * amount) as costs
 from familymembers inner join payments on familymembers.member_id = payments.family_member inner join goods on goods.good_id = payments.good inner join goodtypes on goodtypes.good_type_id = goods.type
 where good_type_name = 'entertainment'

group by status, member_name
