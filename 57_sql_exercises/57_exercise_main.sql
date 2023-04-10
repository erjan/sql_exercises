


--1 select * from shippers
--2 select category_name, description from categories

--  select first_name, last_name, title, hire_date from employees where  title like  '%Sales Represen%'


--  select first_name, last_name,  hire_date from employees where  title like  '%Sales Represen%' and country='USA'

-- select order_id , order_date from orders where employee_id = 5

-- select supplier_id, contact_name, contact_title from suppliers where contact_title  not like '%Marketing Manager%'

-- select product_id, product_name from products where  product_name  like '%Queso%'




-- select order_id, customer_id, ship_country from orders where ship_country in ('France', 'Belgium')

																			   
-- select first_name, last_Name, date(birth_date), title from employees order by birth_date																			

-- select first_name, last_name, concat(first_name, ' ', last_name) as full_name from employees


-- select order_id, product_id, unit_price,  quantity , (unit_price * quantity) as total_price from order_details order by order_id, product_id


-- select count(*) from customers 

-- select min(order_date) from orders 
-- select country from customers  group by  country 
-- select distinct contact_title, count(*)  as TotalContactTitle from customers group by contact_title order by count(*) desc
-- select product_id, product_name,  company_name  from products p left join suppliers s on p.supplier_id = s.supplier_id

-- select o.order_id, o.order_date , s.company_name from orders o join shippers s on o.ship_via = s.shipper_id where order_id < 10300

-- INTERMEDIATE PROBLEMS

-- select c.category_name, count(p.product_id) as TotalProducts from products p join categories c on c.category_id = p.category_id group by c.category_id order by TotalProducts desc

-- select c.country, c.city, count(*) as TotalCustomer from customers c group by c.country, c.city order by TotalCustomer desc


-- select product_id,product_name,units_in_stock, reorder_level from products  where units_in_stock < reorder_level order by product_id

-- select product_id,product_name,units_in_stock, units_on_order, reorder_level,discontinued from products  where (units_in_stock+units_on_order) <= reorder_level and discontinued=0 order by product_id


-- with help as (
-- Select
--     customer_id
--     ,company_name
--     ,region
--     ,Case  
--         when region is null then 1
--         else 0
--     End as x
-- From customers
-- order by region, customer_id)

-- select   customer_id
--     ,company_name
--     ,region from help 


-- select ship_country, avg(freight) as avgf from orders group by ship_country order by avgf desc limit 3

-- with h as(
-- select *, extract('year' from order_date) as y from orders )

-- select ship_country, avg(freight) as avgf from h where y = 1997 group by ship_country order by avgf desc limit 3


-- SELECT date '2030-01-20' + interval '1 year';

-- select max(order_date), date(max(order_date) + interval '1 year') as yearafter from orders


-- select ship_country, avg(freight) as avgf from orders 

-- where order_date > (select date(max(order_date) - interval '1 year')  from orders )
-- group by ship_country order by avgf desc  limit 3


-- select e.employee_id, e.last_name, o.order_id, 
-- p.product_id, 
-- p.product_name,  count(*) from employees e inner join 
-- orders o on o.employee_id = e.employee_id inner join order_details od on od.order_id = o.order_id inner join products p on
-- p.product_id = od.product_id

-- group by e.employee_id, e.last_name, o.order_id,p.product_name, p.product_id
-- order by o.order_id, p.product_id

-- select c.customer_id, o.order_id from customers c left join orders o on c.customer_id = o.customer_id  where o.customer_id is null


-- select c.customer_id, o.order_id from customers c left join orders o on c.customer_id = o.customer_id   and o.employee_id = 4
-- where o.customer_id is null 

-- advanced problems



-- select  

-- c.customer_id, c.company_name, o.order_id, sum(quantity*unit_price) as TotalOrderAmount
-- from customers c 
-- join orders o on o.customer_id = c.customer_id 
-- join order_details od on od.order_id = o.order_id

-- where date(o.order_date) >='1998-01-01' and date(o.order_date) <='1999-01-01'
-- group by c.customer_id, c.company_name, o.order_id

-- having count(o.order_id)>=1 and sum(quantity*unit_price)>=10000
-- order by TotalOrderAmount desc



-- select  

-- c.customer_id, c.company_name, o.order_id, sum(quantity*unit_price) as TotalOrderAmount
-- from customers c 
-- join orders o on o.customer_id = c.customer_id 
-- join order_details od on od.order_id = o.order_id

-- where date(o.order_date) >='1998-01-01' and date(o.order_date) <='1999-01-01'
-- group by c.customer_id, c.company_name, o.order_id

-- having sum(quantity*unit_price)>15000
-- order by TotalOrderAmount desc




-- select  

-- c.customer_id, c.company_name, o.order_id, round(sum(quantity*unit_price * (1-discount) )) as TotalOrderAmountWithDiscount
-- from customers c 
-- join orders o on o.customer_id = c.customer_id 
-- join order_details od on od.order_id = o.order_id

-- -- where date(o.order_date) >='1998-01-01' and date(o.order_date) <='1999-01-01'
-- group by c.customer_id, c.company_name, o.order_id

-- having sum(quantity*unit_price*(1-discount))>10000
-- order by TotalOrderAmountWithDiscount desc





-- select employee_id, order_id, order_date from orders  

-- where order_date in (select date_trunc('month', order_date) + interval '1 month - 1 day' from orders)

-- order by employee_id, order_id



-- select od.order_id, count(*) from order_details od inner join orders o on o.order_id = od.order_id
-- group by od.order_id order by count(*) desc limit 10



-- SELECT order_id FROM orders TABLESAMPLE bernoulli(2)



-- select o.order_id from orders o inner join order_details od on od.order_id = o.order_id where od.quantity >=60

-- group by o.order_id, quantity having count(*)>1



-- Select
--     order_details.order_id
--     ,product_id
--     ,unit_price
--     ,quantity
--     ,discount

-- From order_details

--     Join (
--         Select
--             distinct order_id
--         From order_details
--         Where quantity >= 60
--         Group By order_id, quantity
--         Having Count(*) > 1

--     )  PotentialProblemOrders

--         on PotentialProblemOrders.order_id = order_details.order_id

-- Order by order_id, product_id



-- select order_id, order_date, required_date, shipped_date from orders 

-- where shipped_date >  required_date


-- select e.employee_id, e.last_name, count(*) as total_late 

-- from employees e join orders o on e.employee_id = o.employee_id 

-- where shipped_date >=  required_date

-- group by e.employee_id, e.last_name order by total_late desc




-- with all_orders as(
-- select e.employee_id, e.last_name, count(o.order_id) as all_orders 

-- from employees e  join orders o on e.employee_id = o.employee_id 
-- group by e.employee_id, e.last_name order by all_orders desc),

-- late_orders as (select e.employee_id, e.last_name, count(o.order_id) as late 
-- from employees e  join orders o on e.employee_id = o.employee_id 
-- where shipped_date >  required_date
-- group by e.employee_id, e.last_name order by late desc)

-- select l.employee_id, l.last_name, a.all_orders, l.late
-- from late_orders l  join all_orders a on l.employee_id = a.employee_id

-- with all_orders as(
-- select e.employee_id, e.last_name, count(o.order_id) as all_orders 

-- from employees e left join orders o on e.employee_id = o.employee_id 
-- group by e.employee_id, e.last_name order by all_orders desc),

-- late_orders as (select e.employee_id, e.last_name, count(o.order_id) as late 
-- from employees e left join orders o on e.employee_id = o.employee_id 
-- where shipped_date >  required_date
-- group by e.employee_id, e.last_name order by late desc)

-- select l.employee_id, l.last_name, a.all_orders, l.late
-- from late_orders l right join all_orders a on l.employee_id = a.employee_id



--45



-- with all_orders as(
-- select e.employee_id, e.last_name, count(o.order_id) as all_orders 

-- from employees e left join orders o on e.employee_id = o.employee_id 
-- group by e.employee_id, e.last_name order by all_orders desc),

-- late_orders as (select e.employee_id, e.last_name, count(o.order_id) as late 
-- from employees e left join orders o on e.employee_id = o.employee_id 
-- where shipped_date >  required_date
-- group by e.employee_id, e.last_name order by late desc)

-- select l.employee_id, l.last_name, a.all_orders, l.late
-- from late_orders l left join all_orders a on l.employee_id = a.employee_id

--46



-- with all_orders as(
-- select e.employee_id, e.last_name, count(o.order_id) as all_orders 

-- from employees e left join orders o on e.employee_id = o.employee_id 
-- group by e.employee_id, e.last_name order by all_orders desc),

-- late_orders as (select e.employee_id, e.last_name, count(o.order_id) as late 
-- from employees e left join orders o on e.employee_id = o.employee_id 
-- where shipped_date >  required_date
-- group by e.employee_id, e.last_name order by late desc)

-- select l.employee_id, l.last_name, a.all_orders, l.late, (1.0*l.late/a.all_orders) as PercentLateOrders
-- from late_orders l left join all_orders a on l.employee_id = a.employee_id

-- order by PercentLateOrders asc



--47

-- with all_orders as(
-- select e.employee_id, e.last_name, count(o.order_id) as all_orders 

-- from employees e left join orders o on e.employee_id = o.employee_id 
-- group by e.employee_id, e.last_name order by all_orders desc),

-- late_orders as (select e.employee_id, e.last_name, count(o.order_id) as late 
-- from employees e left join orders o on e.employee_id = o.employee_id 
-- where shipped_date >  required_date
-- group by e.employee_id, e.last_name order by late desc)

-- select l.employee_id, l.last_name, a.all_orders, l.late, round((1.0*l.late/a.all_orders),2) as PercentLateOrders
-- from late_orders l left join all_orders a on l.employee_id = a.employee_id

-- order by PercentLateOrders asc





-- with h as(

-- select  

-- c.customer_id, c.company_name, o.order_id, sum(quantity*unit_price) as TotalOrderAmount
-- from customers c 
-- join orders o on o.customer_id = c.customer_id 
-- join order_details od on od.order_id = o.order_id

-- where date(o.order_date) >='1998-01-01' and date(o.order_date) <='1999-01-01'
-- group by c.customer_id, c.company_name, o.order_id

-- -- having sum(quantity*unit_price)>15000
-- order by c.customer_id desc)

-- select customer_id, company_name, TotalOrderAmount,

-- case when TotalOrderAmount between 0 and 1000 then 'Low' 
-- when TotalOrderAmount between 1000 and 5000 then 'Medium' 
-- when TotalOrderAmount between 5000 and 10000 then 'High' 
-- when TotalOrderAmount >10000  then 'Very High'  end as CustomerGroup
-- from h

-- order by TotalOrderAmount




--50


-- with h as(

-- select  

-- c.customer_id, c.company_name, o.order_id, sum(quantity*unit_price) as TotalOrderAmount
-- from customers c 
-- join orders o on o.customer_id = c.customer_id 
-- join order_details od on od.order_id = o.order_id

-- where date(o.order_date) >='1998-01-01' and date(o.order_date) <='1999-01-01'
-- group by c.customer_id, c.company_name, o.order_id

-- order by c.customer_id desc),

-- h2 as (
-- select customer_id, TotalOrderAmount,

-- case when TotalOrderAmount between 0 and 1000 then 'Low' 
-- when TotalOrderAmount between 1000 and 5000 then 'Medium' 
-- when TotalOrderAmount between 5000 and 10000 then 'High' 
-- when TotalOrderAmount >10000  then 'Very High'  end as CustomerGroup
-- from h

-- order by TotalOrderAmount)


-- select CustomerGroup, count(customer_id) as total_in_group,

-- round(count(customer_id)*1.0/(select count(*) from h2),2) as percentage_in_group


-- from h2 group by CustomerGroup


-- 51

-- with orders_1998 AS (
--   SELECT
--     o.customerid,
--     coalesce(sum(od.unitprice * od.quantity),0) as total
--   FROM
--     orders o
--   INNER JOIN
--     order_details od on o.orderid = od.orderid
--   WHERE
--     EXTRACT(YEAR FROM o.orderdate) = 1998
--   GROUP BY
--     o.customerid
-- ), customer_groups AS (
--   SELECT
--     cgt.groupname as group
--   FROM
--     orders_1998 o
--   INNER JOIN
--     customergroupthreshold cgt ON o.total between cgt.rangebottom AND cgt.rangetop
-- ), groups_count AS (
--   SELECT
--     cg.group,
--     count(cg.group) as group_total
--   FROM
--     customer_groups cg
--   GROUP BY
--     cg.group
-- )
-- SELECT
--   gc.group,
--   gc.group_total,
--   (100*gc.group_total/(SELECT sum(group_total) FROM groups_count)) as percentage
-- FROM
--   groups_count gc
-- ORDER BY
--   gc.group_total DESC

--52


-- select distinct s.country from suppliers  s
-- union
-- select distinct c.country from customers c
-- order by country

--53
-- with countries AS (
--   SELECT
--     country
--   FROM
--     suppliers
--   UNION
--   SELECT
--     country
--   FROM
--     customers
-- ), suppliercountry AS (
--   SELECT
--     distinct country
--   FROM
--     suppliers
-- ), customercountry AS (
--   SELECT
--     distinct country
--   FROM
--     customers
-- )
-- SELECT
--   sp.country as suplier_country,
--   cp.country as customer_country
-- FROM
--   countries c
-- LEFT JOIN
--   suppliercountry sp on c.country = sp.country
-- LEFT JOIN
--   customercountry cp on c.country = cp.country


--54

-- with countries AS (
--   SELECT
--     country
--   FROM
--     suppliers
--   UNION
--   SELECT
--     country
--   FROM
--     customers
-- )


-- select c.country, coalesce(count(cp.country),0) as total_customers, 
-- coalesce(count(s.country),0) as total_suppliers from countries c left join suppliers s on s.country = c.country
-- left join customers cp on c.country = cp.country
-- group by c.country
-- order by c.country


--55
-- with h as(
-- select o.order_id, o.order_date,ship_country,customer_id,
-- row_number()over(partition by  ship_country order by  o.order_date) as row_num_per_country
-- from  orders o 
-- order by o.order_id)


-- select ship_country, customer_id,order_id,order_date from h

-- where row_num_per_country = 1
-- order by ship_country, order_id



-- select initial.customer_id, initial.order_id, initial.order_date, nexto.order_id, nexto.order_date,

-- (nexto.order_date-initial.order_date) as daysbetween
-- from orders initial join orders nexto on initial.customer_id =nexto.customer_id
-- where initial.order_id < nexto.order_id and (nexto.order_date-initial.order_date)<=5



--57

-- with h as(
-- select customer_id, order_date as initial_order_date, order_id as initial_order_id,
-- lead(order_date,1)over(partition by customer_id order by order_date) as next_order_date

-- from orders  order by customer_id,order_date )


-- select *, (co.next_order_date - co.initial_order_date) as daysbetween 
-- from h co  where (co.next_order_date - co.initial_order_date)<=5



