-- Вывести средний возраст людей (в годах), хранящихся в базе данных. Результат округлите до целого в меньшую сторону.

SELECT floor(avg( TIMESTAMPDIFF(YEAR ,birthday, curdate() ))) as age from familymembers 
