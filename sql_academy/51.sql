-- Добавьте товар с именем "Cheese" и типом "food" в список товаров (Goods).

INSERT INTO Goods (good_id, good_name, type)

SELECT COUNT(*) + 1 , 'Cheese', 2 from goods
