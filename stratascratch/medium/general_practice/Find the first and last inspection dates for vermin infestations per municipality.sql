Find the first and last inspections for vermin infestations per municipality.
Output the result along with the business postal code.


select 

business_postal_code, min(inspection_date), max(inspection_date)

from sf_restaurant_health_violations
where violation_description ilike '%vermin%'
group by business_postal_code
