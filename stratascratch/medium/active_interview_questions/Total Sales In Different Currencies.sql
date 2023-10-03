You work for a multinational company that wants to calculate total sales across all their countries they do business in.
You have 2 tables, one is a record of sales for all countries and currencies the company deals with, and the other holds currency exchange rate information.
Calculate the total sales, per quarter, for the first 2 quarters in 2020, and report the sales in USD currency.


SELECT
    EXTRACT(QUARTER FROM s.sales_date) as quarter,
    SUM(s.sales_amount * e.exchange_rate)
FROM
    sf_sales_amount AS s JOIN sf_exchange_rate AS e
    ON (s.sales_date = e.date AND s.currency = e.source_currency)
WHERE 
    e.target_currency = 'USD'
    AND
    EXTRACT(QUARTER FROM s.sales_date) IN (1,2) and extract(year from s.sales_date) =2020
GROUP BY
    quarter
