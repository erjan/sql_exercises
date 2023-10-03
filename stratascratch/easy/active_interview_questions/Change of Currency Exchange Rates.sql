You are given a list of exchange rates from various currencies to US Dollars (USD) in different months. Show how the exchange rate of all the currencies changed in the first half of 2020. Output the currency code and the difference between values of the exchange rate between July 1, 2020 and January 1, 2020.

select s1.source_currency, 
s2.exchange_rate - s1.exchange_rate as difference


from sf_exchange_rate s1 join sf_exchange_rate s2 
on s1.source_currency = s2.source_currency 
where s1.date= '2020-01-01' and s2.date= '2020-07-01'
