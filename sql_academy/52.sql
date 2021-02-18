-- Добавьте в список типов товаров (GoodTypes) новый тип "auto".

INSERT INTO GoodTypes (good_type_id, good_type_name)

SELECT COUNT(*) + 1 , 'auto' from GoodTypes 
