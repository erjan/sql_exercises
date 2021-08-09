/*
Надоело строить иерархию подчиненности сотрудников?

Доработай запрос из теории, нумерующий каталоги товаров. Добавь к каталогам товары этих каталогов и выведи два столбца:

full_name - полное название, состоящее из четырех точек на каждый
уровень вложенности + полный номер в списке + название товара или категории, добавленное через пробел.
type - тип объекта: 'категория' для категорий, 'товар' для товаров.
Строки должны быть отсортированы по названию с учетом вложенности.
*/


WITH RECURSIVE lv_hierarchy AS (
 SELECT c.category_id,
        c.parent_category_id,
        c.name,
        1 AS level,
        '/' || c.name AS path,
        array[row_number () over (order by c.name)] AS path_sort
   FROM category c
  WHERE c.parent_category_id IS NULL

  UNION ALL

 SELECT c.category_id,
        c.parent_category_id,
        c.name,
        p.level + 1 AS level,
        p.path || '/' || c.name AS path,
        p.path_sort || row_number () over (partition by c.parent_category_id order by c.name) AS path_sort
   FROM lv_hierarchy p,
        category c
  WHERE c.parent_category_id = p.category_id
)
SELECT lpad('', (c.level - 1) * 4, '.') || array_to_string(c.path_sort, '.') || '. ' || c.name AS full_name,
       c.type
  FROM (SELECT c.name,
               c.level,   
               c.path_sort,
               'категория' AS type
          from lv_hierarchy c
         UNION ALL
        SELECT p.name,
               c.level + 1,
               c.path_sort || row_number () over (partition by p.category_id order by p.name, p.product_id),
               'товар' AS type
          FROM lv_hierarchy c,
               product p
         WHERE p.category_id = c.category_id 
       ) c
 ORDER BY c.path_sort
