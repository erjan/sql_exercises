Write a query that will return all cities with more customers than the average number of  customers of all cities that have at least one customer. For each such city, return the country name,  the city name, and the number of customers


with avg_customers as(

select count(id)::float/count(distinct city_id) as avg_cust_per_city from linkedin_customers
),

cities_customers AS (
    SELECT
        country.country_name AS country,
        city.city_name AS city,
        count(customer.id) AS total_customers
    FROM linkedin_country country
    INNER JOIN linkedin_city city
        ON city.country_id = country.id
    INNER JOIN linkedin_customers customer
        ON city.id = customer.city_id
    GROUP BY 
        country.country_name,
        city.city_name   
)

select country, city,total_customers from cities_customers
where total_customers > (select avg_cust_per_city from avg_customers)
