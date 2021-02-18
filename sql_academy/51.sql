-- Добавьте товар с именем "Cheese" и типом "food" в список товаров (Goods).
INSERT INTO Goods (good_id, good_name, type)

SELECT COUNT(*) + 1 , 'Cheese', (SELECT good_type_id from GoodTypes where good_type_name='food') from goods
